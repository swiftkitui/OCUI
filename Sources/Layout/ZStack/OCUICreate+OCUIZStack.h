//
//  OCUICreate+OCUIZStack.h
//  OCUIExample
//
//  Created by 张行 on 2019/9/12.
//  Copyright © 2019 张行. All rights reserved.
//

#import "OCUICreate.h"

NS_ASSUME_NONNULL_BEGIN
@class OCUIZStack;

@interface OCUICreate (OCUIZStack)

- (OCUIZStack *(^)(OCUICreateElenmentBlock))ZStack;

@end

FOUNDATION_EXPORT OCUIZStack *ZStack(OCUICreateElenmentBlock);

NS_ASSUME_NONNULL_END
