//
//  OCUIHStack.m
//  OCUI
//
//  Created by 张行 on 2019/8/22.
//  Copyright © 2019 张行. All rights reserved.
//

#import "OCUIHStack.h"
#import "OCUIConstraints.h"
#import <Masonry/Masonry.h>

@implementation OCUIHStack {
    OCUIConstraints *_leadingConstraints;
    OCUIConstraints *_trailingConstraints;
    OCUIConstraints *_contentViewWidthContraints;
    OCUIConstraints *_automaticViewWidthContraints;
    OCUIConstraints *_automaticSpacerWidthContraints;
}

- (instancetype)init {
    if (self = [super init]) {
        _stackAlignment = OCUIVerticalAlignmentCenter;
    }
    return self;
}

- (OCUIHStack * _Nonnull (^)(OCUIVerticalAlignment))alignment {
    return ^OCUIHStack *(OCUIVerticalAlignment alignment) {
        self->_stackAlignment = alignment;
        return self;
    };
}

- (void)setupContraints {
    __weak typeof(self) weakSelf = self;
    _contentViewWidthContraints = [[OCUIConstraints alloc] initWithValue:CGRectGetWidth(self.contentView.frame)];
    
    _leadingConstraints = [[OCUIConstraints alloc] initWithValue:0];
    _leadingConstraints.contraintsValueChanged = ^(CGFloat value, MASConstraint *contraints) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (!strongSelf.isCanUpdateContraints) {
            return;
        }
        contraints.offset(value);
    };
    
    _trailingConstraints = [[OCUIConstraints alloc] initWithValue:0];
    _trailingConstraints.contraintsValueChanged = ^(CGFloat value, MASConstraint *contraints) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (!strongSelf.isCanUpdateContraints) {
            return;
        }
        contraints.offset(value);
    };
    
    _automaticViewWidthContraints = [[OCUIConstraints alloc] initWithValue:0];
    _automaticViewWidthContraints.contraintsValueChanged = ^(CGFloat value, MASConstraint *contraints) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (!strongSelf.isCanUpdateContraints) {
            return;
        }
        contraints.mas_equalTo(value);
    };
    
    _automaticSpacerWidthContraints = [[OCUIConstraints alloc] initWithValue:0];
    _automaticSpacerWidthContraints.contraintsValueChanged = ^(CGFloat value, MASConstraint *contraints) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (!strongSelf.isCanUpdateContraints) {
            return;
        }
        contraints.offset(value);
    };
}

- (void)updateContraints {
    CGFloat viewWidth = CGRectGetWidth(self.contentView.frame);
    /// 获取自动 Spacer 的个数
    NSUInteger automaticSpacerCount = self.allFloatSpacers.count;
    /// 如果有自动撑满的UIView 则 Spancer 失效
    NSUInteger automaticRenderViewCount = [self automaticRenderViewCountWithStackType:OCUIStackTypeH];
    CGFloat intrinsicContentWidth = [self intrinsicContentWidth];
    /// 试图的宽度 - 最大自动大小的宽度 等于浮动的宽度
    CGFloat floatWidth = viewWidth - intrinsicContentWidth;
    if (automaticRenderViewCount > 0) {
        /// 如果可以浮动的宽度此时 小于或者等于最小的间隙 就按照最小的间隙来
        [self updateFloatHeightWithMin:[self minViewFloatOffset]
                                   max:[self maxViewFloatOffset]
                            floatWidth:floatWidth
                            floatNodes:[self allFloatViews]];
    } else if (automaticSpacerCount > 0) {
        /// 如果可以浮动的宽度此时 小于或者等于最小的间隙 就按照最小的间隙来
        [self updateFloatHeightWithMin:self.minSpacerFloatOffset
                                   max:self.maxSpacerFloatOffset
                            floatWidth:floatWidth
                            floatNodes:self.allFloatSpacers];
    }
}

- (void)updateFloatHeightWithMin:(CGFloat)min
                             max:(CGFloat)max
                      floatWidth:(CGFloat)floatWidth
                      floatNodes:(NSArray<OCUINode *> *)floatNodes {
    /// 如果可以浮动的宽度此时 小于或者等于最小的间隙 就按照最小的间隙来
    if (floatWidth <= min) {
        [floatNodes enumerateObjectsUsingBlock:^(OCUINode * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            obj.updateFloatOffset(obj.minFloatOffset);
        }];
    } else if (floatWidth > self.minSpacerFloatOffset && floatWidth < self.maxSpacerFloatOffset) {
        /// 如果大于最小间隙 并且小于最大平均值 先入顺序 优先满足
        [self updateSpacerOffsetWithNodes:self.allFloatSpacers floatWidth:floatWidth];
    } else {
        /// 如果满足平分就平分
        CGFloat averageOffset = floatWidth * 1.0 / self.allFloatSpacers.count;
        [floatNodes enumerateObjectsUsingBlock:^(OCUINode * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            obj.updateFloatOffset(averageOffset);
        }];
    }
}

