//
//  OCUIChained.h
//  OCUIExample
//
//  Created by 张行 on 2019/8/27.
//  Copyright © 2019 张行. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CombineObjectObjc/NSObject+CombineBind.h>
#import <DriverListNode/DriverListNode.h>

NS_ASSUME_NONNULL_BEGIN

/**
 用于链式编程
 */
@protocol OCUIChained <NSObject>

/**
 设置宽度
 */
- (id<OCUIChained>(^)(CGFloat))width;
/**
 设置高度
 */
- (id<OCUIChained>(^)(CGFloat))height;
/**
 设置尺寸
 */
- (id<OCUIChained>(^)(CGSize))size;

/**
 设置间距大小
 */
- (id<OCUIChained>(^)(CGFloat))offset;

/**
 动态绑定
 */
- (id<OCUIChained>(^)(CombineBind *))bind;

/**
 设置背景颜色
 */
- (id<OCUIChained>(^)(UIColor *))backgroundColor;
/**
 设置图片
 */
- (id<OCUIChained>(^)(UIImage *))image;

/**
 设置优先级 默认为1000
 */
- (id<OCUIChained>(^)(CGFloat))priority;

/**
 设置最小的浮动间距
 */
- (id<OCUIChained>(^)(CGFloat))min;
/**
 更新浮动的间距
 */
- (id<OCUIChained>(^)(CGFloat))updateFloatOffset;

- (id<OCUIChained>(^)(void(^)(UITableViewCell *,NSUInteger)))config;

@end

NS_ASSUME_NONNULL_END
