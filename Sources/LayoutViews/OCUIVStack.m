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
                              obj:(id)obj {
    OCUINode *node = [obj ocui];
    /// 不支持自动布局
    CGFloat height = node.uiSize.height;
    if (height <= 0) {
        make.height.mas_equalTo(node.uiFloatLenght);
    } else {
        make.height.mas_equalTo(height);
    }
    CGFloat width = node.uiSize.width;
    if (height <= 0) {
        make.width.equalTo(self.contentView);
    } else {
        make.width.mas_equalTo(width);
    }
}

- (void)addOtherContraintsWithMake:(MASConstraintMaker *)make
                               obj:(id)obj {
    NSUInteger index = [self.nodes indexOfObject:obj];
    [self makeContraintsWithMake:make
                            isUp:YES
                         atIndex:index];
    [self makeContraintsWithMake:make
                            isUp:NO
                         atIndex:index];
}

- (void)makeContraintsWithMake:(MASConstraintMaker *)make
                          isUp:(BOOL)isUp
                       atIndex:(NSUInteger)index {
    id dependObj;
    if (isUp) {
        dependObj = self.nodes[index - 1];
    } else {
        dependObj = self.nodes[index + 1];
    }
    UIView *topView = [self upViewWithObj:self.nodes[index]];
    UIView *bottomView = [self downViewWithObj:self.nodes[index]];
    /// 如果上一个不是OCUISpacer 说明位置是紧紧挨着的
    if (!([dependObj isKindOfClass:[OCUISpacer class]])) {
        if (isUp) {
            make.top.equalTo(topView.mas_bottom);
        } else {
            make.bottom.equalTo(bottomView.mas_top);
        }
    } else {
        OCUISpacer *spacer = (OCUISpacer *)dependObj;
        OCUINode *node = [spacer ocui];
        /// 如果存在写死的间距
        if (spacer.flxedOffset) {
            if (isUp) {
                if ([topView isEqual:self.contentView]) {
                    make.top.equalTo(topView).offset(spacer.flxedOffset.value);
                } else {
                    make.top.equalTo(topView.mas_bottom).offset(spacer.flxedOffset.value);
                }
            } else {
                if ([bottomView isEqual:self.contentView]) {
                    make.bottom.equalTo(bottomView).offset(-spacer.flxedOffset.value);
                } else {
                    make.bottom.equalTo(bottomView.mas_top).offset(-spacer.flxedOffset.value);
                }
            }
        } else {
            /// 右侧采用浮动布局 就优先压缩
            if (!isUp) {
                if ([bottomView isEqual:self.contentView]) {
                    make.bottom.equalTo(bottomView).offset(-node.uiFloatLenght);
                } else {
                    [bottomView setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
                    make.bottom.equalTo(bottomView.mas_top).offset(-node.uiFloatLenght);
                }
            }
        }
    }
}

- (CGFloat)intrinsicContentLenght {
    __block CGFloat width = 0;
    [self.nodes enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        OCUINode *node = [obj ocui];
        if ([obj isKindOfClass:[OCUISpacer class]]) {
            OCUISpacer *spacer = (OCUISpacer *)obj;
            width += spacer.flxedOffset.value;
        } else  {
            UIView *view = [self viewWithObj:obj];
            CGSize intrinsicContentSize = [view intrinsicContentSize];
            if (node.uiSize.height > 0) {
                width += node.uiSize.height;
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
    return [self findNodesWithBlock:^BOOL(id  _Nonnull obj) {
        if ([obj isKindOfClass:[OCUISpacer class]]) {
            return NO;
        }
        OCUINode *node = [obj ocui];
        UIView *makeView = [self viewWithObj:obj];
        if (node.uiSize.width > 0) {
            return NO;
        }
        if (makeView.intrinsicContentSize.width > 0) {
            return NO;
        }
        return YES;
    }];
}

@end
