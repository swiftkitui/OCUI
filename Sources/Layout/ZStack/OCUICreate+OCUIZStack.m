//
//  OCUICreate+OCUIZStack.m
//  OCUIExample
//
//  Created by 张行 on 2019/9/12.
//  Copyright © 2019 张行. All rights reserved.
//

#import "OCUICreate+OCUIZStack.h"
#import "OCUIZStack.h"

@implementation OCUICreate (OCUIZStack)

- (OCUIZStack *(^)(OCUICreateElenmentBlock))ZStack {
    return ^OCUIZStack *(OCUICreateElenmentBlock) {
        return [self addElenment:ZStack(block)];
    };
}

@end

FOUNDATION_EXPORT OCUIZStack *ZStack(OCUICreateElenmentBlock) {
    return [[OCUIZStack alloc] initWithElenmentsBlock:block];
}
