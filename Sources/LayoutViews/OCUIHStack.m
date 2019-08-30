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
    
}

- (instancetype)init {
    if (self = [super init]) {
        _uiAlignment = OCUIVerticalAlignmentCenter;
    }
    return self;
}

- (OCUIHStack * _Nonnull (^)(OCUIVerticalAlignment))alignment {
    return ^OCUIHStack *(OCUIVerticalAlignment alignment) {
        self->_uiAlignment = alignment;
        return self;
    };
}

- (void)addAlignmentContraintsWithMake:(MASConstraintMaker *)make {
    if (self.uiAlignment == OCUIVerticalAlignmentTop) {
        make.top.equalTo(self.contentView);
    } else if (self.uiAlignment == OCUIVerticalAlignmentCenter) {
        make.centerY.equalTo(self.contentView);
    } else if(self.uiAlignment == OCUIVerticalAlignmentBottom) {
        make.bottom.equalTo(self.contentView);
    }
}

- (void)addSizeContraintsWithMake:(MASConstraintMaker *)make
                              obj:(id)obj {
    OCUINode *node = [obj ocui];
    /// 不支持自动布局
    CGFloat width = node.uiSize.width;
    if (width <= 0) {
        make.width.mas_equalTo(node.uiFloatLenght);
    } else {
        make.width.mas_equalTo(width);
    }
    CGFloat height = node.uiSize.height;
    if (height <= 0) {
        make.height.equalTo(self.contentView);
    } else {
        make.height.mas_equalTo(height);
    }
}

- (void)addOtherContraintsWithMake:(MASConstraintMaker *)make
                               obj:(id)obj {
    NSUInteger index = [self.nodes indexOfObject:obj];
    UIView *topView = [self upViewWithObj:obj];
    UIView *bottomView = [self downViewWithObj:obj];
    __block BOOL isExitLeadingFloatLayout = NO;
    /// 左侧布局
    [self makeContraintsWithMake:make isUp:YES atIndex:index block:^(CGFloat flxedOffset) {
        if (flxedOffset != NSNotFound) {
            if ([topView isEqual:self.contentView]) {
                make.leading.equalTo(topView).offset(flxedOffset);
            } else {
                make.leading.equalTo(topView.mas_trailing).offset(flxedOffset);
            }
        } else {
            isExitLeadingFloatLayout = YES;
            OCUINode *node = [self.nodes[index - 1] ocui];
            if ([topView isEqual:self.contentView]) {
                make.leading.greaterThanOrEqualTo(topView).offset(node.uiFloatLenght);
            } else {
                make.leading.greaterThanOrEqualTo(topView.mas_trailing).offset(node.uiFloatLenght);
            }
        }
    }];
    [self makeContraintsWithMake:make isUp:NO atIndex:index block:^(CGFloat flxedOffset) {
        OCUINode *node = [self.nodes[index + 1] ocui];
        flxedOffset = flxedOffset == NSNotFound ? node.uiFloatLenght : flxedOffset;
        if (isExitLeadingFloatLayout) {
            if ([bottomView isEqual:self.contentView]) {
                make.trailing.equalTo(bottomView).offset(-flxedOffset);
            } else {
                make.trailing.equalTo(bottomView.mas_leading).offset(-flxedOffset);
            }
        }
    }];
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
            if (node.uiSize.width > 0) {
                width += node.uiSize.width;
            } else if (intrinsicContentSize.width > 0) {
                width += intrinsicContentSize.width;
            }
        }
    }];
    return width;
}

- (CGFloat)contentLenght {
    return CGRectGetWidth(self.contentView.frame);
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
