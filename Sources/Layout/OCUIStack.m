//
//  OCUIStack.m
//  OCUI
//
//  Created by 张行 on 2019/8/22.
//  Copyright © 2019 张行. All rights reserved.
//

#import "OCUIStack.h"
#import "OCUIRenderView.h"
#import <objc/runtime.h>

@interface OCUIStack ()

@property (nonatomic, copy) NSMutableArray<id<OCUIRenderView>> *nodes;

@end

@implementation OCUIStack {
}

- (instancetype)init {
    if (self = [super init]) {
        _nodes = [NSMutableArray array];
    }
    return self;
}

- (OCUIText * _Nonnull (^)(NSString * _Nonnull))Text {
    return ^OCUIText *(NSString *content) {
        OCUIText *text = [[OCUIText alloc] initWithText:content];
        [self.nodes addObject:text];
        return text;
    };
}

- (OCUISpacer * _Nonnull (^)(void))Spacer {
    return ^OCUISpacer *{
        OCUISpacer *spacer = [[OCUISpacer alloc] init];
        [self.nodes addObject:spacer];
        return spacer;
    };
}

- (OCUIView * _Nonnull (^)(void))View {
    return ^OCUIView * {
        OCUIView *view = [[OCUIView alloc] init];
        [self.nodes addObject:view];
        return view;
    };
}

- (void)loadAndLayoutViewsInView:(UIView *)view {
    for (id<OCUIRenderView> renderView in self.nodes) {
        UIView *makeView = [self viewWithRenderView:renderView];
        if (makeView) {
            [view addSubview:makeView];
        }
    }
}

- (UIView *)viewWithRenderView:(id<OCUIRenderView>)renderView {
    if (!renderView) {
        return nil;
    }
    UIView *makeView = objc_getAssociatedObject(renderView, @selector(viewWithRenderView:));
    if (!makeView) {
        makeView = [renderView makeOCUIView];
        if (makeView) {
            objc_setAssociatedObject(renderView, @selector(viewWithRenderView:), makeView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        }
    }
    return makeView;
}

- (NSUInteger)automaticSpacerCount {
    __block NSUInteger count = 0;
    [self.nodes enumerateObjectsUsingBlock:^(id<OCUIRenderView>  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (![obj isKindOfClass:[OCUISpacer class]]) {
            return;
        }
        OCUISpacer *spacer = (OCUISpacer *)obj;
        if (spacer.lenghtOffset) {
            return;
        }
        count ++;
    }];
    return count;
}

- (NSUInteger)automaticRenderViewCount {
    __block NSUInteger count = 0;
    [self.nodes enumerateObjectsUsingBlock:^(id<OCUIRenderView>  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (!CGSizeEqualToSize([self sizeWithRenderView:obj], CGSizeZero) || [obj isKindOfClass:[OCUISpacer class]]) {
            return;
        }
        count ++;
    }];
    return count;
}

- (CGSize)sizeWithRenderView:(id<OCUIRenderView>)renderView {
    CGSize renderSize = CGSizeZero;
    if ([renderView respondsToSelector:@selector(renderSize)]) {
        renderSize = [renderView renderSize];
    }
    if (renderSize.width > 0 && renderSize.height > 0) {
        return renderSize;
    }
    UIView *makeView = [self viewWithRenderView:renderView];
    if (!makeView) {
        return CGSizeZero;
    }
    CGSize intrinsicContentSize = makeView.intrinsicContentSize;
    if (intrinsicContentSize.width > 0 && intrinsicContentSize.height > 0) {
        return intrinsicContentSize;
    }
    return intrinsicContentSize;
}


@end
