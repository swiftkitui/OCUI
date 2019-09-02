//
//  OCUIStack.m
//  OCUI
//
//  Created by 张行 on 2019/8/22.
//  Copyright © 2019 张行. All rights reserved.
//
#import <objc/runtime.h>
#import <Masonry/Masonry.h>
#import "OCUIStack.h"
#import "OCUISpacer.h"


@interface OCUIStack ()

@property (nonatomic, copy) NSMutableArray *nodes;


@end

@implementation OCUIStack {
    OCUIConstraints *_contentViewLenghtContraints;
    OCUIConstraints *_automaticViewLenghtContraints;
    OCUIConstraints *_automaticSpacerLenghtContraints;
    CGFloat _contentViewLenght;
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
    [self addSubViewInSuperView];
    [self setupLayoutContraints];
    [self updateLayoutConstraints];
    [self makeLayoutContraints];
    [self addKVOViewSizeChanged];
    _isCanUpdateContraints = YES;
}

/**
 自动在两端添加 Spacer
 */
- (void)addSpacerInBothSides {
    NSNumber *upDownOffset = [self getCurrentAllFloatSpacers].count > 0 || [self getCurrentAllFloatRenderViews].count > 0 ? @0 : nil;
    if (![self.nodes.firstObject isKindOfClass:[OCUISpacer class]]) {
        OCUISpacer *spacer = [[OCUISpacer alloc] initWithMinOffset:upDownOffset];
        [self.nodes insertObject:spacer atIndex:0];
    }
    if (![self.nodes.lastObject isKindOfClass:[OCUISpacer class]]) {
        OCUISpacer *spacer = [[OCUISpacer alloc] initWithMinOffset:upDownOffset];
        [self.nodes addObject:spacer];
    }
}

/**
 将子试图全部添加到父试图里面
 */
- (void)addSubViewInSuperView {
    [self.nodes enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIView *makeView = [self viewWithObj:obj];
        if (makeView) {
            [self.contentView addSubview:makeView];
        }
    }];
}

@end

@implementation OCUIStack (RenderView)

