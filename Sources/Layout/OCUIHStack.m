//
//  OCUIHStack.m
//  OCUI
//
//  Created by 张行 on 2019/8/22.
//  Copyright © 2019 张行. All rights reserved.
//

#import "OCUIHStack.h"
#import "OCUIView.h"

@implementation OCUIHStack 

- (instancetype)init {
    if (self = [super init]) {
        _uiAlignment = OCUIVerticalAlignmentCenter;
    }
    return self;
}

- (OCUIHStack * _Nonnull (^)(OCUIVerticalAlignment))alignment {
    return ^OCUIHStack *(OCUIVerticalAlignment alignment) {
        self->_uiAlignment = alignment;
        return self;
    };
}

- (CGFloat)intrinsicContentSizeWidth {
    __block CGFloat intrinsicContentSizeWidth = 0;
    [self.nodes enumerateObjectsUsingBlock:^(OCUINode * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIView *view;
        if ([obj isKindOfClass:[OCUIView class]]) {
            OCUIView *nodeView = (OCUIView *)obj;
            view = nodeView.uiRenderView;
        }
        if (view) {
            intrinsicContentSizeWidth += view.intrinsicContentSize.width;
        }
    }];
    return intrinsicContentSizeWidth;
}

@end

FOUNDATION_EXPORT OCUIHStack *HStack(void(^block)(void)) {
    if (!block) {
        return nil;
    }
//    NSArray<OCUINode *> *nodes = CreateUINodes(block);
//    OCUIHStack *hStack = [[OCUIHStack alloc] initWithNodes:nodes];
    return nil;
}
