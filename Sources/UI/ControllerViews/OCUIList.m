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
@end

FOUNDATION_EXPORT OCUIList *List(OCUICreateElenmentBlock) {
    OCUIList *list = [[OCUIList alloc] initWithElenmentsBlock:block];
    return list;
}

@implementation OCUICreate (OCUIList)

- (OCUIList *(^)(OCUICreateElenmentBlock))List {
    return ^OCUIList *(OCUICreateElenmentBlock) {
        OCUIList *list = List(block);
        [self addElenment:list];
        return list;
    };
}

@end

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

FOUNDATION_EXPORT OCUISection *Section(OCUICreateElenmentBlock) {
    OCUISection *section = [[OCUISection alloc] initWithElenmentsBlock:block];
    return section;
}

@implementation OCUINode (OCUISectionHeader)

- (NSArray<OCUINode *> *)headerNodes {
    return self.propertyGet(@selector(headerNodes));
}

- (OCUINode *(^)(void(^HeaderBlock)(void)))header {
    return ^OCUINode *(void(^HeaderBlock)(void)) {
//        OCUINode *node = [[OCUINode alloc] initWithElenmentsBlock:HeaderBlock];
//        self.propertySet(node.elenments,@selector(headerNodes));
        return self;
    };
}

@end

@implementation OCUIListStyle

@end

@implementation OCUIGroupedListStyle

@end

FOUNDATION_EXPORT OCUIGroupedListStyle *GroupedListStyle(void) {
    OCUIGroupedListStyle *style = [[OCUIGroupedListStyle alloc] init];
    return style;
}
