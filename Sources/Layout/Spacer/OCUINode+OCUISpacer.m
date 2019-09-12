//
//  OCUINode+OCUISpacer.m
//  OCUIExample
//
//  Created by 张行 on 2019/9/12.
//  Copyright © 2019 张行. All rights reserved.
//

#import "OCUINode+OCUISpacer.h"

@implementation OCUINode (OCUISpacerOffset)

- (CGFloat)uiOffset {
    return MAX(self.uiMinOffset,[self.propertyGet(@selector(uiOffset)) floatValue]);
}

- (CGFloat)uiMinOffset {
    return [self.propertyGet(@selector(uiMinOffset)) floatValue];
}

- (CGFloat)uiFlxedOffset {
    return [self.propertyGet(@selector(uiFlxedOffset)) floatValue];
}

- (OCUINode *(^)(CGFloat))minOffset {
    return ^OCUINode *(CGFloat minOffset) {
        self.propertySet(@(NSNotFound),@selector(uiFlxedOffset));
        self.propertySet(@(minOffset),@selector(uiMinOffset));
        return self;
    };
}

- (OCUINode *(^)(CGFloat))flxedOffset {
    return ^OCUINode *(CGFloat flxedOffset) {
        self.propertySet(@(flxedOffset),@selector(uiFlxedOffset));
        self.propertySet(@(0),@selector(uiMinOffset));
        return self;
    };
}

- (OCUINode *(^)(CGFloat))offset {
    return ^OCUINode *(CGFloat offset) {
        self.propertySet(@(offset),@selector(uiOffset));
        return self;
    };
}

@end
