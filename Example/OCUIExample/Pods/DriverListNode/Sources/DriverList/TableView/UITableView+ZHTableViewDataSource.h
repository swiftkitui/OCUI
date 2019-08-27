//
//  UITableView+ZHTableViewDataSource.h
//  ZHTableViewGroup iOS
//
//  Created by 张行 on 2019/8/8.
//  Copyright © 2019 15038777234. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZHTableViewDataSource.h"
#import "DriverDataSource.h"

NS_ASSUME_NONNULL_BEGIN

@interface UITableView (ZHTableViewDataSource)<DriverDataSource>

@property (nonatomic, strong, readonly) ZHTableViewDataSource *tableDataSource;

@end

NS_ASSUME_NONNULL_END
