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
    void(^_floatLayoutBlock)(OCUINode *);
}
@synthesize currentFloatOffset = _currentFloatOffset;
#pragma mark - OCUIRenderView

- (instancetype)init {
    if (self= [super init]) {
        _viewPriority = 1000;
    }
    return self;
}

- (CGFloat)currentFloatOffset {
    return MAX(_currentFloatOffset, _minFloatOffset);
}

- (void)addFloatLayoutWithSourceView:(UIView *)sourceView
                        trailingView:(UIView *)trailingView
                               block:(void(^)(OCUINode *))block {
    _floatTrailingView = trailingView;
    _floatLayoutBlock = block;
    _sourceView = sourceView;
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

- (id<OCUIChained> _Nonnull (^)(CGFloat))offset {
    return ^id<OCUIChained>(CGFloat offset) {
        return self;
    };
}

- (id<OCUIChained> _Nonnull (^)(CombineBind * _Nonnull))bind {
    return ^id<OCUIChained>(CombineBind *bind) {
        return self;
    };
}

- (id<OCUIChained> _Nonnull (^)(UIColor * _Nonnull))backgroundColor {
    return ^id<OCUIChained>(UIColor *backgroundColor) {
        return self;
    };
}

- (id<OCUIChained> _Nonnull (^)(UIImage * _Nonnull))image {
    return ^id<OCUIChained>(UIImage *image) {
        return self;
    };
}

- (id<OCUIChained> _Nonnull (^)(CGFloat))priority {
    return ^id<OCUIChained>(CGFloat priority) {
        self->_viewPriority = priority;
        return self;
    };
}

- (id<OCUIChained> _Nonnull (^)(CGFloat))min {
    return ^id<OCUIChained> (CGFloat min) {
        self->_minFloatOffset = MAX(min, 0);
        return self;
    };
}

- (id<OCUIChained> _Nonnull (^)(CGFloat))updateFloatOffset {
    return ^id<OCUIChained>(CGFloat offset) {
        self->_currentFloatOffset = MAX(offset, self.minFloatOffset);
        if (self->_floatLayoutBlock) {
            self->_floatLayoutBlock(self);
        }
        return self;
    };
}

- (id<OCUIChained>  _Nonnull (^)(void(^)(UITableViewCell *,NSUInteger)))config {
    return ^id<OCUIChained>(void(^block)(UITableViewCell *,NSUInteger)) {
        return self;
    };
}

@end
