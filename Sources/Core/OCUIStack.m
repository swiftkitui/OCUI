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

@synthesize allFloatSpacers = _allFloatSpacers;

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
    [self addKVOViewSizeChanged];
    self.isCanUpdateContraints = YES;
}

- (void)addSpacerInBothSides {
    NSNumber *leadingTrailing = [self getCurrentAllFloatSpacers].count > 0 || [self isExitFloatView] ? @0 : nil;
    if (![self.nodes.firstObject isKindOfClass:[OCUISpacer class]]) {
        OCUISpacer *spacer = [[OCUISpacer alloc] initWithOffset:leadingTrailing];
        [self.nodes insertObject:spacer atIndex:0];
    }
    if (![self.nodes.lastObject isKindOfClass:[OCUISpacer class]]) {
        OCUISpacer *spacer = [[OCUISpacer alloc] initWithOffset:leadingTrailing];
        [self.nodes addObject:spacer];
    }
}

- (void)setupContraints {}
- (void)updateContraints {}
- (void)addContraints {}

- (void)addKVOViewSizeChanged {
    [self.nodes enumerateObjectsUsingBlock:^(id<OCUIRenderView>  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIView *view = [self viewWithRenderView:obj];
        if ([view isKindOfClass:[UILabel class]]) {
            [view addObserver:self forKeyPath:@"text" options:NSKeyValueObservingOptionNew context:nil];
        }
        [view addObserver:self forKeyPath:@"bounds" options:NSKeyValueObservingOptionNew context:nil];
    }];
}

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary<NSKeyValueChangeKey,id> *)change
                       context:(void *)context {
    [self updateContraints];
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
        if (spacer.flxedOffset) {
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
    if (!spacer.flxedOffset) {
        return 0;
    }
    return spacer.flxedOffset.value;
}

- (NSArray<OCUINode *> *)allFloatSpacers {
    if (!_allFloatSpacers) {
        _allFloatSpacers = [self getCurrentAllFloatSpacers];
    }
    return _allFloatSpacers;
}

- (NSArray<OCUINode *> *)findNodesWithBlock:(BOOL(^)(id<OCUIRenderView> obj))block {
    NSMutableArray<OCUINode *> *spacers = [NSMutableArray array];
    [self.nodes enumerateObjectsUsingBlock:^(id<OCUIRenderView>  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (block(obj)) {
            [spacers addObject:(OCUINode *)obj];
        }
    }];
    return spacers;
}

- (NSArray<OCUISpacer *> *)getCurrentAllFloatSpacers {
    return (NSArray<OCUISpacer *> *)[self findNodesWithBlock:^BOOL(id<OCUIRenderView> obj) {
        if (![obj isKindOfClass:[OCUISpacer class]]) {
            return NO;
        }
        OCUISpacer *spacer = (OCUISpacer *)obj;
        if (spacer.flxedOffset) {
            return NO;
        }
        return YES;
    }];
}

- (CGFloat)minSpacerFloatOffset {
    __block CGFloat offset = 0;
    [self.allFloatSpacers enumerateObjectsUsingBlock:^(OCUISpacer * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        offset += obj.minFloatOffset;
    }];
    return offset;
}

- (CGFloat)maxSpacerFloatOffset {
    __block CGFloat maxOffset = 0;
    [self.allFloatSpacers enumerateObjectsUsingBlock:^(OCUISpacer * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.minFloatOffset > maxOffset) {
            maxOffset = obj.minFloatOffset;
        }
    }];
    return (maxOffset * self.allFloatSpacers.count);
}

@end
