//
//  OCUINavigationLink.h
//  OCUIExample
//
//  Created by 张行 on 2019/9/9.
//  Copyright © 2019 张行. All rights reserved.
//

#import "OCUINode.h"
#import "OCUICreate.h"

NS_ASSUME_NONNULL_BEGIN

@interface OCUINavigationLink : OCUINode

@property (nonatomic, strong) Class destination;

- (instancetype)initWithDestination:(Class)destination
                              block:(void(^)(OCUICreate *c))block;

@end

FOUNDATION_EXPORT OCUINavigationLink *NavigationLink(Class destination, OCUICreateElenmentBlock);

@interface OCUICreate (OCUINavigationLink)

- (OCUINavigationLink *(^)(Class destination, OCUICreateElenmentBlock))NavigationLink;

@end

NS_ASSUME_NONNULL_END
