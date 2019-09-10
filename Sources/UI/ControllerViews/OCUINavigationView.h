//
//  OCUINavigationView.h
//  OCUIExample
//
//  Created by 张行 on 2019/9/9.
//  Copyright © 2019 张行. All rights reserved.
//

#import "OCUINode.h"

NS_ASSUME_NONNULL_BEGIN

@interface OCUINavigationView : OCUINode

- (instancetype)initWithBlock:(void(^)(void))block;

@end

FOUNDATION_EXPORT OCUINavigationView *NavigationView(void(^block)(void));

NS_ASSUME_NONNULL_END
