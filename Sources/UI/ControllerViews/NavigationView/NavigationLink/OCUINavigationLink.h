//
//  OCUINavigationLink.h
//  OCUIExample
//
//  Created by 张行 on 2019/9/9.
//  Copyright © 2019 张行. All rights reserved.
//

#import "OCUINode.h"
#import "OCUICreate+OCUINavigationLink.h"

NS_ASSUME_NONNULL_BEGIN

@interface OCUINavigationLink : OCUINode

@property (nonatomic, strong) Class destination;

- (instancetype)initWithDestination:(Class)destination
                              block:(void(^)(OCUICreate *c))block;

@end


NS_ASSUME_NONNULL_END
