//
//  OCUINode.h
//  OCUI
//
//  Created by 张行 on 2019/8/22.
//  Copyright © 2019 张行. All rights reserved.
//

#import "OCUIHeader.h"

NS_ASSUME_NONNULL_BEGIN
@class OCUINode;

@interface OCUINode : NSObject

@end

@interface OCUINode (Frame)

@property (nonatomic, assign, readonly) CGSize uiSize;

- (OCUINode *(^)(CGSize))size;

@end

@interface OCUINode (OCUIView)

- (OCUINode *(^)(UIColor *))backgroundColor;

@end

NS_ASSUME_NONNULL_END
