//
//  DriverNode.m
//  ZHTableViewGroup iOS
//
//  Created by 张行 on 2019/8/16.
//  Copyright © 2019 15038777234. All rights reserved.
//

#import "DriverNode.h"

@implementation DriverNode

- (instancetype)initWithAnyClass:(Class)anyClass
                           block:(void(^)(DriverBlockContent *))block {
    if (self = [super init]) {
        _anyClass = anyClass;
        _identifier = [NSString stringWithFormat:@"%@:%@",NSStringFromClass(_anyClass),@(self.hash)];
        _cellHeight = NSNotFound;
        _cellNumber = 1;
        _enableCell = YES;
        _blockContent = [[DriverBlockContent alloc] init];
        if (block) {
            block(_blockContent);
        }
    }
    return self;
}

+ (instancetype)makeDriverAnyClass:(Class)anyClass
                             block:(void (^)(DriverBlockContent * _Nonnull))block {
    return [[DriverNode alloc] initWithAnyClass:anyClass
                                          block:block];
}

- (DriverNode * _Nonnull (^)(CGFloat))height {
    return ^DriverNode *(CGFloat height){
        self->_cellHeight = height;
        return self;
    };
}

- (DriverNode * _Nonnull (^)(NSUInteger))number {
    return ^DriverNode *(NSUInteger number){
        self->_cellNumber = number;
        return self;
    };
}

- (DriverNode * _Nonnull (^)(BOOL))enable {
    return ^DriverNode *(BOOL enable) {
        self->_enableCell = enable;
        return self;
    };
}

- (DriverNode * _Nonnull (^)(CGSize))size {
    return ^DriverNode *(CGSize size) {
        self->_cellSize = size;
        return self;
    };
}

@end

FOUNDATION_EXPORT DriverNode *ZHDriverNode(Class anyclass, void(^block)(DriverBlockContent *content)) {
    return [DriverNode makeDriverAnyClass:anyclass block:block];
}

