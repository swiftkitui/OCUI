//
//  OCUINode+OCUIViewColor.h
//  OCUIExample
//
//  Created by 张行 on 2019/9/10.
//  Copyright © 2019 张行. All rights reserved.
//

#import "OCUINode.h"
#import "OCUIColor.h"

NS_ASSUME_NONNULL_BEGIN

@interface OCUINode (OCUIViewColor)

@property (nonatomic, strong, readonly) OCUIColor *uiBackgroundColor;

- (OCUINode *(^)(OCUIColor *))backgroundColor;

@end

NS_ASSUME_NONNULL_END
