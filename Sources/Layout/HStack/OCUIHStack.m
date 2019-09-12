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

- (CGFloat)intrinsicContentSizeWidth {
    __block CGFloat intrinsicContentSizeWidth = 0;
    [self.elenments enumerateObjectsUsingBlock:^(OCUINode * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
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

@implementation OCUIHStack (alignment)

- (OCUIVerticalAlignment)uiAlignment {
    return (OCUIVerticalAlignment)[self.propertyGet(@selector(uiAlignment)) integerValue];
}

- (OCUIHStack * _Nonnull (^)(OCUIVerticalAlignment))alignment {
    return ^OCUIHStack *(OCUIVerticalAlignment alignment) {
        self.propertySet(@(alignment),@selector(uiAlignment));
        return self;
    };
}

@end
