//
//  OCUICreate+OCUIHStack.m
//  OCUIExample
//
//  Created by 张行 on 2019/9/12.
//  Copyright © 2019 张行. All rights reserved.
//

#import "OCUICreate+OCUIHStack.h"
#import "OCUIHStack.h"

@implementation OCUICreate (OCUIHStack)

- (OCUIHStack *(^)(OCUICreateElenmentBlock))HStack {
    return ^OCUIHStack *(OCUICreateElenmentBlock) {
        return [self addElenment:HStack(block)];
    };
}

@end

FOUNDATION_EXPORT OCUIHStack *HStack(OCUICreateElenmentBlock) {
    return [[OCUIHStack alloc] initWithElenmentsBlock:block];
}
