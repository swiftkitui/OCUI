//
//  OCUINode+OCUIListStyle.h
//  OCUIExample
//
//  Created by 张行 on 2019/9/12.
//  Copyright © 2019 张行. All rights reserved.
//

#import "OCUINode.h"
#import "OCUIGroupedListStyle.h"

NS_ASSUME_NONNULL_BEGIN

@interface OCUINode (OCUIListStyle)

@property (nonatomic, strong, readonly) OCUIListStyle *uiListStyle;

- (OCUINode *(^)(OCUIListStyle *))listStyle;

@end

NS_ASSUME_NONNULL_END
