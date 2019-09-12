//
//  OCUICreate+OCUINavigationView.h
//  OCUIExample
//
//  Created by 张行 on 2019/9/12.
//  Copyright © 2019 张行. All rights reserved.
//

#import "OCUICreate.h"

NS_ASSUME_NONNULL_BEGIN
@class OCUINavigationView;

@interface OCUICreate (OCUINavigationView)

- (OCUINavigationView *(^)(OCUICreateElenmentBlock))NavigationView;;

@end

FOUNDATION_EXPORT OCUINavigationView *NavigationView(OCUICreateElenmentBlock);

NS_ASSUME_NONNULL_END
