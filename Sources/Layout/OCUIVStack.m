//
//  OCUIVStack.m
//  OCUI
//
//  Created by 张行 on 2019/8/22.
//  Copyright © 2019 张行. All rights reserved.
//

#import "OCUIVStack.h"
#import "OCUIView.h"

@implementation OCUIVStack

- (instancetype)init {
    if (self = [super init]) {
        _uiAlignment = OCUIHorizontalAlignmentCenter;
    }
    return self;
}

- (OCUIVStack * _Nonnull (^)(OCUIHorizontalAlignment))alignment {
    return ^OCUIVStack *(OCUIHorizontalAlignment alignment) {
        self->_uiAlignment = alignment;
        return self;
    };
}

- (CGFloat)intrinsicContentSizeHeight {
    /// 获取纵向布局多个元素宽度最大值
    __block CGFloat intrinsicContentSizeHeight = 0;
    [self.nodes enumerateObjectsUsingBlock:^(OCUINode * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIView *view;
        if ([obj isKindOfClass:[OCUIView class]]) {
            OCUIView *nodeView = (OCUIView *)obj;
            view = nodeView.uiRenderView;
        }
        if (view) {
            intrinsicContentSizeHeight += view.intrinsicContentSize.height;
        }
    }];
    return intrinsicContentSizeHeight;
}

@end
