//
//  OCUIView.m
//  OCUI
//
//  Created by 张行 on 2019/8/23.
//  Copyright © 2019 张行. All rights reserved.
//

#import "OCUIView.h"

@implementation OCUIView

- (OCUIView * _Nonnull (^)(UIColor * _Nonnull))backgroundColor {
    return ^OCUIView *(UIColor *backgroundColor) {
        self->_viewBackgroundColor = backgroundColor;
        return self;
    };
}

- (OCUIView * _Nonnull (^)(CGSize))size {
    return ^OCUIView *(CGSize size) {
        self->_viewSize = size;
        return self;
    };
}

- (UIView *)makeOCUIView {
    UIView *view = [[UIView alloc] initWithFrame:CGRectZero];
    view.backgroundColor = self.viewBackgroundColor;
    return view;
}

- (CGSize)renderSize {
    return self->_viewSize;
}

@end
