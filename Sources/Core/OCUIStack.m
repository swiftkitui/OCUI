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
#import <Masonry/Masonry.h>

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

- (void)loadAndLayoutViewsInView:(UIView *)view {
    _contentView = view;
    [self addSpacerInBothSides];
    for (id<OCUIRenderView> renderView in self.nodes) {
        UIView *makeView = [self viewWithRenderView:renderView];
        if (makeView) {
            [view addSubview:makeView];
        }
    }
    [self setupContraints];
    [self updateContraints];
    [self addContraints];
//    [self addKVOView];
    self.isCanUpdateContraints = YES;
}

- (void)addSpacerInBothSides {
    if (![self.nodes.firstObject isKindOfClass:[OCUISpacer class]]) {
        OCUISpacer *spacer = [[OCUISpacer alloc] initWithOffset:@(0)];
        [self.nodes insertObject:spacer atIndex:0];
    }
    if (![self.nodes.lastObject isKindOfClass:[OCUISpacer class]]) {
        OCUISpacer *spacer = [[OCUISpacer alloc] initWithOffset:@(0)];
        [self.nodes addObject:spacer];
    }
}

- (void)setupContraints {}
- (void)updateContraints {}
- (void)addContraints {}

- (void)addKVOView {
    [self.nodes enumerateObjectsUsingBlock:^(id<OCUIRenderView>  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIView *view = [self viewWithRenderView:obj];
        if (view) {
            if ([view isKindOfClass:[UILabel class]]) {
                [view addObserver:self forKeyPath:@"text" options:NSKeyValueObservingOptionNew context:nil];
            }
        }
    }];
}

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary<NSKeyValueChangeKey,id> *)change
                       context:(void *)context {
    if ([object isKindOfClass:[UIView class]]) {
        UIView *view = (UIView *)object;
        CGSize size = [view intrinsicContentSize];
        if (size.width != CGRectGetWidth(view.frame)) {
            [view mas_updateConstraints:^(MASConstraintMaker *make) {
                make.width.mas_equalTo(size.width);
            }];
            
        }
        if (size.height != CGRectGetHeight(view.frame)) {
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(size.height);
            }];
        }
        [self updateContraints];
    }
}

- (UIView *)viewWithRenderView:(id<OCUIRenderView>)renderView {
    if (!renderView) {
        return nil;
    }
    UIView *makeView = objc_getAssociatedObject(renderView, @selector(viewWithRenderView:));
    if (!makeView && [renderView respondsToSelector:@selector(makeOCUIView)]) {
        makeView = [renderView makeOCUIView];
        if ([renderView respondsToSelector:@selector(configOCUIView:)]) {
            [renderView configOCUIView:makeView];
        }
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

- (NSUInteger)automaticRenderViewCountWithStackType:(OCUIStackType)stackType {
    __block NSUInteger count = 0;
    [self.nodes enumerateObjectsUsingBlock:^(id<OCUIRenderView>  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        CGFloat height = [self lenghtWithRenderView:obj stackType:stackType];
        if (height != 0 || [obj isKindOfClass:[OCUISpacer class]]) {
            return;
        }
        count ++;
    }];
    return count;
}

- (CGFloat)lenghtWithRenderView:(id<OCUIRenderView>)renderView
                      stackType:(OCUIStackType)stackType {
    CGSize renderSize = CGSizeZero;
    CGFloat height = 0;
    if ([renderView respondsToSelector:@selector(renderSize)]) {
        renderSize = [renderView renderSize];
        height = [self heightWithSize:renderSize stackType:stackType];
    }
    if (height > 0) {
        return height;
    }
    UIView *makeView = [self viewWithRenderView:renderView];
    if (!makeView) {
        return 0;
    }
    CGSize intrinsicContentSize = makeView.intrinsicContentSize;
    height = [self heightWithSize:intrinsicContentSize stackType:stackType];
    if (height > 0) {
        return height;
    }
    return height;
}

- (CGFloat)heightWithSize:(CGSize)size
                stackType:(OCUIStackType)stackType {
    if (stackType == OCUIStackTypeH) {
        return size.width;
    } else if (stackType == OCUIStackTypeV) {
        return size.height;
    } else {
        return 0;
    }
}

- (UIView *)viewWithHash:(NSUInteger)hash {
    __block UIView *view;
    [self.nodes enumerateObjectsUsingBlock:^(id<OCUIRenderView>  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIView *makeView = [self viewWithRenderView:obj];
        if (makeView.hash == hash) {
            view = makeView;
            return;
        }
    }];
    return view;
}

- (CGFloat)firstOffset {
    return [self offsetWithRenderView:self.nodes.firstObject];
}

- (CGFloat)lastOffset {
    return [self offsetWithRenderView:self.nodes.lastObject];
}

- (CGFloat)offsetWithRenderView:(id<OCUIRenderView>)renderView {
    if (![renderView isKindOfClass:[OCUISpacer class]]) {
        return 0;
    }
    OCUISpacer *spacer = (OCUISpacer *)renderView;
    if (!spacer.lenghtOffset) {
        return 0;
    }
    return spacer.lenghtOffset.height;
}

@end
