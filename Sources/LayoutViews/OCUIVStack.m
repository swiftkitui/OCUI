//
//  OCUIVStack.m
//  OCUI
//
//  Created by 张行 on 2019/8/22.
//  Copyright © 2019 张行. All rights reserved.
//

#import "OCUIVStack.h"
#import <Masonry/Masonry.h>
#import "OCUIConstraints.h"

@implementation OCUIVStack {
    OCUIConstraints *_topConstraints;
    OCUIConstraints *_bottomConstraints;
    OCUIConstraints *_automaticViewHeightContraints;
    OCUIConstraints *_contentViewHeightContraints;
    OCUIConstraints *_automaticSpacerHeightContraints;
}

- (instancetype)init {
    if (self = [super init]) {
        _stackAlignment = OCUIHorizontalAlignmentCenter;
    }
    return self;
}

- (OCUIVStack * _Nonnull (^)(OCUIHorizontalAlignment))alignment {
    return ^OCUIVStack *(OCUIHorizontalAlignment alignment) {
        self->_stackAlignment = alignment;
        return self;
    };
}

- (void)setupContraints {
    __weak typeof(self) weakSelf = self;
    _contentViewHeightContraints = [[OCUIConstraints alloc] initWithValue:CGRectGetHeight(self.contentView.frame)];
    
    _topConstraints = [[OCUIConstraints alloc] initWithValue:0];
    _topConstraints.contraintsValueChanged = ^(CGFloat value, MASConstraint *contraints) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (!strongSelf.isCanUpdateContraints) {
            return;
        }
        contraints.offset(value);
    };
    
    _bottomConstraints = [[OCUIConstraints alloc] initWithValue:0];
    _bottomConstraints.contraintsValueChanged = ^(CGFloat value, MASConstraint *contraints) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (!strongSelf.isCanUpdateContraints) {
            return;
        }
        contraints.offset(value);
    };
    
    _automaticViewHeightContraints = [[OCUIConstraints alloc] initWithValue:0];
    _automaticViewHeightContraints.contraintsValueChanged = ^(CGFloat value, MASConstraint *contraints) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (!strongSelf.isCanUpdateContraints) {
            return;
        }
        contraints.mas_equalTo(value);
    };
    
    _automaticSpacerHeightContraints = [[OCUIConstraints alloc] initWithValue:0];
    _automaticSpacerHeightContraints.contraintsValueChanged = ^(CGFloat value, MASConstraint *contraints) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (!strongSelf.isCanUpdateContraints) {
            return;
        }
        contraints.offset(value);
    };
}

- (void)updateContraints {
    CGFloat top = [self firstOffset];
    CGFloat bottom = [self lastOffset];
    CGFloat viewHeight = CGRectGetHeight(self.contentView.frame);
    NSUInteger automaticSpacerCount = [self automaticSpacerCount];
    NSUInteger automaticRenderViewCount = [self automaticRenderViewCountWithStackType:OCUIStackTypeV];
    CGFloat intrinsicContentHeight = [self intrinsicContentHeight];
    if (automaticRenderViewCount == 0 && automaticSpacerCount == 0) {
        /// 代表两端自动适应
        if (top > 0) {
            _bottomConstraints.valueBind.wrappedContent = @(viewHeight - intrinsicContentHeight - top);
        } else if (bottom > 0) {
            _topConstraints.valueBind.wrappedContent = @(viewHeight - intrinsicContentHeight - bottom);
        } else {
            CGFloat offset = (viewHeight - intrinsicContentHeight) / 2;
            _topConstraints.valueBind.wrappedContent = @(offset);
            _bottomConstraints.valueBind.wrappedContent = @(offset);
        }
    } else if (automaticRenderViewCount > 0) {
        CGFloat height = (viewHeight - intrinsicContentHeight - top - bottom) / automaticRenderViewCount;
        _automaticViewHeightContraints.valueBind.wrappedContent = @(height);
    } else {
        CGFloat height = (viewHeight - intrinsicContentHeight - top- bottom) / automaticSpacerCount;
        _automaticSpacerHeightContraints.valueBind.wrappedContent = @(height);
    }
}

