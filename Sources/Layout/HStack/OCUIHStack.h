//
//  OCUIHStack.h
//  OCUI
//
//  Created by 张行 on 2019/8/22.
//  Copyright © 2019 张行. All rights reserved.
//

#import "OCUIStack.h"
#import "OCUICreate+OCUIHStack.h"

NS_ASSUME_NONNULL_BEGIN

@interface OCUIHStack : OCUIStack

- (CGFloat)intrinsicContentSizeWidth;

@end

@interface OCUIHStack (alignment)

/// 垂直布局里面子元素的横向布局 默认为居中
@property (nonatomic, assign, readonly) OCUIVerticalAlignment uiAlignment;

/**
 设置子元素的布局
 */
- (OCUIHStack *(^)(OCUIVerticalAlignment))alignment;

@end

NS_ASSUME_NONNULL_END
