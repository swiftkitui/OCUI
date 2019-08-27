//
//  DemoViewController.h
//  DriverListExample
//
//  Created by 张行 on 2019/8/19.
//  Copyright © 2019 张行. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DemoViewController : UIViewController

@property (nonatomic, copy) void(^configTableViewDriver)(UITableView *tableView);
@property (nonatomic, copy) void(^action)(UITableView *tableView);

@end

NS_ASSUME_NONNULL_END