- (void)addContraints {

    CGFloat top = [_topConstraints.valueBind.wrappedContent floatValue];
    CGFloat bottom = [_bottomConstraints.valueBind.wrappedContent floatValue];
    CGFloat automaticViewHeight = [_automaticViewHeightContraints.valueBind.wrappedContent floatValue];
    CGFloat automaticSpacerHeight = [_automaticSpacerHeightContraints.valueBind.wrappedContent floatValue];
    
    __block UIView *topView = self.contentView;
    [self.nodes enumerateObjectsUsingBlock:^(id<OCUIRenderView>  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIView *view = [self viewWithRenderView:obj];
        if (!view) {
            return;
        }
        [view mas_remakeConstraints:^(MASConstraintMaker *make) {
            /// 布局位置
            if (self.stackAlignment == OCUIHorizontalAlignmentLeading) {
                make.leading.equalTo(self.contentView);
            } else if (self.stackAlignment == OCUIHorizontalAlignmentCenter) {
                make.centerX.equalTo(self.contentView);
            } else {
                make.trailing.equalTo(self.contentView);
            }
            /// 布局大小
            CGSize intrinsicContentSize = [[self viewWithRenderView:obj] intrinsicContentSize];
            if (intrinsicContentSize.width == 0 || intrinsicContentSize.height == 0) {
                /// 不支持自动布局
                CGFloat width = [self lenghtWithRenderView:obj stackType:OCUIStackTypeH];
                if (width == 0) {
                    make.width.equalTo(self.contentView);
                } else {
                    make.width.mas_equalTo(width);
                }
                CGFloat height = [self lenghtWithRenderView:obj stackType:OCUIStackTypeV];
                if (height == 0) {
                    make.height.mas_equalTo(automaticViewHeight);
                    [self->_automaticViewHeightContraints addBindViewHash:view.hash];
                } else {
                    make.height.mas_equalTo(height);
                }
            }
            
            /// 布局顶部
            if ([obj isEqual:self.nodes.firstObject]) {
                make.top.mas_offset(top);
                [self->_topConstraints addBindViewHash:view.hash];
            } else if([obj isEqual:self.nodes.lastObject]) {
                make.bottom.mas_offset(-bottom);
                [self->_bottomConstraints addBindViewHash:view.hash];
            } else {
                id<OCUIRenderView> upRenderView = self.nodes[idx - 1];
                if (!([upRenderView isKindOfClass:[OCUISpacer class]])) {
                    make.top.equalTo(topView.mas_bottom);
                } else {
                    OCUISpacer *spacer = [[OCUISpacer alloc] init];
                    if (spacer.flxedOffset) {
                        if ([topView isEqual:self.contentView]) {
                            make.top.equalTo(topView).offset(spacer.flxedOffset.value);
                        } else {
                            make.top.equalTo(topView.mas_bottom).offset(spacer.flxedOffset.value);
                        }
                    } else {
                        if ([topView isEqual:self.contentView]) {
                            make.top.equalTo(topView).offset(automaticSpacerHeight);
                        } else {
                            make.top.equalTo(topView.mas_bottom).offset(automaticSpacerHeight);
                        }
                        [self->_automaticSpacerHeightContraints addBindViewHash:view.hash];
                    }
                }
            }
        }];
        topView = view;
    }];
}

- (CGFloat)intrinsicContentHeight {
    __block CGFloat height = 0;
    [self.nodes enumerateObjectsUsingBlock:^(id<OCUIRenderView>  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[OCUISpacer class]]) {
            OCUISpacer *spacer = [[OCUISpacer alloc] init];
            height += spacer.flxedOffset.value;
        } else {
            height += [self lenghtWithRenderView:obj stackType:OCUIStackTypeV];
        }
    }];
    return height;
}


@end
