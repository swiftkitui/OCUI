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
    CGFloat leading = [self firstOffset];
    CGFloat trailing = [self lastOffset];
    CGFloat viewWidth = CGRectGetWidth(self.contentView.frame);
    NSUInteger automaticSpacerCount = [self automaticSpacerCount];
    /// 如果有自动撑满的UIView 则 Spancer 失效
    NSUInteger automaticRenderViewCount = [self automaticRenderViewCountWithStackType:OCUIStackTypeH];
    CGFloat intrinsicContentWidth = [self intrinsicContentWidth];
    if (automaticRenderViewCount > 0) {
        CGFloat height = (viewWidth - intrinsicContentWidth - leading - trailing) / automaticRenderViewCount;
        _automaticViewWidthContraints.valueBind.wrappedContent = @(height);
    } else if (automaticSpacerCount > 0) {
        /// 设置自动布局的宽度初始值为0
        CGFloat automaticSpacerWidth = 0;
        /// 试图的宽度 - 最大自动大小的宽度 等于浮动的宽度
        CGFloat floatWidth = viewWidth - intrinsicContentWidth;
        CGFloat minSpacerWidth = [self minSpacerWidth];
        if (floatWidth >= minSpacerWidth) {
            
        } else {
            
        }
        _automaticSpacerWidthContraints.valueBind.wrappedContent = @(automaticSpacerWidth);
    }
}

- (void)addContraints {
    CGFloat automaticViewWidth = [_automaticViewWidthContraints.valueBind.wrappedContent floatValue];
    CGFloat automaticSpacerWidth = [_automaticSpacerWidthContraints.valueBind.wrappedContent floatValue];
    
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
                if (width == 0) {
                    MASConstraint *contraints = make.width.mas_equalTo(automaticViewWidth);
                    self->_automaticSpacerWidthContraints.addBindViewContraints(contraints);
                } else {
                    make.width.mas_equalTo(width);
                }
                CGFloat height = [self lenghtWithRenderView:obj stackType:OCUIStackTypeV];
                if (height == 0) {
                    make.height.equalTo(self.contentView);
                } else {
                    make.height.mas_equalTo(height);
                }
            }
            
            id<OCUIRenderView> upRenderView = self.nodes[idx - 1];
            id<OCUIRenderView> nextRenderView = self.nodes[idx + 1];
            /// 如果上一个不是OCUISpacer 说明位置是紧紧挨着的
            if (!([upRenderView isKindOfClass:[OCUISpacer class]])) {
                make.leading.equalTo(leadingView.mas_trailing);
            } else {
                OCUISpacer *spacer = (OCUISpacer *)upRenderView;
                /// 如果存在写死的间距
                if (spacer.lenghtOffset) {
                    if ([leadingView isEqual:self.contentView]) {
                        make.leading.equalTo(leadingView).offset(spacer.lenghtOffset.height);
                    } else {
                        make.leading.equalTo(leadingView.mas_trailing).offset(spacer.lenghtOffset.height);
                    }
                    if ([nextRenderView isKindOfClass:[OCUISpacer class]] && isUseIntrinsicContentSize) {
                        OCUISpacer *nextSpacer = (OCUISpacer *)nextRenderView;
                        UIView *trailingView = [self findNextAutolayoutViewWithIndex:idx] ?: self.contentView;
                        make.trailing.lessThanOrEqualTo(trailingView.mas_leading).offset(nextSpacer.minSpancer);
                    }
                } else {
                    /// 布局可变的
                    
                }
            }
        }];
        leadingView = view;
    }];
}

- (OCUISpacer *)nextFloatRenderViewWithIndex:(NSUInteger)index {
    __block OCUISpacer *nextFloatRenderView;
    [self.nodes enumerateObjectsUsingBlock:^(id<OCUIRenderView>  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx == (index + 1) && [obj isKindOfClass:[OCUISpacer class]]) {
            OCUISpacer *spacer = (OCUISpacer *)obj;
            if (!spacer.lenghtOffset) {
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
        if (idx > index && makeView) {
            view = makeView;
        }
    }];
    return view;
}

- (CGFloat)intrinsicContentWidth {
    __block CGFloat width = 0;
    [self.nodes enumerateObjectsUsingBlock:^(id<OCUIRenderView>  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[OCUISpacer class]] && ![obj isEqual:self.nodes.firstObject] && ![obj isEqual:self.nodes.lastObject]) {
            OCUISpacer *spacer = (OCUISpacer *)obj;
            width += spacer.lenghtOffset.height;
        } else if (![obj isKindOfClass:[OCUISpacer class]]) {
            width += [self lenghtWithRenderView:obj stackType:OCUIStackTypeH];
        }
    }];
    return width;
}

- (CGFloat)flxedWidth {
    __block CGFloat width = 0;
    [self.nodes enumerateObjectsUsingBlock:^(id<OCUIRenderView>  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[OCUISpacer class]]) {
            OCUISpacer *spacer = (OCUISpacer *)obj;
            if (spacer.lenghtOffset) {
                width += spacer.lenghtOffset.height;
            }
        } else if([obj isKindOfClass:[OCUINode class]]) {
            OCUINode *node = (OCUINode *)obj;
            if (node.viewPriority == 1000) {
                width += [self lenghtWithRenderView:obj stackType:OCUIStackTypeH];
            }
        }
    }];
    return width;
}

- (CGFloat)minSpacerWidth {
    __block CGFloat width = 0;
    [self.nodes enumerateObjectsUsingBlock:^(id<OCUIRenderView>  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (![obj isKindOfClass:[OCUISpacer class]]) {
            return;
        }
        OCUISpacer *spacer = (OCUISpacer *)obj;
        width += spacer.minSpancer;
    }];
    return width;
}

@end
