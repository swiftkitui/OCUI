//
//  OCUICreate+OCUIList.h
//  OCUIExample
//
//  Created by 张行 on 2019/9/12.
//  Copyright © 2019 张行. All rights reserved.
//

#import "OCUICreate.h"

NS_ASSUME_NONNULL_BEGIN
@class OCUIList;

@interface OCUICreate (OCUIList)

- (OCUIList *(^)(OCUICreateElenmentBlock))List;

@end

FOUNDATION_EXPORT OCUIList *List(OCUICreateElenmentBlock);

NS_ASSUME_NONNULL_END
