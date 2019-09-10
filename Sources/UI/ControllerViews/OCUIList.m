//
//  OCUIList.m
//  OCUIExample
//
//  Created by 张行 on 2019/8/27.
//  Copyright © 2019 张行. All rights reserved.
//

#import "OCUIList.h"
#import <DriverListNode/DriverListNode.h>
#import "OCUICreate.h"

@implementation OCUIList 

- (instancetype)initWithBlock:(void (^)(void))block {
    if (self = [super init]) {
    }
    return self;
}


@end

FOUNDATION_EXPORT OCUIList *List(void(^block)(void)) {
    OCUIList *list = [[OCUIList alloc] initWithBlock:block];
    return list;
}

@implementation OCUISection

- (instancetype)initWithBlock:(void(^)(void))block {
    if (self = [super init]) {
        
    }
    return self;
}

@end

FOUNDATION_EXPORT OCUISection *Section(void(^block)(void)) {
    OCUISection *section = [[OCUISection alloc] init];
    return section;
}
