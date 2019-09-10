//
//  OCUINode+Frame.m
//  OCUIExample
//
//  Created by 张行 on 2019/9/10.
//  Copyright © 2019 张行. All rights reserved.
//

#import "OCUINode+Frame.h"

@implementation OCUINode (Frame)

- (CGSize)uiSize {
    return [self.propertyGet(@selector(uiSize)) CGSizeValue];
}

- (OCUINode *(^)(CGSize))size {
    return ^OCUINode *(CGSize size) {
        self.propertySet(@(size),@selector(uiSize));
        return self;
    };
}

@end
