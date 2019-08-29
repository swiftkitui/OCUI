//
//  OCUIStack.h
//  OCUI
//
//  Created by 张行 on 2019/8/22.
//  Copyright © 2019 张行. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OCUIText.h"
#import "OCUISpacer.h"

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSUInteger, OCUIStackType) {
    OCUIStackTypeV,
    OCUIStackTypeH,
    OCUIStackTypeZ
};

@interface OCUIStack : NSObject

@property (nonatomic, copy, readonly) NSMutableArray<id<OCUIRenderView>> *nodes;
/// 是否可以更新约束 默认是不可以
@property (nonatomic, assign) BOOL isCanUpdateContraints;
/// 布局依赖的父试图
@property (nonatomic, weak, readonly) UIView *contentView;
/// 获取所有浮动布局 Spacer 的对象数组
@property (nonatomic, copy, readonly) NSArray<OCUISpacer *> *allFloatSpacers;
/**
 最小的浮动间距
 */
@property (nonatomic, assign, readonly) CGFloat minSpacerFloatOffset;
@property (nonatomic, assign, readonly) CGFloat maxSpacerFloatOffset;


- (void)loadAndLayoutViewsInView:(UIView *)view;

/**
 子类重写 用于初始化约束
 */
- (void)setupContraints;

/**
 子类重写 用于更新约束的值
 */
- (void)updateContraints;
/**
 子类重写用于添加约束
 */
- (void)addContraints;

- (UIView *)viewWithRenderView:(id<OCUIRenderView>)renderView;
/**
 获取符合`OCUIRenderView`协议的最适合长度
如果是横向布局 则获取 renderSize 的宽度如果大于0则返回，否则就获取intrinsicContentSize大小的宽度，大于0就返回，否则返回0
如果是纵向布局 则获取 renderSize 的高度如果大于0则返回，否则就获取intrinsicContentSize大小的高度，大于0就返回，否则返回0
 
 @param renderView 符合OCUIRenderView协议的对象
 @param stackType 布局类型
 @return 最适合的大小
 */
- (CGFloat)lenghtWithRenderView:(id<OCUIRenderView>)renderView
                      stackType:(OCUIStackType)stackType;


/**
 自动布局占位符的个数

 @return NSUInteger
 */
- (NSUInteger)automaticSpacerCount;


/**
 自动渲染试图的个数

 @return NSUInteger
 */
- (NSUInteger)automaticRenderViewCountWithStackType:(OCUIStackType)stackType;

/**
 根据 Hash 值获取指定 UIView 试图地址

 @param hash Hah 值
 @return UIView *
 */
- (UIView *)viewWithHash:(NSUInteger)hash;

- (CGFloat)firstOffset;
- (CGFloat)lastOffset;

- (NSArray<OCUINode *> *)findNodesWithBlock:(BOOL(^)(id<OCUIRenderView> obj))block;

- (BOOL)isExitFloatView;

@end

NS_ASSUME_NONNULL_END
