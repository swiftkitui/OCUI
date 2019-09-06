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
#import "OCUISpacer.h"

@implementation OCUIStack
@synthesize allLayoutViews = _allLayoutViews;

- (instancetype)init {
    if (self = [super init]) {
        _nodes = [NSMutableArray array];
        _contentView = [UIView new];
    }
    return self;
}

- (void)startLayout {
    [self addSpacerInTopBottomStack];
    [self.allLayoutViews enumerateObjectsUsingBlock:^(UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self.contentView addSubview:obj];
    }];
    void(^block)(OCUIStack *) = [[OCUIViewParse shareParse] layoutViewBlockWithClassName:self.class];
    if (block) {
        block(self);
    }
    [self.nodes enumerateObjectsUsingBlock:^(OCUINode * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[OCUIStack class]]) {
            OCUIStack *stack = (OCUIStack *)obj;
            [stack startLayout];
        }
    }];
}

- (void)addSpacerInTopBottomStack {
    if (![self isExitSpacerInStack]) {
        if (![self.nodes.firstObject isKindOfClass:[OCUISpacer class]]) {
            OCUISpacer *topSpacer = [[OCUISpacer alloc] init];
            [self.nodes insertObject:topSpacer atIndex:0];
        }
        
        if (![self.nodes.lastObject isKindOfClass:[OCUISpacer class]]) {
            OCUISpacer *bottomSpacer = [[OCUISpacer alloc] init];
            [self.nodes addObject:bottomSpacer];
        }
    }
}

- (BOOL)isExitSpacerInStack {
    __block BOOL isExitSpacer = NO;
    [self.nodes enumerateObjectsUsingBlock:^(OCUINode * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[OCUISpacer class]] && ![obj isEqual:self.nodes.firstObject] && ![obj isEqual:self.nodes.lastObject]) {
            isExitSpacer = YES;
        }
    }];
    return isExitSpacer;
}



- (NSArray<OC_VIEW *> *)allLayoutViews {
    if (!_allLayoutViews) {
        NSMutableArray *array = [NSMutableArray array];
        [self.nodes enumerateObjectsUsingBlock:^(OCUINode * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj isKindOfClass:[OCUIView class]]) {
                OCUIView *view = (OCUIView *)obj;
                if (view.uiRenderView) {
                    [array addObject:view.uiRenderView];
                }
            } else if ([obj isKindOfClass:[OCUIStack class]]) {
                OCUIStack *stack = (OCUIStack *)obj;
                if (stack.contentView) {
                    [array addObject:stack.contentView];
                }
            }
        }];
        _allLayoutViews = array;
    }
    return _allLayoutViews;
}


@end

@implementation OCUIStack (Layout)

+ (void)loadLayoutWithClassName:(Class)className
                    layoutBlock:(void (^)(OCUIStack * _Nonnull))layoutBlock {
    [[OCUIViewParse shareParse] addLayoutBlock:layoutBlock className:className];
}

@end

@implementation OCUIStack (Spacer)

- (NSArray<OCUISpacer *> *)allFloatSpacers {
    NSMutableArray<OCUISpacer *> *spacers = [NSMutableArray array];
    [self.nodes enumerateObjectsUsingBlock:^(OCUINode * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[OCUISpacer class]]) {
            OCUISpacer *spacer = (OCUISpacer *)obj;
            if (spacer.uiFlxedOffset == NSNotFound) {
                [spacers addObject:spacer];
            }
        }
    }];
    return spacers;
}

- (OCUISpacer *)layoutSpacerWithView:(UIView *)view {
    __block OCUISpacer *spacer;
    [self.nodes enumerateObjectsUsingBlock:^(OCUINode * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[OCUISpacer class]]) {
            spacer = (OCUISpacer *)obj;
        } else if ([obj isKindOfClass:[OCUIView class]]) {
            UIView *renderView = [(OCUIView *)obj uiRenderView];
            if ([renderView isEqual:view]) {
                *stop = YES;
                return;
            } else {
                spacer = nil;
            }
        }
    }];
    return spacer;
}

@end

@implementation OCUIStack (OCUIView)

- (OCUIView *)viewNodeWithRenderView:(UIView *)view {
    __block OCUIView *viewNode;
    [self.nodes enumerateObjectsUsingBlock:^(OCUINode * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (![obj isKindOfClass:[OCUIView class]]) {
            return;
        }
        OCUIView *_viewNode = (OCUIView *)obj;
        if (![_viewNode.uiRenderView isEqual:view]) {
            return;
        }
        viewNode = _viewNode;
    }];
    return viewNode;
}

@end
