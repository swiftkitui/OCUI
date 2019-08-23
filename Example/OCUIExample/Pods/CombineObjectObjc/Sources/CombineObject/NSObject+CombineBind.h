//
//  NSObject+CombineBind.h
//  CombineObject
//
//  Created by 张行 on 2019/8/2.
//  Copyright © 2019 张行. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CombineValue+Category.h"
#import "CombineView+Category.h"
#import "CombineBind.h"
#import "CombineKey.h"

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (CombineBind)

@property (nonatomic, strong, readonly) CombineBind *bind;
@property (nonatomic, weak) id<CombineValue> wrappedValue;

- (void(^)(CombineBind *, NSString *))viewBind;
- (void(^)(id<CombineValue>, NSString *))updateWrappedValue;

@end

NS_ASSUME_NONNULL_END
