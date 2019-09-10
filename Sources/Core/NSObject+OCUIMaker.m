//
//  NSObject+OCUIMaker.m
//  OCUIExample
//
//  Created by 张行 on 2019/9/10.
//  Copyright © 2019 张行. All rights reserved.
//

#import "NSObject+OCUIMaker.h"
#import "OCUIMaker.h"

@implementation NSObject (OCUIMaker)

- (void)makeRenderView:(UIView *)view {
    Maker(view, ^{
        [self bodyUI];
    });
}

#pragma mark - OCUIMakerRenderView
- (void)bodyUI {}

@end
