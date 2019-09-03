//
//  DriverDataSource.h
//  DriverList
//
//  Created by 张行 on 2019/8/19.
//  Copyright © 2019 张行. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DriverList.h"

NS_ASSUME_NONNULL_BEGIN

@protocol DriverDataSource <NSObject>

- (void)reloadListWithDriverBlock:(void(^)(void))block;

@end

NS_ASSUME_NONNULL_END
