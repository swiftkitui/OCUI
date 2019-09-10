//
//  OCUINavigationLink.h
//  OCUIExample
//
//  Created by 张行 on 2019/9/9.
//  Copyright © 2019 张行. All rights reserved.
//

#import "OCUINode.h"

NS_ASSUME_NONNULL_BEGIN

@interface OCUINavigationLink : OCUINode

- (instancetype)initWithDestination:(Class)destination
                              block:(void(^)(void))block;

@end

FOUNDATION_EXPORT OCUINavigationLink *NavigationLink(Class destination, void(^block)(void));

NS_ASSUME_NONNULL_END
