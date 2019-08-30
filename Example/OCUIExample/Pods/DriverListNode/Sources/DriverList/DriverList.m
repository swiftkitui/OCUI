//
//  DriverList.m
//  DriverList
//
//  Created by 张行 on 2019/8/19.
//  Copyright © 2019 张行. All rights reserved.
//

#import "DriverList.h"

@interface DriverList ()

@property (nonatomic, strong) NSMutableArray<DriverGroup *> *groups;

@end

@implementation DriverList

- (instancetype)init {
    if (self = [super init]) {
        _groups = [NSMutableArray array];
    }
    return self;
}

- (DriverGroup * _Nonnull (^)(void (^ _Nonnull)(DriverGroup * _Nonnull)))makeGroup {
    return ^DriverGroup *(void(^block)(DriverGroup *)) {
        DriverGroup *group = [[DriverGroup alloc] init];
        if (block) {
            block(group);
        }
        [self.groups addObject:group];
        return group;
    };
}


@end
FOUNDATION_EXTERN DriverList *ZHDriverList(DriverList *list) {
    currentDriverList = list;
    return list;
}
FOUNDATION_EXPORT void ZHAddDriverGroup(DriverGroup *group) {
    if (!group) {
        return;
    }
    extern DriverList *currentDriverList;
    if (!currentDriverList) {
        currentDriverList = [[DriverList alloc] init];
    }
    [currentDriverList.groups addObject:group];
}
FOUNDATION_EXPORT void ZHAddDriverNode(DriverNode *node) {
    if (!currentDriverGroup) {
        currentDriverGroup = [[DriverGroup alloc] init];
        ZHAddDriverGroup(currentDriverGroup);
    }
    currentDriverGroup.makeCell(node);
}
FOUNDATION_EXPORT DriverGroup *ZHDriverGroup(void) {
    DriverGroup *group = [[DriverGroup alloc] init];
    ZHAddDriverGroup(group);
    return group;
}

FOUNDATION_EXPORT DriverNode *ZHDriverCell(Class className, DriverBlockContent *(^block)(void)) {
    DriverNode *node = [DriverNode makeDriverAnyClass:className block:block];
    ZHAddDriverNode(node);
    return node;
}
FOUNDATION_EXPORT DriverNode *ZHDriverSpacer(UIColor *backgroundColor,DriverBlockContent *(^block)(void)) {
    return ZHDriverCell([UITableViewCell class], ^DriverBlockContent *{
        if (block) {
            return block();
        } else {
            DriverBlockContent<UITableViewCell *> *content = [[DriverBlockContent alloc] init];
            [content setConfigBlock:^(UITableViewCell * _Nonnull view, NSUInteger index) {
                view.backgroundColor = backgroundColor;
            }];
            return content;
        }
    });
}
FOUNDATION_EXPORT DriverNode *ZHDriverHeader(Class className, DriverBlockContent *(^block)(void)) {
    DriverNode *node = [DriverNode makeDriverAnyClass:className block:block];
    if (!currentDriverGroup) {
        currentDriverGroup = [[DriverGroup alloc] init];
        ZHAddDriverGroup(currentDriverGroup);
    }
    currentDriverGroup.makeHeader(node);
    return node;
}

FOUNDATION_EXPORT DriverNode *ZHDriverFooter(Class className, DriverBlockContent *(^block)(void)) {
    DriverNode *node = [DriverNode makeDriverAnyClass:className block:block];
    if (!currentDriverGroup) {
        currentDriverGroup = [[DriverGroup alloc] init];
        ZHAddDriverGroup(currentDriverGroup);
    }
    currentDriverGroup.makeFooter(node);
    return node;
}
