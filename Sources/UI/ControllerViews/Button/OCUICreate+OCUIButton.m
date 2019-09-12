//
//  OCUICreate+OCUIButton.m
//  OCUIExample
//
//  Created by 张行 on 2019/9/12.
//  Copyright © 2019 张行. All rights reserved.
//

#import "OCUICreate+OCUIButton.h"
#import "OCUIButton.h"

@implementation OCUICreate (OCUIButton)

- (OCUIButton *(^)(void(^actionBlock)(void), OCUICreateElenmentBlock))Button {
    return ^OCUIButton *(void(^actionBlock)(void), OCUICreateElenmentBlock) {
        return [self addElenment:Button(actionBlock, block)];
    };
}

@end

FOUNDATION_EXPORT OCUIButton *Button(void(^actionBlock)(void), OCUICreateElenmentBlock) {
    OCUIButton *button = [[OCUIButton alloc] init];
    return button;
}
