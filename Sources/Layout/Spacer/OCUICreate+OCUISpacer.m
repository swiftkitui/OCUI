//
//  OCUICreate+OCUISpacer.m
//  OCUIExample
//
//  Created by 张行 on 2019/9/12.
//  Copyright © 2019 张行. All rights reserved.
//

#import "OCUICreate+OCUISpacer.h"
#import "OCUISpacer.h"

@implementation OCUICreate (OCUISpacer)

- (OCUISpacer *(^)(void))Spacer {
    return ^OCUISpacer *{
        return [self addElenment:Spacer()];
    };
}

@end

FOUNDATION_EXPORT OCUISpacer *Spacer(void) {
    return [[OCUISpacer alloc] init];
}
