//
//  OCUISpacer.h
//  OCUI
//
//  Created by 张行 on 2019/8/22.
//  Copyright © 2019 张行. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OCUINode.h"
#import "OCUILayoutOffset.h"

NS_ASSUME_NONNULL_BEGIN

@interface OCUISpacer : OCUINode

@property (nonatomic, strong, readonly) OCUILayoutOffset *flxedOffset;
/**
 收缩的最小长度 如果不设置则默认为试图的默认值
 */
@property (nonatomic, assign, readonly) CGFloat uiMinOffset;

- (instancetype)initWithMinOffset:(NSNumber * _Nullable)minOffset;

@end

@interface OCUISpacer (Chained)

/**
 设置收缩的最小长度
 */
- (instancetype(^)(CGFloat))minOffset;

@end

NS_ASSUME_NONNULL_END
