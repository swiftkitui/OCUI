//
//  OCUIView.m
//  OCUI
//
//  Created by 张行 on 2019/8/23.
//  Copyright © 2019 张行. All rights reserved.
//

#import "OCUIView.h"

@implementation OCUIView

- (UIView *)makeOCUIView {
    return [[UIView alloc] initWithFrame:CGRectZero];
}

- (void)configOCUIView:(UIView *)view {
    [super configOCUIView:view];
    if (self.ocui.uiBackgroundColor) {
        view.backgroundColor = self.ocui.uiBackgroundColor;
    }
}

@end

