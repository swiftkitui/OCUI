//
//  OCUICreate+OCUIVStack.h
//  OCUIExample
//
//  Created by 张行 on 2019/9/12.
//  Copyright © 2019 张行. All rights reserved.
//

#import "OCUICreate.h"

NS_ASSUME_NONNULL_BEGIN
@class OCUIVStack;

@interface OCUICreate (OCUIVStack)

- (OCUIVStack *(^)(OCUICreateElenmentBlock))VStack;

@end

FOUNDATION_EXPORT OCUIVStack *VStack(OCUICreateElenmentBlock);

NS_ASSUME_NONNULL_END
