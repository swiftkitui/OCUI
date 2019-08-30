//
//  OCUIStack.h
//  OCUI
//
//  Created by 张行 on 2019/8/22.
//  Copyright © 2019 张行. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OCUINode.h"
#import "OCUISpacer.h"
#import "OCUIConstraints.h"
#import "NSObject+OCUI.h"

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSUInteger, OCUIStackType) {
    OCUIStackTypeV,
    OCUIStackTypeH,
    OCUIStackTypeZ
};

@interface OCUIStack : NSObject

/**
 布局的对象
 */
@property (nonatomic, copy, readonly) NSMutableArray *nodes;
/// 是否可以更新约束 默认是不可以
@property (nonatomic, assign, readonly) BOOL isCanUpdateContraints;
/// 布局依赖的父试图
@property (nonatomic, weak, readonly) UIView *contentView;

- (void)loadAndLayoutViewsInView:(UIView *)view;


@end

@interface OCUIStack (RenderView)

/**
 根据提供的对象获取绑定生成的 UIView 对象

 @param obj 继承 NSObject 的对象
 @return UIView对象
 */
- (UIView *)viewWithObj:(id)obj;
/**
 查找布局视图对应上一个的 UIView

 @param obj 布局对象
 @return UIView
 */
- (UIView *)upViewWithObj:(id)obj;
/**
 查找布局视图对应下一个的 UIView

 @param obj 布局对象
 @return UIView
 */
- (UIView *)downViewWithObj:(id)obj;

@end

@interface OCUIStack (Nodes)
/**
 根据指定的条件组装新的数组
 
 @param block 指定的条件的 Block
 @return 筛选之后新的数组
 */
- (NSArray *)findNodesWithBlock:(BOOL(^)(id obj))block;
/**
 获取当前所有的支持浮动布局的 Sapcer
 
 @return OCUISpacer数组
 */
- (NSArray<OCUISpacer *> *)getCurrentAllFloatSpacers;

/**
 获取所有的浮动布局 UIView 的对象数组 子类实现 默认为 nil

 @return NSArray *
 */
- (NSArray *)getCurrentAllFloatRenderViews;

@end

@interface OCUIStack (OCUIContraints)

/// 如果是横向布局就是宽度 如果是纵向布局就是高度
@property (nonatomic, strong, readonly) OCUIConstraints *contentViewLenghtContraints;
@property (nonatomic, strong, readonly) OCUIConstraints *automaticViewLenghtContraints;
@property (nonatomic, strong, readonly) OCUIConstraints *automaticSpacerLenghtContraints;

@end

@interface OCUIStack (LayoutContraints)

/**
 初始化布局约束的条件
 */
- (void)setupLayoutContraints;
/**
 更新计算布局约束的条件
 */
- (void)updateLayoutConstraints;

/**
 新建视图的布局约束
 */
- (void)makeLayoutContraints;

/**
  添加排版约束 子类实现

 @param make MASConstraintMaker *
 */
- (void)addAlignmentContraintsWithMake:(MASConstraintMaker *)make;
/**
 添加大小的约束 子类实现

 @param make MASConstraintMaker *
 @param obj 布局的对象
 */
- (void)addSizeContraintsWithMake:(MASConstraintMaker *)make
                              obj:(id)obj;

/**
 添加其他的约束

 @param make MASConstraintMaker *
 @param obj 布局的对象
 */
- (void)addOtherContraintsWithMake:(MASConstraintMaker *)make
                               obj:(id)obj;

- (void)makeContraintsWithMake:(MASConstraintMaker *)make
                          isUp:(BOOL)isUp
                       atIndex:(NSUInteger)index
                         block:(void(^)(CGFloat flxedOffset))block;

/**
 获取当前布局视图的最适合的长度 子类实现 默认为 0

 @return CGFloat
 */
- (CGFloat)intrinsicContentLenght;

/**
 获取布局范围的长度

 @return CGFloat
 */
- (CGFloat)contentLenght;

@end


@interface OCUIStack (KVOSize)

/**
 监听布局试图 Size 的变化进行重新的布局
 */
- (void)addKVOViewSizeChanged;

@end

NS_ASSUME_NONNULL_END
