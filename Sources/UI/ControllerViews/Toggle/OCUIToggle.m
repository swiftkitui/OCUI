//
//  OCUIToggle.m
//  OCUIExample
//
//  Created by 张行 on 2019/8/31.
//  Copyright © 2019 张行. All rights reserved.
//

#import "OCUIToggle.h"

@implementation OCUIToggle {
    BOOL _isOn;
}

- (instancetype)initWithIsOn:(BOOL)isOn {
    if (self = [super init]) {
        _isOn = isOn;
    }
    return self;
}

@end

