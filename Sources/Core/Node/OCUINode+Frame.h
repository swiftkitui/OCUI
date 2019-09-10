//
//  OCUINode+Frame.h
//  OCUIExample
//
//  Created by 张行 on 2019/9/10.
//  Copyright © 2019 张行. All rights reserved.
//

#import "OCUINode.h"

NS_ASSUME_NONNULL_BEGIN

@interface OCUINode (Frame)

@property (nonatomic, assign, readonly) CGSize uiSize;

- (OCUINode *(^)(CGSize))size;

@end

NS_ASSUME_NONNULL_END
