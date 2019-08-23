//
//  CombineWeakValue.h
//  CombineObjectObjc
//
//  Created by 张行 on 2019/8/6.
//

#import <Foundation/Foundation.h>
#import "CombineValue.h"

NS_ASSUME_NONNULL_BEGIN

@interface CombineWeakValue : NSObject

@property (nonatomic, weak) id<CombineValue> value;

@end

NS_ASSUME_NONNULL_END