- (UIView *)viewWithObj:(OCUINode *)obj {
    if (!obj) {
        return nil;
    }
    UIView *makeView = objc_getAssociatedObject(obj, @selector(viewWithObj:));
    if (!makeView) {
        makeView = [obj makeOCUIView];
        if (makeView) {
            [obj configOCUIView:makeView];
            objc_setAssociatedObject(obj, @selector(viewWithObj:), makeView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        }
    }
    return makeView;
}

- (UIView *)upViewWithObj:(OCUINode *)obj {
    NSUInteger index = [self.nodes indexOfObject:obj];
    __block UIView *upView;
    [self.nodes enumerateObjectsUsingBlock:^(OCUINode *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIView *view = [self viewWithObj:obj];
        if (view && idx < index) {
            upView = view;
        }
    }];
    return upView ?: self.contentView;
}

- (UIView *)downViewWithObj:(OCUINode *)obj {
    NSUInteger index = [self.nodes indexOfObject:obj];
    __block UIView *downView;
    [self.nodes enumerateObjectsUsingBlock:^(OCUINode *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIView *view = [self viewWithObj:obj];
        if (view && idx > index) {
            downView = view;
        }
    }];
    return downView ?: self.contentView;
}

@end

@implementation OCUIStack (Nodes)

/**
 根据指定的条件组装新的数组
 
 @param block 指定的条件的 Block
 @return 筛选之后新的数组
 */
- (NSArray *)findNodesWithBlock:(BOOL(^)(id obj))block {
    NSMutableArray *tempNodes = [NSMutableArray array];
    [self.nodes enumerateObjectsUsingBlock:^(id _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (block(obj)) {
            [tempNodes addObject:obj];
        }
    }];
    return tempNodes;
}

/**
 获取当前所有的支持浮动布局的 Sapcer
 
 @return OCUISpacer数组
 */
- (NSArray<OCUISpacer *> *)getCurrentAllFloatSpacers {
    return (NSArray<OCUISpacer *> *)[self findNodesWithBlock:^BOOL(id obj) {
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

- (NSArray *)getCurrentAllFloatRenderViews {
    NSAssert(NO, @"子类必须重写");
    return nil;
}

@end


@implementation OCUIStack (OCUIContraints)

- (OCUIConstraints *)contentViewLenghtContraints {
    return _contentViewLenghtContraints;
}

- (OCUIConstraints *)automaticViewLenghtContraints {
    return _automaticViewLenghtContraints;
}

- (OCUIConstraints *)automaticSpacerLenghtContraints {
    return _automaticSpacerLenghtContraints;
}

@end

@implementation OCUIStack (LayoutContraints)

/**
 初始化布局约束的条件
 */
- (void)setupLayoutContraints {
    __weak typeof(self) weakSelf = self;
    _contentViewLenghtContraints = [[OCUIConstraints alloc] initWithValue:[self contentLenght]];
    _automaticViewLenghtContraints.contraintsValueChanged = ^(CGFloat value, MASConstraint *contraints) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (!strongSelf.isCanUpdateContraints) {
            return;
        }
        [strongSelf updateLayoutConstraints];
    };
}
/**
 更新计算布局约束的条件
 */
- (void)updateLayoutConstraints {
    /// 获取父试图的宽度
    CGFloat viewLenght = _contentViewLenght > 0 ? _contentViewLenght : [self contentLenght];
    NSArray *allFloatSpacers = [self getCurrentAllFloatSpacers];
    NSArray *allFloatViews = [self getCurrentAllFloatRenderViews];
    /// 获取自动 Spacer 的个数
    NSUInteger automaticSpacerCount = allFloatSpacers.count;
    /// 如果有自动撑满的UIView 则 Spancer 失效
    NSUInteger automaticRenderViewCount = allFloatViews.count;
    /// 获取布局试图的当前最适合的长度
    CGFloat intrinsicContentLenght = [self intrinsicContentLenght];
    /// 可以自动布局的浮动长度
    CGFloat floatLenght = viewLenght - intrinsicContentLenght;
    if (automaticRenderViewCount > 0) {
        /// 如果可以浮动的宽度此时 小于或者等于最小的间隙 就按照最小的间隙来
        [self  updateFloatLenghtWithMin:[self minFloatLenghtWithNodes:allFloatViews]
                                    max:[self maxFloatLenghtWithNodes:allFloatViews]
                            floatLenght:floatLenght
                             floatNodes:allFloatViews];
    } else if (automaticSpacerCount > 0) {
        /// 如果可以浮动的宽度此时 小于或者等于最小的间隙 就按照最小的间隙来
        [self  updateFloatLenghtWithMin:[self minFloatLenghtWithNodes:allFloatSpacers]
                                    max:[self maxFloatLenghtWithNodes:allFloatSpacers]
                            floatLenght:floatLenght
                             floatNodes:allFloatSpacers];
    }
}

- (void)makeLayoutContraints {
    __block UIView *upView = self.contentView;
    [self.nodes enumerateObjectsUsingBlock:^(OCUINode * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIView *view = [self viewWithObj:obj];
        if (!view) {
            return;
        }
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            /// 布局位置
            [self addAlignmentContraintsWithMake:make];
            
            /// 布局大小
            CGSize intrinsicContentSize = [view intrinsicContentSize];
            /// 是否可以使用试图的大小约束
            BOOL isUseIntrinsicContentSize = intrinsicContentSize.width > 0
            && intrinsicContentSize.height > 0
            && obj.uiIsUseIntrinsicContentSize;
            /// 如果支持自动布局 则按照自动布局计算
            if (!isUseIntrinsicContentSize) {
                /// 不支持自动布局
                [self addSizeContraintsWithMake:make
                                            obj:obj];
            }
            [self addOtherContraintsWithMake:make
                                         obj:obj];
            
        }];
        upView = view;
    }];
}

- (void)addAlignmentContraintsWithMake:(MASConstraintMaker *)make {
    NSAssert(NO, @"子类必须重写");
}

- (void)addSizeContraintsWithMake:(MASConstraintMaker *)make obj:(OCUINode *)obj {
    NSAssert(NO, @"子类必须重写");
}

- (void)addOtherContraintsWithMake:(MASConstraintMaker *)make obj:(OCUINode *)obj {
    NSAssert(NO, @"子类必须重写");
}

- (void)makeContraintsWithMake:(MASConstraintMaker *)make isUp:(BOOL)isUp atIndex:(NSUInteger)index block:(void (^)(CGFloat))block {
    id dependObj;
    if (isUp) {
        dependObj = self.nodes[index - 1];
    } else {
        dependObj = self.nodes[index + 1];
    }
    /// 如果上一个不是OCUISpacer 说明位置是紧紧挨着的
    if (!([dependObj isKindOfClass:[OCUISpacer class]])) {
        block(0);
    } else {
        OCUISpacer *spacer = (OCUISpacer *)dependObj;
        /// 如果存在写死的间距
        if (spacer.flxedOffset) {
            block(spacer.flxedOffset.value);
        } else {
            block(NSNotFound);
        }
    }
}

/**
 根据数据源获取最小的浮动长度

 @param nodes 提供的数据源数组
 @return CGFloat
 */
- (CGFloat)minFloatLenghtWithNodes:(NSArray *)nodes {
    __block CGFloat lenght = 0;
    [nodes enumerateObjectsUsingBlock:^(OCUINode *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        lenght += obj.uiMinFloatLenght;
    }];
    return lenght;
}

/**
 根据提供的数据源获取最大的浮动长度

 @param nodes 提供的数据源数组
 @return CGFloat
 */
- (CGFloat)maxFloatLenghtWithNodes:(NSArray *)nodes {
    __block CGFloat maxLenght = 0;
    [nodes enumerateObjectsUsingBlock:^(OCUINode *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        CGFloat minFloatLengh = obj.uiMinFloatLenght;
        if (minFloatLengh > maxLenght) {
            maxLenght = minFloatLengh;
        }
    }];
    return (maxLenght * nodes.count);
}

/**
 根据最小的浮动长度 最大的浮动长度重新计算每一个浮动试图的浮动长度

 @param min 最小的浮动长度
 @param max 最大的浮动长度
 @param floatLenght 剩余的浮动长度
 @param floatNodes 进行计算的浮动长度视图的数组
 */
- (void)updateFloatLenghtWithMin:(CGFloat)min
                             max:(CGFloat)max
                     floatLenght:(CGFloat)floatLenght
                      floatNodes:(NSArray *)floatNodes {
    /// 如果可以浮动的宽度此时 小于或者等于最小的间隙 就按照最小的间隙来
    if (floatLenght <= min) {
        [floatNodes enumerateObjectsUsingBlock:^(OCUINode * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            obj.floatLenght(obj.uiMinFloatLenght);
        }];
    } else if (floatLenght > min && floatLenght < max) {
        /// 如果大于最小间隙 并且小于最大平均值 先入顺序 优先满足
        [self updateFloatLenghtWithNodes:floatNodes
                             floatLenght:floatLenght];
    } else {
        /// 如果满足平分就平分
        CGFloat averageOffset = floatLenght * 1.0 / floatNodes.count;
        [floatNodes enumerateObjectsUsingBlock:^(OCUINode * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            obj.floatLenght(averageOffset);
        }];
    }
}

/**
 按照设置的优先级进行设置 如果优先级一样 按照第一个优先级最高
 
 @param nodes 剩余进行优先级布局
 @param floatLenght 剩余浮动布局的宽度
 */
- (void)updateFloatLenghtWithNodes:(NSArray *)nodes
                       floatLenght:(CGFloat)floatLenght {
    if (nodes.count == 0 || floatLenght <= 0) {
        return;
    }
    __block OCUINode *node;
    NSMutableArray *tempSpacers = [NSMutableArray arrayWithArray:nodes];
    [tempSpacers enumerateObjectsUsingBlock:^(OCUINode *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        OCUINode *objNode = obj;
        if (!node) {
            node = objNode;
            return;
        }
        if (objNode.uiPriority >= node.uiPriority) {
            node = objNode;
        }
    }];
    CGFloat updateOffset = 0;
    if (nodes.count == 1) {
        updateOffset = MAX(floatLenght, node.uiMinFloatLenght);
    } else {
        updateOffset = node.uiMinFloatLenght;
    }
    node.floatLenght(updateOffset);
    [tempSpacers removeObject:node];
    floatLenght -= updateOffset;
    [self updateFloatLenghtWithNodes:tempSpacers
                         floatLenght:floatLenght];
}

- (CGFloat)contentLenght {
    NSAssert(NO, @"子类必须重写");
    return 0;
}

- (CGFloat)intrinsicContentLenght {
    NSAssert(NO, @"子类必须重写");
    return 0;
}

- (CGSize)intrinsicContentSize {
    NSAssert(NO, @"子类必须重写");
    return CGSizeZero;
}

- (void)updateContentViewLenght:(CGFloat)lenght {
    _contentViewLenght = lenght;
    [self updateLayoutConstraints];
}

@end

@implementation OCUIStack (KVOSize)

- (void)addKVOViewSizeChanged {
    [self.nodes enumerateObjectsUsingBlock:^(OCUINode * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIView *view = [self viewWithObj:obj];
        if ([view isKindOfClass:[UILabel class]]) {
            [view addObserver:self forKeyPath:@"text" options:NSKeyValueObservingOptionNew context:nil];
        }
        [view addObserver:self forKeyPath:@"bounds" options:NSKeyValueObservingOptionNew context:nil];
        [obj addObserver:self forKeyPath:@"uiSize" options:NSKeyValueObservingOptionNew context:nil];
    }];
}

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary<NSKeyValueChangeKey,id> *)change
                       context:(void *)context {
    BOOL isCanUpdateConstrints = ([object isKindOfClass:[UILabel class]] && [keyPath isEqualToString:@"text"])
    || ([object isKindOfClass:[UIView class]] && [keyPath isEqualToString:@"bounds"])
    || ([object isKindOfClass:[OCUINode class]] && [keyPath isEqualToString:@"uiSize"]);
    if (isCanUpdateConstrints) {
        [self updateLayoutConstraints];
    }
}

@end
