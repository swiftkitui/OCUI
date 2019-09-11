//
//  OCUICreate+OCUIText.h
//  OCUIExample
//
//  Created by 张行 on 2019/9/11.
//  Copyright © 2019 张行. All rights reserved.
//

#import "OCUICreate.h"

NS_ASSUME_NONNULL_BEGIN
@class OCUIText;

@interface OCUICreate (OCUIText)

- (OCUIText *(^)(NSString *content))Text;

@end

FOUNDATION_EXPORT OCUIText *Text(NSString *content);

NS_ASSUME_NONNULL_END
