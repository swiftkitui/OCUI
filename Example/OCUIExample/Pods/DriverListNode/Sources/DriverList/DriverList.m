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
