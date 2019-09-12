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

@end

FOUNDATION_EXPORT OCUIButton *Button(void(^actionBlock)(void), OCUICreateElenmentBlock) {
    OCUIButton *button = [[OCUIButton alloc] init];
    return button;
}
