//
//  CombineValue+Category.h
//  CombineObject
//
//  Created by 张行 on 2019/8/2.
//  Copyright © 2019 张行. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CombineValue.h"

NS_ASSUME_NONNULL_BEGIN

@interface NSString (CombineValue)<CombineValue>
@end

@interface NSNumber (CombineValue)<CombineValue>
@end

@interface UIColor (CombineValue)<CombineValue>

@end

@interface UIFont (CombineValue)<CombineValue>

@end

NS_ASSUME_NONNULL_END
