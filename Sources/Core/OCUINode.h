//
//  OCUINode.h
//  OCUI
//
//  Created by 张行 on 2019/8/22.
//  Copyright © 2019 张行. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CombineObjectObjc/NSObject+CombineBind.h>
#import <DriverListNode/DriverListNode.h>
#import "OCUIConstraints.h"

NS_ASSUME_NONNULL_BEGIN
@class OCUINode;

@interface OCUINode : NSObject

@end

@interface OCUINode (Frame)

@property (nonatomic, assign, readonly) CGFloat uiWidth;
@property (nonatomic, assign, readonly) CGFloat uiHeight;
@property (nonatomic, assign, readonly) CGSize uiSize;
/// 是否使用 intrinsicContentSize 默认为 YES
@property (nonatomic, assign, readonly) BOOL uiIsUseIntrinsicContentSize;
/// 内容边距 默认为(0,0,0,0)
@property (nonatomic, assign, readonly) UIEdgeInsets uiContentEdgeInsets;
/**
 设置宽度
 */
- (OCUINode *(^)(CGFloat))width;
/**
 设置高度
 */
- (OCUINode *(^)(CGFloat))height;
/**
 设置大小
 */
- (OCUINode *(^)(CGSize))size;

/// 设置是否使用 intrinsicContentSize
- (OCUINode *(^)(BOOL))isUseIntrinsicContentSize;
/// 设置内容的上下左右间距
- (OCUINode *(^)(UIEdgeInsets))contentEdgeInsets;


@end

@interface OCUINode (FloatLayout)

/**
 设置的最小的浮动长度 默认为0
 */
@property (nonatomic, assign, readonly) CGFloat uiMinFloatLenght;
/**
 当前支持的浮动长度 默认为 0
 */
@property (nonatomic, assign, readonly) CGFloat uiFloatLenght;
/// 监听uiFloatLenght的变化
@property (nonatomic, strong, readonly) OCUIConstraints *uiFloatLenghtContraints;

/**
 设置最小的浮动长度
 */
- (OCUINode *(^)(CGFloat))minFloatLengh;
/**
 设置当前的浮动长度 如果小于最小的浮动长度 则按照最小的浮动s长度设置
 */
- (OCUINode *(^)(CGFloat))floatLenght;

@end

@interface OCUINode (Priority)

/**
 布局的优先级 默认为 1000 最大值
 */
@property (nonatomic, assign, readonly) NSUInteger uiPriority;

/**
 设置优先级
 */
- (OCUINode *(^)(CGFloat))priority;

@end

@interface OCUINode (OCUIView)

@property (nonatomic, strong, readonly) UIColor *uiBackgroundColor;

- (OCUINode *(^)(UIColor *))backgroundColor;

@end

@interface OCUINode (List)

@property (nonatomic, strong, readonly) DriverBlockContent *uiDriverBlockContent;
- (OCUINode *(^)(DriverBlockContent *(^)(void)))driverBlockContent;

@end

@interface OCUINode (Button)

@property (nonatomic, copy, readonly) void(^uiButtonAction)(void);
- (OCUINode *(^)(void(^)(void)))action;

@end

@interface OCUINode (Bind)

@property (nonatomic, strong, readonly) CombineBind *uiBind;
- (OCUINode *(^)(CombineBind *))bind;

@end

NS_ASSUME_NONNULL_END
