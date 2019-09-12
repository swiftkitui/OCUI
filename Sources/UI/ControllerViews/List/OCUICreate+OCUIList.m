//
//  OCUICreate+OCUIList.m
//  OCUIExample
//
//  Created by 张行 on 2019/9/12.
//  Copyright © 2019 张行. All rights reserved.
//

#import "OCUICreate+OCUIList.h"
#import "OCUIList.h"

@implementation OCUICreate (OCUIList)

- (OCUIList *(^)(OCUICreateElenmentBlock))List {
    return ^OCUIList *(OCUICreateElenmentBlock) {
        return [self addElenment:List(block)];
    };
}

@end

FOUNDATION_EXPORT OCUIList *List(OCUICreateElenmentBlock) {
    return [[OCUIList alloc] initWithElenmentsBlock:block];
}
