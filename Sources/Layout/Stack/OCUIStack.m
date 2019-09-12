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

- (void)loadElenmentInContentView:(UIView *)contentView {
    [super loadElenmentInContentView:contentView];
    
}

- (BOOL)isExitFloatSpacer {
    return self.allFloatSpacers.count > 0;
}

@end

@implementation OCUIStack (UIView)

- (UIView *)contentView {
    UIView *view = self.propertyGet(@selector(contentView));
    if (!view) {
        view = [[UIView alloc] initWithFrame:CGRectZero];
        self.propertySet(view,@selector(contentView));
    }
    return view;
}

- (NSArray<UIView *> *)allLayoutViews {
    NSMutableArray *array = [NSMutableArray array];
    [self.elenments enumerateObjectsUsingBlock:^(OCUINode * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
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
    return array;
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
    [self.elenments enumerateObjectsUsingBlock:^(OCUINode * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
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
    [self.elenments enumerateObjectsUsingBlock:^(OCUINode * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
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
    [self.elenments enumerateObjectsUsingBlock:^(OCUINode * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
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