/**
 按照设置的优先级进行设置 如果优先级一样 按照第一个优先级最高

 @param nodes 剩余进行优先级布局的 Spacer
 @param floatWidth 剩余浮动布局的宽度
 */
- (void)updateSpacerOffsetWithNodes:(NSArray<OCUINode *> *)nodes
                           floatWidth:(CGFloat)floatWidth {
    if (nodes.count == 0 || floatWidth <= 0) {
        return;
    }
    __block OCUINode *node;
    NSMutableArray<OCUINode *> *tempSpacers = [NSMutableArray arrayWithArray:nodes];
    [tempSpacers enumerateObjectsUsingBlock:^(OCUINode *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (!nodes) {
            node = obj;
            return;
        }
        if (obj.viewPriority >= node.viewPriority) {
            node = obj;
        }
    }];
    CGFloat updateOffset = 0;
    if (nodes.count == 1) {
        updateOffset = MAX(floatWidth, node.minFloatOffset);
    } else {
        updateOffset = node.minFloatOffset;
    }
    node.updateFloatOffset(updateOffset);
    [tempSpacers removeObject:node];
    floatWidth -= updateOffset;
    [self updateSpacerOffsetWithNodes:tempSpacers floatWidth:floatWidth];
}

- (void)addContraints {
    __block UIView *leadingView = self.contentView;
    [self.nodes enumerateObjectsUsingBlock:^(id<OCUIRenderView>  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIView *view = [self viewWithRenderView:obj];
        if (!view) {
            return;
        }
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            /// 布局位置
            if (self.stackAlignment == OCUIVerticalAlignmentTop) {
                make.top.equalTo(self.contentView);
            } else if (self.stackAlignment == OCUIVerticalAlignmentCenter) {
                make.centerY.equalTo(self.contentView);
            } else {
                make.bottom.equalTo(self.contentView);
            }
            
            /// 布局大小
            CGSize intrinsicContentSize = [[self viewWithRenderView:obj] intrinsicContentSize];
            BOOL isUseIntrinsicContentSize = intrinsicContentSize.width > 0 && intrinsicContentSize.height > 0;
            /// 如果支持自动布局 则按照自动布局计算
            if (!isUseIntrinsicContentSize) {
                /// 不支持自动布局
                CGFloat width = [self lenghtWithRenderView:obj stackType:OCUIStackTypeH];
                if (width <= 0) {
                    OCUINode *node = (OCUINode *)obj;
                    make.width.mas_equalTo(node.currentFloatOffset);
                } else {
                    make.width.mas_equalTo(width);
                }
                CGFloat height = [self lenghtWithRenderView:obj stackType:OCUIStackTypeV];
                if (height <= 0) {
                    make.height.equalTo(self.contentView);
                } else {
                    make.height.mas_equalTo(height);
                }
            }
            [self makeContraintsWithMake:make
                                    isUp:YES
                                 atIndex:idx
                                 topView:leadingView];
            [self makeContraintsWithMake:make
                                    isUp:NO
                                 atIndex:idx
                                 topView:leadingView];
    
        }];
        leadingView = view;
    }];
}

