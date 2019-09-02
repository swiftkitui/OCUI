//
//  OCUIView.m
//  OCUI
//
//  Created by 张行 on 2019/8/23.
//  Copyright © 2019 张行. All rights reserved.
//

#import "OCUIView.h"

@implementation OCUIView

- (instancetype(^)(UIColor * _Nonnull))backgroundColor {
    return ^OCUIView *(UIColor *backgroundColor) {
        self->_uiBackgroundColor = backgroundColor;
        return self;
    };
}

- (UIView *)makeOCUIView {
    return [[UIView alloc] initWithFrame:CGRectZero];
}

- (void)configOCUIView:(UIView *)view {
    [super configOCUIView:view];
    if (self.uiBackgroundColor) {
        view.backgroundColor = self.uiBackgroundColor;
    }
    
}

@end

