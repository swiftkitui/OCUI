//
//  OCUIStack.m
//  OCUIExample
//
//  Created by 张行 on 2019/9/3.
//  Copyright © 2019 张行. All rights reserved.
//

#import "OCUIStack.h"
#import "OCUIView.h"
#import "OCUIViewParse.h"

@implementation OCUIStack
@synthesize allLayoutViews = _allLayoutViews;

- (instancetype)init {
    if (self = [super init]) {
        _nodes = [NSMutableArray array];
    }
    return self;
}

- (void)startLayoutWithContentView:(OC_VIEW *)contentView {
    _contentView = contentView;
    [self.allLayoutViews enumerateObjectsUsingBlock:^(UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [contentView addSubview:obj];
    }];
    void(^block)(OCUIStack *) = [[OCUIViewParse shareParse] layoutViewBlockWithClassName:self.class];
    if (block) {
        block(self);
    }
}

- (NSArray<OC_VIEW *> *)allLayoutViews {
    if (!_allLayoutViews) {
        NSMutableArray *array = [NSMutableArray array];
        [self.nodes enumerateObjectsUsingBlock:^(OCUINode * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (![obj isKindOfClass:[OCUIView class]]) {
                return;
            }
            OCUIView *view = (OCUIView *)obj;
            if (view.uiRenderView) {
                [array addObject:view.uiRenderView];
            }
        }];
        _allLayoutViews = array;
    }
    return _allLayoutViews;
}

@end

@implementation OCUIStack (Layout)

+ (void)LoadLayoutWithClassName:(Class)className
                    layoutBlock:(void (^)(OCUIStack * _Nonnull))layoutBlock {
    [[OCUIViewParse shareParse] addLayoutBlock:layoutBlock className:className];
}

@end
