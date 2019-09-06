//
//  OCUINode.m
//  OCUI
//
//  Created by 张行 on 2019/8/22.
//  Copyright © 2019 张行. All rights reserved.
//

#import "OCUINode.h"

@implementation OCUINode {
    CGSize _uiSize;
}

@end

@implementation OCUINode (Frame)

- (CGSize)uiSize {
    return _uiSize;
}

- (OCUINode *(^)(CGSize))size {
    return ^OCUINode *(CGSize size) {
        self->_uiSize = size;
        return self;
    };
}

@end

@implementation OCUINode (OCUIView)

- (OCUINode * _Nonnull (^)(UIColor * _Nonnull))backgroundColor {
    return nil;
}

@end
