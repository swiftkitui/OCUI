//
//  OCUICreate+OCUIButton.h
//  OCUIExample
//
//  Created by 张行 on 2019/9/12.
//  Copyright © 2019 张行. All rights reserved.
//

#import "OCUICreate.h"

NS_ASSUME_NONNULL_BEGIN
@class OCUIButton;

@interface OCUICreate (OCUIButton)

- (OCUIButton *(^)(void(^actionBlock)(void), OCUICreateElenmentBlock))Button;

@end

FOUNDATION_EXPORT OCUIButton *Button(void(^actionBlock)(void), OCUICreateElenmentBlock);

NS_ASSUME_NONNULL_END
