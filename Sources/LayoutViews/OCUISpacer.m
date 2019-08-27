//
//  OCUISpacer.m
//  OCUI
//
//  Created by 张行 on 2019/8/22.
//  Copyright © 2019 张行. All rights reserved.
//

#import "OCUISpacer.h"

@implementation OCUISpacer

- (instancetype)initWithOffset:(NSNumber *)offset {
    if (self = [super init]) {
        if (offset) {
            _lenghtOffset = [[OCUILayoutOffset alloc] initWithHeight:[offset floatValue]];
        }
    }
    return self;
}

- (OCUISpacer * _Nonnull (^)(CGFloat))min {
    return ^OCUISpacer *(CGFloat min) {
        self->_minOffset = [[OCUILayoutOffset alloc] initWithHeight:min];
        return self;
    };
}

- (CGFloat)minSpancer {
    if (!_minOffset) {
        return 0;
    }
    return _minOffset.height;
}

@end
