//
//  OCUICreate.m
//  OCUIExample
//
//  Created by 张行 on 2019/9/9.
//  Copyright © 2019 张行. All rights reserved.
//


#import "OCUIMaker.h"

FOUNDATION_EXPORT NSArray<OCUINode *> *CreateUINodes(void(^block)(void)) {
    if (!CurrentUINodes) {
        CurrentUINodes = [NSMutableArray array];
    }
    NSMutableArray *tempNodes = [NSMutableArray arrayWithArray:CurrentUINodes];
    /// 重置全局数组
    CurrentUINodes = [NSMutableArray array];
    if (block) {
        block();
    }
    NSArray *resultArray = CurrentUINodes;
    CurrentUINodes = tempNodes;
    return resultArray;
}
FOUNDATION_EXPORT void AddNodeInUINodes(OCUINode *node) {
    if (!CurrentUINodes || !node) {
        return;
    }
    [CurrentUINodes addObject:node];
}


