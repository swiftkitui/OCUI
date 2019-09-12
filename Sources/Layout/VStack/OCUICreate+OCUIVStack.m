//
//  OCUICreate+OCUIVStack.m
//  OCUIExample
//
//  Created by 张行 on 2019/9/12.
//  Copyright © 2019 张行. All rights reserved.
//

#import "OCUICreate+OCUIVStack.h"
#import "OCUIVStack.h"

@implementation OCUICreate (OCUIVStack)

- (OCUIVStack *(^)(OCUICreateElenmentBlock))VStack {
    return ^OCUIVStack *(OCUICreateElenmentBlock) {
        return [self addElenment:VStack(block)];
    };
}

@end

FOUNDATION_EXPORT OCUIVStack *VStack(OCUICreateElenmentBlock) {
    return [[OCUIVStack alloc] initWithElenmentsBlock:block];
}
