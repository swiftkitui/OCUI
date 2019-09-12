//
//  OCUICreate+OCUISpacer.h
//  OCUIExample
//
//  Created by 张行 on 2019/9/12.
//  Copyright © 2019 张行. All rights reserved.
//

#import "OCUICreate.h"

NS_ASSUME_NONNULL_BEGIN
@class OCUISpacer;

@interface OCUICreate (OCUISpacer)

- (OCUISpacer *(^)(void))Spacer;

@end

FOUNDATION_EXPORT OCUISpacer *Spacer(void);

NS_ASSUME_NONNULL_END
