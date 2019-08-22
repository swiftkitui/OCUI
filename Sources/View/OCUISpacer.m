//
//  OCUISpacer.m
//  OCUI
//
//  Created by 张行 on 2019/8/22.
//  Copyright © 2019 张行. All rights reserved.
//

#import "OCUISpacer.h"

@implementation OCUISpacer

- (UIView *)makeOCUIView {
    return nil;
}

- (OCUISpacer * _Nonnull (^)(CGFloat))lenght {
    return ^OCUISpacer *(CGFloat lenght) {
        self->_lenghtOffset = [[OCUILayoutOffset alloc] initWithHeight:lenght];
        return self;
    };
}

@end
