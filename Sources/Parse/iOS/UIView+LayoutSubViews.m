//
//  UIView+LayoutSubViews.m
//  OCUIExample
//
//  Created by 张行 on 2019/9/6.
//  Copyright © 2019 张行. All rights reserved.
//

#import "UIView+LayoutSubViews.h"
#import <objc/runtime.h>
#import "OCUILayoutItem.h"

@implementation UIView (LayoutSubViews)

+ (void)load {
    Method layoutSubviews = class_getInstanceMethod(self, @selector(layoutSubviews));
    Method ocuiLayoutSubviews = class_getInstanceMethod(self, @selector(ocuiLayoutSubviews));
    method_exchangeImplementations(layoutSubviews, ocuiLayoutSubviews);
}

- (void)ocuiLayoutSubviews {
    [self ocuiLayoutSubviews];
    CGFloat width = CGRectGetWidth(self.frame);
    if (self.intrinsicContentSize.width >= 0) {
        width = self.intrinsicContentSize.width;
    }
    [self.widthLayoutItem updateValue:width];
    CGFloat height = CGRectGetHeight(self.frame);
    if (self.intrinsicContentSize.height >= 0) {
        height = self.intrinsicContentSize.height;
    }
    [self.heightLayoutItem updateValue:height];
}


@end
