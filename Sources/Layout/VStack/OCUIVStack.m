//
//  OCUIVStack.m
//  OCUI
//
//  Created by 张行 on 2019/8/22.
//  Copyright © 2019 张行. All rights reserved.
//

#import "OCUIVStack.h"
#import "OCUIView.h"
#import "OCUIViewParse.h"

@implementation OCUIVStack

- (instancetype)initWithElenmentsBlock:(void (^)(OCUICreate * _Nonnull))block {
    if (self = [super initWithElenmentsBlock:block]) {
        self.propertySet(@(OCUIHorizontalAlignmentCenter),@selector(uiAlignment));
    }
    return self;
}

- (void)loadElenmentInContentView:(UIView *)contentView {
    [super loadElenmentInContentView:contentView];
    [self.allLayoutViews enumerateObjectsUsingBlock:^(UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [contentView addSubview:obj];
    }];
    void(^block)(OCUIStack *) = [[OCUIViewParse shareParse] layoutViewBlockWithClassName:OCUIVStack.self];
    if (block) {
        block(self);
    }
    [self.elenments enumerateObjectsUsingBlock:^(OCUINode * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj loadElenmentInContentView:self.contentView];
    }];
}

- (CGFloat)intrinsicContentSizeHeight {
    /// 获取纵向布局多个元素宽度最大值
    __block CGFloat intrinsicContentSizeHeight = 0;
    [self.elenments enumerateObjectsUsingBlock:^(OCUINode * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
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

@implementation OCUIVStack (Alignment)

- (OCUIHorizontalAlignment)uiAlignment {
    return (OCUIHorizontalAlignment)[self.propertyGet(@selector(uiAlignment)) integerValue];
}

- (OCUIVStack * _Nonnull (^)(OCUIHorizontalAlignment))alignment {
    return ^OCUIVStack *(OCUIHorizontalAlignment alignment) {
        self.propertySet(@(alignment),@selector(uiAlignment));
        return self;
    };
}

@end

@implementation OCUIVStack (BoxElenments)

+ (void)boxElenmentsWithElenment:(OCUINode *)elenment {
    if (elenment.elenments.count == 0) {
        return;
    }
    if (elenment.elenments.count == 1 && [elenment.elenments.firstObject isKindOfClass:[OCUIStack class]]) {
        return;
    }
    OCUIVStack *stack = VStack(OCUICreateElenment {
        [elenment.elenments enumerateObjectsUsingBlock:^(OCUINode * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [c addElenment:obj];
        }];
    });
    [elenment updateElenments:@[stack]];
}

@end
