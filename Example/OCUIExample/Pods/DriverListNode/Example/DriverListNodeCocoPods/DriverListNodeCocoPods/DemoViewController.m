//
//  DemoViewController.m
//  DriverListExample
//
//  Created by 张行 on 2019/8/19.
//  Copyright © 2019 张行. All rights reserved.
//

#import "DemoViewController.h"

@interface DemoViewController ()

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation DemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    if (self.configTableViewDriver) {
        self.configTableViewDriver(self.tableView);
    }
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Action" style:UIBarButtonItemStylePlain target:self action:@selector(actionClick)];
}

- (void)actionClick {
    if (self.action) {
        self.action(self.tableView);
    }
}

#pragma mark - Getter
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    }
    return _tableView;
}

@end
