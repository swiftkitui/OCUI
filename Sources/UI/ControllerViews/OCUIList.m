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

@implementation OCUIList (ListStyle)

- (OCUIListStyle *)uiListStyle {
    return self.propertyGet(@selector(uiListStyle));
}

- (OCUINode *(^)(OCUIListStyle *))listStyle {
    return ^OCUINode *(OCUIListStyle *listStyle) {
        self.propertySet(listStyle,@selector(uiListStyle));
        return self;
    };
}

@end

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

@implementation OCUIListStyle

@end

@implementation OCUIGroupedListStyle

@end

FOUNDATION_EXPORT OCUIGroupedListStyle *GroupedListStyle(void) {
    OCUIGroupedListStyle *style = [[OCUIGroupedListStyle alloc] init];
    return style;
}
