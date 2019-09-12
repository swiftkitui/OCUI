//
//  OCUISlider.m
//  OCUIExample
//
//  Created by 张行 on 2019/8/31.
//  Copyright © 2019 张行. All rights reserved.
//

#import "OCUISlider.h"

@implementation OCUISlider {
    CGFloat _value;
}

- (instancetype)initWithValue:(CGFloat)value {
    if (self = [super init]) {
        _value = value;
    }
    return self;
}

@end
