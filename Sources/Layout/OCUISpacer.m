//
//  OCUISpacer.m
//  OCUI
//
//  Created by 张行 on 2019/8/22.
//  Copyright © 2019 张行. All rights reserved.
//

#import "OCUISpacer.h"

@implementation OCUISpacer
@synthesize uiOffset = _uiOffset;

- (instancetype)init {
    if (self = [super init]) {
        self->_uiMinOffset = 0;
        self->_uiFlxedOffset = NSNotFound;
    }
    return self;
}

- (CGFloat)uiOffset {
    return MAX(_uiMinOffset, _uiOffset);
}

- (instancetype  _Nonnull (^)(CGFloat))minOffset {
    return ^OCUISpacer *(CGFloat minOffset) {
        self->_uiMinOffset = minOffset;
        self->_uiFlxedOffset = NSNotFound;
        return self;
    };
}

- (instancetype  _Nonnull (^)(CGFloat))flxedOffset {
    return ^OCUISpacer *(CGFloat flxedOffset) {
        self->_uiFlxedOffset = flxedOffset;
        self->_uiMinOffset = 0;
        return self;
    };
}

- (instancetype  _Nonnull (^)(CGFloat))offset {
    return ^OCUISpacer *(CGFloat offset) {
        self->_uiOffset = offset;
        return self;
    };
}

@end

