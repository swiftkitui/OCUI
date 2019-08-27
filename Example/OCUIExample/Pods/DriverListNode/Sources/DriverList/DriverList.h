//
//  DriverList.h
//  DriverList
//
//  Created by 张行 on 2019/8/19.
//  Copyright © 2019 张行. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DriverGroup.h"

NS_ASSUME_NONNULL_BEGIN

#define MakeDriverGroup ^(DriverList *list)

@interface DriverList : NSObject

@property (nonatomic, strong, readonly) NSMutableArray<DriverGroup *> *groups;

- (DriverGroup *(^)(void(^)(DriverGroup *group)))makeGroup;

@end

NS_ASSUME_NONNULL_END
