//
//  ViewController.m
//  DriverListExample
//
//  Created by 张行 on 2019/8/19.
//  Copyright © 2019 张行. All rights reserved.
//
#import <DriverListNode/DriverListNode.h>
#import "ViewController.h"
#import "DemoViewController.h"
#import "AutomitcHeightCell.h"
#import "DemoCollectionController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}
- (IBAction)exit:(id)sender {
    exit(0);
}

#pragma mark - 复杂的列表
- (void)setupComplexListWithTableView:(UITableView *)tableView {
    tableView.driverData(MakeDriverGroup {
        list.makeGroup(MakeDriverNode {
            group.makeHeader(ZHDriverNode(MakeDriverBlock(UITableViewHeaderFooterView) {
                [content setConfigBlock:^(UITableViewHeaderFooterView * _Nonnull view, NSUInteger index) {
                    view.textLabel.text = @"固定10个一样的 Cell";
                }];
            }))
            .height(49);
            
            group.makeCell(ZHDriverNode(MakeDriverBlock(UITableViewCell) {
                [content setConfigBlock:^(UITableViewCell * _Nonnull view, NSUInteger index) {
                    view.textLabel.text = [@(index) stringValue];
                }];
            }))
            .height(44)
            .number(10);
        });
        
        list.makeGroup(MakeDriverNode {
            group.makeHeader(ZHDriverNode(MakeDriverBlock(UITableViewHeaderFooterView) {
                [content setConfigBlock:^(UITableViewHeaderFooterView * _Nonnull view, NSUInteger index) {
                    view.textLabel.text = @"展示高度区域";
                }];
            }))
            .height(49);
            
            group.makeCell(ZHDriverNode(MakeDriverBlock(UITableViewCell) {
                [content setConfigBlock:^(UITableViewCell * _Nonnull view, NSUInteger index) {
                    view.textLabel.text = @"这是固定高度30";
                }];
            }))
            .height(30);
            
            group.makeCell(ZHDriverNode(MakeDriverBlock(AutomitcHeightCell) {
                [content setConfigBlock:^(AutomitcHeightCell * _Nonnull view, NSUInteger index) {
                    view.multiLineLabel.text = @"这是自动通过`sizeToFit方法计算自动高度的 Cell,会根据我们自己设置的值返回 Cell 的高度。这是自动通过`sizeToFit方法计算自动高度的 Cell,会根据我们自己设置的值返回 Cell 的高度。";
                }];
            }));
            
            group.makeCell(ZHDriverNode(MakeDriverBlock(UITableViewCell) {
                [content setConfigBlock:^(UITableViewCell * _Nonnull view, NSUInteger index) {
                    view.textLabel.text = @"这个是自定义高度100";
                }];
                [content setCustomHeightBlock:^CGFloat(UITableViewCell * _Nonnull view, NSUInteger index) {
                    return 100;
                }];
            }))
            .height(50);
        });
        
        list.makeGroup(MakeDriverNode {
            group.makeHeader(ZHDriverNode(MakeDriverBlock(UITableViewHeaderFooterView) {
                [content setConfigBlock:^(UITableViewHeaderFooterView * _Nonnull view, NSUInteger index) {
                    view.textLabel.text = @"创建间隙";
                }];
            }))
            .height(49);
            
            group.makeSpeacer(UIColor.lightGrayColor);
            
            group.makeFooter(ZHDriverNode(MakeDriverBlock(UITableViewHeaderFooterView) {
                [content setConfigBlock:^(UITableViewHeaderFooterView * _Nonnull view, NSUInteger index) {
                    view.textLabel.text = @"展示创建 Footer";
                }];
            }))
            .height(49);
        });
    });
    
}

#pragma mark - 普通的文本列表
- (void)setupTextListWithTableView:(UITableView *)tableView {
    NSUInteger count = arc4random() % 10 + 1;
    tableView.driverData(MakeDriverGroup {
        list.makeGroup(MakeDriverNode {
            group.makeCell(ZHDriverNode(MakeDriverBlock(UITableViewCell) {
                [content setConfigBlock:^(UITableViewCell * _Nonnull view, NSUInteger index) {
                    view.textLabel.text = [@(index) stringValue];
                }];
            }))
            .number(count)
            .height(44);
        });
    });
}

#pragma mark - 全局刷新
- (void)setupReloadAllDataWithTableView:(UITableView *)tableView
                                  texts:(NSArray<NSString *> *)texts {
    tableView.driverData(MakeDriverGroup {
        list.makeGroup(MakeDriverNode {
            group.makeCell(ZHDriverNode(MakeDriverBlock(UITableViewCell) {
                [content setConfigBlock:^(UITableViewCell * _Nonnull view, NSUInteger index) {
                    view.textLabel.text = texts[index];
                }];
            }))
            .number(texts.count)
            .height(44);
        });
    });
}

#pragma mark - 简单的 CollectionView
- (void)setupSimpleCollectionView:(UICollectionView *)collectionView {
    collectionView.driverData(MakeDriverGroup {
        list.makeGroup(MakeDriverNode {
            group.makeHeader(ZHDriverNode(MakeDriverBlock(UICollectionReusableView) {
                [content setConfigBlock:^(UICollectionReusableView * _Nonnull view, NSUInteger index) {
                    view.backgroundColor = [UIColor lightGrayColor];
                }];
            }))
            .size(CGSizeMake(CGRectGetWidth(collectionView.frame), 49));
            
            group.makeCell(ZHDriverNode(MakeDriverBlock(UICollectionViewCell) {
                [content setConfigBlock:^(UICollectionViewCell * _Nonnull view, NSUInteger index) {
                    view.backgroundColor = index % 2 == 0 ? [UIColor redColor] : [UIColor greenColor];
                }];
            }))
            .size(CGSizeMake(100, 100))
            .number(100);
            
            group.makeFooter(ZHDriverNode(MakeDriverBlock(UICollectionReusableView) {
                [content setConfigBlock:^(UICollectionReusableView * _Nonnull view, NSUInteger index) {
                    view.backgroundColor = [UIColor darkGrayColor];
                }];
            }))
            .size(CGSizeMake(CGRectGetWidth(collectionView.frame), 49));
        })
        .sectionEdgeInsets(UIEdgeInsetsMake(20, 20, 20, 20));
    });
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row <= 2) {
        DemoViewController *controller = [[DemoViewController alloc] initWithNibName:nil bundle:nil];
        controller.configTableViewDriver = ^(UITableView * _Nonnull tableView) {
            if (indexPath.row == 0) {
                [self setupTextListWithTableView:tableView];
            } else if (indexPath.row == 1) {
                [self setupComplexListWithTableView:tableView];
            } else if (indexPath.row == 2) {
                [self setupReloadAllDataWithTableView:tableView texts:nil];
            }
        };
        controller.action = ^(UITableView * _Nonnull tableView) {
            if (indexPath.row == 2) {
                [self setupReloadAllDataWithTableView:tableView texts:@[@"张三",@"李四",@"王五"]];
            }
        };
        [self.navigationController pushViewController:controller animated:YES];
    } else if (indexPath.row == 3) {
        DemoCollectionController *controller = [[DemoCollectionController alloc] initWithNibName:nil bundle:nil];
        controller.configCollectionViewDriver = ^(UICollectionView * _Nonnull collectionView) {
            [self setupSimpleCollectionView:collectionView];
        };
        [self.navigationController pushViewController:controller animated:YES];
    }
}

@end
