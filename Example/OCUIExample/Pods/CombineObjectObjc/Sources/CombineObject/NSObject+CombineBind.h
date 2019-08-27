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

@interface NSObject (CombineBind)<CombineView>

- (void(^)(CombineBind *, NSString *))viewBind;
- (void(^)(id<CombineValue>, NSString *))wrappedContent;

- (void)updateWithBind:(CombineBind *)bind
            identifier:(NSString *)identifier;

@end

NS_ASSUME_NONNULL_END
