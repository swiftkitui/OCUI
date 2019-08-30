//
//  DriverGroup.m
//  ZHTableViewGroup iOS
//
//  Created by 张行 on 2019/8/8.
//  Copyright © 2019 15038777234. All rights reserved.
//

#import "DriverGroup.h"

@interface DriverGroup ()

@property (nonatomic, copy) NSMutableArray<DriverNode *> *groupCells;
@property (nonatomic, strong) DriverNode *groupHeader;
@property (nonatomic, strong) DriverNode *groupFooter;

@end

@implementation DriverGroup

- (instancetype)init {
    if (self = [super init]) {
        _groupCells = [NSMutableArray array];
    }
    return self;
}


- (DriverNode * _Nonnull (^)(DriverNode * _Nonnull))makeHeader {
    return ^DriverNode *(DriverNode *node) {
        self->_groupHeader = node;
        return node;
    };
}

- (DriverNode * _Nonnull (^)(DriverNode * _Nonnull))makeFooter {
    return ^DriverNode *(DriverNode *node) {
        self->_groupFooter = node;
        return node;
    };
}

- (DriverNode * _Nonnull (^)(DriverNode * _Nonnull))makeCell {
    return ^DriverNode *(DriverNode *node) {
        if (!node) {
            return nil;
        }
        [self.groupCells addObject:node];
        return node;
    };
}

- (DriverNode * _Nonnull (^)(UIColor * _Nonnull))makeSpeacer {
    return ^DriverNode *(UIColor *backgroundColor) {
        return self.makeCell([DriverNode makeDriverAnyClass:[UITableViewCell class] block:^DriverBlockContent * _Nonnull{
            DriverBlockContent<UITableViewCell *> *content = [[DriverBlockContent alloc] init];
            [content setConfigBlock:^(UITableViewCell * _Nonnull view, NSUInteger index) {
                view.backgroundColor = backgroundColor;
            }];
            return content;
        }])
        .height(10);
    };
}

- (DriverGroup * _Nonnull (^)(UIEdgeInsets))sectionEdgeInsets {
    return ^DriverGroup *(UIEdgeInsets sectionEdgeInsets) {
        self->_groupSectionEdgeInsets = sectionEdgeInsets;
        return self;
    };
}

@end
