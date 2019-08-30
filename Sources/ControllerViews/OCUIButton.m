//
//  OCUIButton.m
//  OCUIExample
//
//  Created by 张行 on 2019/8/30.
//  Copyright © 2019 张行. All rights reserved.
//

#import "OCUIButton.h"
#import "OCUIMaker.h"

@implementation OCUIButton

- (instancetype)initWithAction:(void(^)(void))actionBlock
                          make:(void(^)(void))makeBlock {
    if (self = [super init]) {
        
    }
    return self;
}

- (UIView *)makeOCUIView {
    return UIButton.new;
}

- (void)configOCUIView:(UIView *)view {
    [super configOCUIView:view];
}

@end
