//
//  OCUIView.m
//  OCUI
//
//  Created by 张行 on 2019/8/23.
//  Copyright © 2019 张行. All rights reserved.
//

#import "OCUIView.h"

@implementation OCUIView

- (id<OCUIChained> _Nonnull (^)(UIColor * _Nonnull))backgroundColor {
    return ^id<OCUIChained>(UIColor *backgroundColor) {
        self->_viewBackgroundColor = backgroundColor;
        return self;
    };
}

- (UIView *)makeOCUIView {
    return [[UIView alloc] initWithFrame:CGRectZero];
}

- (void)configOCUIView:(UIView *)view {
    [super configOCUIView:view];
    view.backgroundColor = self.viewBackgroundColor;
}

@end