- (void)makeContraintsWithMake:(MASConstraintMaker *)make
                          isUp:(BOOL)isUp
                       atIndex:(NSUInteger)index
                       topView:(UIView *)topView {
    id<OCUIRenderView> renderView;
    if (isUp) {
        renderView = self.nodes[index - 1];
    } else {
        renderView = self.nodes[index + 1];
    }
    /// 如果上一个不是OCUISpacer 说明位置是紧紧挨着的
    if (!([renderView isKindOfClass:[OCUISpacer class]])) {
        if (isUp) {
            make.leading.equalTo(topView.mas_trailing);
        } else {
            UIView *trailingView = [self findNextAutolayoutViewWithIndex:index];
            make.trailing.equalTo(trailingView.mas_leading);
        }
    } else {
        OCUISpacer *spacer = (OCUISpacer *)renderView;
        /// 如果存在写死的间距
        if (spacer.flxedOffset) {
            if (isUp) {
                if ([topView isEqual:self.contentView]) {
                    make.leading.equalTo(topView).offset(spacer.flxedOffset.value);
                } else {
                    make.leading.equalTo(topView.mas_trailing).offset(spacer.flxedOffset.value);
                }
            } else {
                UIView *trailingView = [self findNextAutolayoutViewWithIndex:index] ?: self.contentView;
                if ([trailingView isEqual:self.contentView]) {
                    make.trailing.equalTo(trailingView).offset(-spacer.flxedOffset.value);
                } else {
                    make.trailing.equalTo(trailingView.mas_leading).offset(-spacer.flxedOffset.value);
                }
            }
        } else {
            /// 右侧采用浮动布局 就优先压缩
            if (!isUp) {
                UIView *trailingView = [self findNextAutolayoutViewWithIndex:index] ?: self.contentView;
                if ([trailingView isEqual:self.contentView]) {
                    make.trailing.lessThanOrEqualTo(trailingView).offset(-spacer.currentFloatOffset);
                } else {
                    [trailingView setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
                    make.trailing.lessThanOrEqualTo(trailingView.mas_leading).offset(-spacer.currentFloatOffset);
                }
                UIView *sourceView = [self viewWithRenderView:self.nodes[index]];
                [spacer addFloatLayoutWithSourceView:sourceView
                                        trailingView:trailingView
                                               block:^(OCUINode * _Nonnull node) {
                                                   [node.sourceView mas_updateConstraints:^(MASConstraintMaker *make) {
                                                       if ([node.floatTrailingView isEqual:self.contentView]) {
                                                           make.trailing.lessThanOrEqualTo(node.floatTrailingView).offset(-node.currentFloatOffset);
                                                       } else {
                                                           make.trailing.lessThanOrEqualTo(node.floatTrailingView.mas_leading).offset(-node.currentFloatOffset);
                                                       }
                                                   }];
                                               }];
            }
        }
    }
}


- (OCUISpacer *)nextFloatRenderViewWithIndex:(NSUInteger)index {
    __block OCUISpacer *nextFloatRenderView;
    [self.nodes enumerateObjectsUsingBlock:^(id<OCUIRenderView>  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx == (index + 1) && [obj isKindOfClass:[OCUISpacer class]]) {
            OCUISpacer *spacer = (OCUISpacer *)obj;
            if (!spacer.flxedOffset) {
                nextFloatRenderView = spacer;
            }
        }
    }];
    return nextFloatRenderView;
}

- (UIView *)findNextAutolayoutViewWithIndex:(NSUInteger)index {
    __block UIView *view;
    [self.nodes enumerateObjectsUsingBlock:^(id<OCUIRenderView>  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIView *makeView = [self viewWithRenderView:obj];
        if (idx > index && makeView && !view) {
            view = makeView;
        }
    }];
    return view;
}

- (CGFloat)intrinsicContentWidth {
    __block CGFloat width = 0;
    [self.nodes enumerateObjectsUsingBlock:^(id<OCUIRenderView>  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[OCUISpacer class]]) {
            OCUISpacer *spacer = (OCUISpacer *)obj;
            width += spacer.flxedOffset.value;
        } else if (![obj isKindOfClass:[OCUISpacer class]]) {
            width += [self lenghtWithRenderView:obj stackType:OCUIStackTypeH];
        }
    }];
    return width;
}

- (NSArray<OCUINode *> *)allFloatViews {
    return (NSArray<OCUINode *> *)[self findNodesWithBlock:^BOOL(id<OCUIRenderView>  _Nonnull obj) {
        if (![obj isKindOfClass:[OCUINode class]]) {
            return NO;
        }
        OCUINode *node = (OCUINode *)obj;
        if ([node renderSize].width > 0) {
            return NO;
        }
        UIView *makeView = [self viewWithRenderView:node];
        if (!makeView) {
            return NO;
        }
        if (makeView.intrinsicContentSize.width > 0) {
            return NO;
        }
        return YES;
    }];
}

- (CGFloat)minViewFloatOffset {
    __block CGFloat offset = 0;
    [[self allFloatViews] enumerateObjectsUsingBlock:^(OCUINode * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        offset += obj.minFloatOffset;
    }];
    return offset;
}

- (CGFloat)maxViewFloatOffset {
    __block CGFloat maxOffset = 0;
    [[self allFloatViews] enumerateObjectsUsingBlock:^(OCUINode * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.minFloatOffset > maxOffset) {
            maxOffset = obj.minFloatOffset;
        }
    }];
    return (maxOffset * [self allFloatViews].count);
}

- (BOOL)isExitFloatView {
    return [self allFloatViews].count > 0;
}

@end
