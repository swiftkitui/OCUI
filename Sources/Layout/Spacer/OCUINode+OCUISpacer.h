//
//  OCUINode+OCUISpacer.h
//  OCUIExample
//
//  Created by 张行 on 2019/9/12.
//  Copyright © 2019 张行. All rights reserved.
//

#import "OCUINode.h"

NS_ASSUME_NONNULL_BEGIN

@interface OCUINode (OCUISpacerOffset)

/// /// 浮动布局 如果值为 NSNotFound 则为固定布局
@property (nonatomic, assign, readonly) CGFloat uiMinOffset;
/// 固定布局 如果值为 NSNotFound 则为浮动布局
@property (nonatomic, assign, readonly) CGFloat uiFlxedOffset;
/// 当前布局的值 最低不能小于浮动最小值
@property (nonatomic, assign, readonly) CGFloat uiOffset;

- (OCUINode *(^)(CGFloat))minOffset;
- (OCUINode *(^)(CGFloat))flxedOffset;
- (OCUINode *(^)(CGFloat))offset;

@end

NS_ASSUME_NONNULL_END
