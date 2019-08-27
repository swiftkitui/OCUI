//
//  OCUIVStack.h
//  OCUI
//
//  Created by 张行 on 2019/8/22.
//  Copyright © 2019 张行. All rights reserved.
//

#import "OCUIStack.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger,OCUIHorizontalAlignment) {
    OCUIHorizontalAlignmentLeading,
    OCUIHorizontalAlignmentCenter,
    OCUIHorizontalAlignmentTrailing
};

@interface OCUIVStack : OCUIStack

/// 垂直布局里面子元素的横向布局 默认为居中
@property (nonatomic, assign, readonly) OCUIHorizontalAlignment stackAlignment;
@property (nonatomic, weak, readonly) UIView *contentView;

/**
 设置子元素的布局
 */
- (OCUIVStack *(^)(OCUIHorizontalAlignment))alignment;

@end

NS_ASSUME_NONNULL_END
