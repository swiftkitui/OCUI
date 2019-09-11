//
//  OCUICreate+OCUIView.h
//  OCUIExample
//
//  Created by 张行 on 2019/9/11.
//  Copyright © 2019 张行. All rights reserved.
//

#import "OCUICreate.h"

NS_ASSUME_NONNULL_BEGIN
@class OCUIView;

@interface OCUICreate (OCUIView)

- (OCUIView *(^)(void))View;

@end

FOUNDATION_EXPORT OCUIView *View(void);

NS_ASSUME_NONNULL_END
