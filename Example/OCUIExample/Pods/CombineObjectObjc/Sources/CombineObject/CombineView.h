//
//  CombineView.h
//  CombineObject
//
//  Created by 张行 on 2019/8/2.
//  Copyright © 2019 张行. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CombineValue.h"

NS_ASSUME_NONNULL_BEGIN

@protocol CombineView <NSObject>

- (void)setCombineValue:(id <CombineValue>)value identifier:(NSString *)identifier;

@end

NS_ASSUME_NONNULL_END
