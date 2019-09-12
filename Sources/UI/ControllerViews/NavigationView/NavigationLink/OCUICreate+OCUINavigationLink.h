//
//  OCUICreate+OCUINavigationLink.h
//  OCUIExample
//
//  Created by 张行 on 2019/9/12.
//  Copyright © 2019 张行. All rights reserved.
//

#import "OCUICreate.h"

NS_ASSUME_NONNULL_BEGIN
@class OCUINavigationLink;

@interface OCUICreate (OCUINavigationLink)

- (OCUINavigationLink *(^)(Class destination, OCUICreateElenmentBlock))NavigationLink;

@end

FOUNDATION_EXPORT OCUINavigationLink *NavigationLink(Class destination, OCUICreateElenmentBlock);

NS_ASSUME_NONNULL_END
