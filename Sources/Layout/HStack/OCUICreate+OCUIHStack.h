//
//  OCUICreate+OCUIHStack.h
//  OCUIExample
//
//  Created by 张行 on 2019/9/12.
//  Copyright © 2019 张行. All rights reserved.
//

#import "OCUICreate.h"

NS_ASSUME_NONNULL_BEGIN
@class OCUIHStack;

@interface OCUICreate (OCUIHStack)

- (OCUIHStack *(^)(OCUICreateElenmentBlock))HStack;

@end

FOUNDATION_EXPORT OCUIHStack *HStack(OCUICreateElenmentBlock);

NS_ASSUME_NONNULL_END
