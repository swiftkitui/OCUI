//
//  OCUINode.m
//  OCUI
//
//  Created by 张行 on 2019/8/22.
//  Copyright © 2019 张行. All rights reserved.
//

#import "OCUINode.h"

@implementation OCUINode {
    CGFloat _width;
    CGFloat _height;
}

#pragma mark - OCUIRenderView

- (instancetype)init {
    if (self= [super init]) {
        _viewPriority = 1000;
    }
    return self;
}

- (UIView *)makeOCUIView {
    return nil;
}

- (void)configOCUIView:(UIView *)view {}

- (CGSize)renderSize {
    return CGSizeMake(_width, _height);
}

#pragma mark - OCUIChained
- (id<OCUIChained>  _Nonnull (^)(CGFloat))width {
    return ^id<OCUIChained>(CGFloat width) {
        self->_width = width;
        return self;
    };
}

- (id<OCUIChained>  _Nonnull (^)(CGFloat))height {
    return ^id<OCUIChained>(CGFloat height) {
        self->_height = height;
        return self;
    };
}

- (id<OCUIChained>  _Nonnull (^)(CGSize))size {
    return ^id<OCUIChained>(CGSize size) {
        self->_width = size.width;
        self->_height = size.height;
        return self;
    };
}

- (id<OCUIChained>  _Nonnull (^)(CGFloat))offset {
    return ^id<OCUIChained>(CGFloat offset) {
        return self;
    };
}

- (id<OCUIChained>  _Nonnull (^)(CombineBind * _Nonnull))bind {
    return ^id<OCUIChained>(CombineBind *bind) {
        return self;
    };
}

- (id<OCUIChained>  _Nonnull (^)(UIColor * _Nonnull))backgroundColor {
    return ^id<OCUIChained>(UIColor *backgroundColor) {
        return self;
    };
}

- (id<OCUIChained>  _Nonnull (^)(UIImage * _Nonnull))image {
    return ^id<OCUIChained>(UIImage *image) {
        return self;
    };
}

- (id<OCUIChained>  _Nonnull (^)(CGFloat))priority {
    return ^id<OCUIChained>(CGFloat priority) {
        self->_viewPriority = priority;
        return self;
    };
}

@end
