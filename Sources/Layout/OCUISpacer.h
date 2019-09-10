//
//  OCUISpacer.h
//  OCUI
//
//  Created by 张行 on 2019/8/22.
//  Copyright © 2019 张行. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OCUINode.h"

NS_ASSUME_NONNULL_BEGIN

@interface OCUISpacer : OCUINode

/// /// 浮动布局 如果值为 NSNotFound 则为固定布局
@property (nonatomic, assign, readonly) CGFloat uiMinOffset;
/// 固定布局 如果值为 NSNotFound 则为浮动布局
@property (nonatomic, assign, readonly) CGFloat uiFlxedOffset;
/// 当前布局的值 最低不能小于浮动最小值
@property (nonatomic, assign, readonly) CGFloat uiOffset;

- (instancetype(^)(CGFloat))minOffset;
- (instancetype(^)(CGFloat))flxedOffset;
- (instancetype(^)(CGFloat))offset;

@end

FOUNDATION_EXPORT OCUISpacer *Spacer(void);

NS_ASSUME_NONNULL_END
