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

@implementation OCUIVStack

- (instancetype)init {
    if (self = [super init]) {
        _uiAlignment = OCUIHorizontalAlignmentCenter;
    }
    return self;
}

- (OCUIVStack * _Nonnull (^)(OCUIHorizontalAlignment))alignment {
    return ^OCUIVStack *(OCUIHorizontalAlignment alignment) {
        self->_uiAlignment = alignment;
        return self;
    };
}

- (void)addAlignmentContraintsWithMake:(MASConstraintMaker *)make {
    if (self.uiAlignment == OCUIHorizontalAlignmentLeading) {
        make.leading.equalTo(self.contentView);
    } else if (self.uiAlignment == OCUIHorizontalAlignmentCenter) {
        make.centerX.equalTo(self.contentView);
    } else if(self.uiAlignment == OCUIHorizontalAlignmentTrailing) {
        make.trailing.equalTo(self.contentView);
    }
}

- (void)addSizeContraintsWithMake:(MASConstraintMaker *)make
                              obj:(OCUINode *)obj {
    /// 不支持自动布局
    CGFloat height = obj.uiSize.height;
    if (height <= 0) {
        MASConstraint *contraints = make.height.mas_equalTo(obj.uiFloatLenght);
        obj.uiFloatLenghtContraints.addBindViewContraints(contraints);
        obj.uiFloatLenghtContraints.contraintsValueChanged = ^(CGFloat value, MASConstraint * _Nonnull contraints) {
            contraints.mas_equalTo(value);
        };
    } else {
        make.height.mas_equalTo(height);
    }
    CGFloat width = obj.uiSize.width;
    if (width <= 0) {
        make.width.equalTo(self.contentView);
    } else {
        make.width.mas_equalTo(width);
    }
}

- (void)addOtherContraintsWithMake:(MASConstraintMaker *)make
                               obj:(OCUINode *)obj {
    NSUInteger index = [self.nodes indexOfObject:obj];
    UIView *topView = [self upViewWithObj:obj];
    UIView *bottomView = [self downViewWithObj:obj];
    __block BOOL isExitTopFloatLayout = NO;
    /// 左侧布局
    [self makeContraintsWithMake:make isUp:YES atIndex:index block:^(CGFloat flxedOffset) {
        if (flxedOffset != NSNotFound) {
            if ([topView isEqual:self.contentView]) {
                make.top.equalTo(topView).offset(flxedOffset);
            } else {
                make.top.equalTo(topView.mas_bottom).offset(flxedOffset);
            }
        } else {
            isExitTopFloatLayout = YES;
            OCUINode *node = self.nodes[index - 1];
            MASConstraint *contraints;
            if ([topView isEqual:self.contentView]) {
                contraints = make.top.greaterThanOrEqualTo(topView).offset(node.uiFloatLenght);
            } else {
                contraints = make.top.greaterThanOrEqualTo(topView.mas_bottom).offset(node.uiFloatLenght);
            }
            node.uiFloatLenghtContraints.addBindViewContraints(contraints);
            node.uiFloatLenghtContraints.contraintsValueChanged = ^(CGFloat value, MASConstraint * _Nonnull contraints) {
                contraints.offset(value);
            };
        }
    }];
    [self makeContraintsWithMake:make isUp:NO atIndex:index block:^(CGFloat flxedOffset) {
        OCUINode *node = self.nodes[index + 1];
        CGFloat bottomOffset = flxedOffset;
        if (flxedOffset == NSNotFound) {
            bottomOffset = node.uiFloatLenght;
        }
        MASConstraint *contraints;
        if (isExitTopFloatLayout) {
            if ([bottomView isEqual:self.contentView]) {
                contraints = make.bottom.equalTo(bottomView).offset(-bottomOffset);
            } else {
                contraints = make.bottom.equalTo(bottomView.mas_top).offset(-bottomOffset);
            }
            if (flxedOffset == NSNotFound) {
                node.uiFloatLenghtContraints.addBindViewContraints(contraints);
                node.uiFloatLenghtContraints.contraintsValueChanged = ^(CGFloat value, MASConstraint * _Nonnull contraints) {
                    contraints.offset(-value);
                };
            }
        }
    }];
}

- (CGFloat)intrinsicContentLenght {
    __block CGFloat width = 0;
    [self.nodes enumerateObjectsUsingBlock:^(OCUINode *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[OCUISpacer class]]) {
            OCUISpacer *spacer = (OCUISpacer *)obj;
            width += spacer.flxedOffset.value;
        } else  {
            UIView *view = [self viewWithObj:obj];
            CGSize intrinsicContentSize = [view intrinsicContentSize];
            if (obj.uiSize.height > 0) {
                width += obj.uiSize.height;
            } else if (intrinsicContentSize.height > 0) {
                width += intrinsicContentSize.height;
            }
        }
    }];
    return width;
}

- (CGFloat)contentLenght {
    return CGRectGetHeight(self.contentView.frame);
}

- (NSArray *)getCurrentAllFloatRenderViews {
    return [self findNodesWithBlock:^BOOL(OCUINode *  _Nonnull obj) {
        if ([obj isKindOfClass:[OCUISpacer class]]) {
            return NO;
        }
        UIView *makeView = [self viewWithObj:obj];
        if (obj.uiSize.height > 0) {
            return NO;
        }
        if (makeView.intrinsicContentSize.height > 0) {
            return NO;
        }
        return YES;
    }];
}

- (CGSize)intrinsicContentSize {
    return CGSizeMake([self maxIntrinsicContentSizeWidth], [self maxIntrinsicContentSizeHeight]);
}

- (CGFloat)maxIntrinsicContentSizeWidth {
    __block CGFloat maxIntrinsicContentSizeWidth = 0;
    [self.nodes enumerateObjectsUsingBlock:^(OCUINode *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.uiSize.width > 0) {
            maxIntrinsicContentSizeWidth = MAX(maxIntrinsicContentSizeWidth, obj.uiSize.width);
        } else {
            UIView *view = [self viewWithObj:obj];
            if (view.intrinsicContentSize.width > 0) {
                maxIntrinsicContentSizeWidth = MAX(maxIntrinsicContentSizeWidth, view.intrinsicContentSize.width);
            }
        }
    }];
    return maxIntrinsicContentSizeWidth;
}

- (CGFloat)maxIntrinsicContentSizeHeight {
    __block CGFloat maxIntrinsicContentSizeHeight = 0;
    [self.nodes enumerateObjectsUsingBlock:^(OCUINode *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.uiSize.height > 0) {
            maxIntrinsicContentSizeHeight += obj.uiSize.height;
        } else {
            UIView *view = [self viewWithObj:obj];
            if (view.intrinsicContentSize.height > 0) {
                maxIntrinsicContentSizeHeight += view.intrinsicContentSize.height;
            }
        }
    }];
    return maxIntrinsicContentSizeHeight;
}

@end
