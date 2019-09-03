//
//  UITableView+ZHTableViewDataSource.m
//  ZHTableViewGroup iOS
//
//  Created by 张行 on 2019/8/8.
//  Copyright © 2019 15038777234. All rights reserved.
//

#import "UITableView+ZHTableViewDataSource.h"
#import <objc/runtime.h>
#import "DriverList.h"

@implementation UITableView (ZHTableViewDataSource)

- (ZHTableViewDataSource *)tableDataSource {
    ZHTableViewDataSource *dataSource = objc_getAssociatedObject(self, @selector(tableDataSource));
    if (!dataSource) {
        dataSource = [[ZHTableViewDataSource alloc] initWithTableView:self];
        objc_setAssociatedObject(self, @selector(tableDataSource), dataSource, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return dataSource;
}

#pragma mark - DriverDataSource
- (void)reloadListWithDriverBlock:(void(^)(void))block {
    [self makeDriverList:^(DriverList * _Nonnull list) {
        ZHDriverList(list);
        if (block) {
            block();
        }
    }];
}

- (void)makeDriverList:(void (^)(DriverList * _Nonnull))block {
    if (!block) {
        return;
    }
    DriverList *list = [[DriverList alloc] init];
    block(list);
    NSArray<DriverGroup *> *groups = list.groups;
    [self.tableDataSource clearData];
    [groups enumerateObjectsUsingBlock:^(DriverGroup * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self.tableDataSource addGroupWithCompletionHandle:^(ZHTableViewGroup *group) {
            if (obj.groupHeader && [obj.groupHeader.anyClass isSubclassOfClass:UITableViewHeaderFooterView.class] && obj.groupHeader.enableCell) {
                [group addHeaderWithCompletionHandle:^(ZHTableViewHeaderFooter *headerFooter) {
                    headerFooter.anyClass = obj.groupHeader.anyClass;
                    headerFooter.identifier = obj.groupHeader.identifier;
                    headerFooter.height = obj.groupHeader.cellHeight;
                    [headerFooter configurationHeader:^(UITableViewHeaderFooterView *header, NSUInteger section) {
                        if (obj.groupHeader.blockContent.configBlock) {
                            obj.groupHeader.blockContent.configBlock(header, section);
                        }
                    }];
                    if (obj.groupHeader.blockContent.customHeightBlock) {
                        [headerFooter setCustomHeightBlock:^CGFloat(UITableViewHeaderFooterView *view, NSUInteger section) {
                            return obj.groupHeader.blockContent.customHeightBlock(view,section);
                        }];
                    }
                }];
            }
            [obj.groupCells enumerateObjectsUsingBlock:^(DriverNode * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                
                if ([obj.anyClass isSubclassOfClass:UITableViewCell.class] && obj.enableCell) {
                    [group addCellWithCompletionHandle:^(ZHTableViewCell *cell) {
                        cell.anyClass = obj.anyClass;
                        cell.identifier = obj.identifier;
                        cell.height = obj.cellHeight;
                        cell.cellNumber = obj.cellNumber;
                        [cell setConfigCompletionHandle:^(UITableViewCell *cell, NSIndexPath *indexPath) {
                            if (obj.blockContent.configBlock) {
                                obj.blockContent.configBlock(cell, indexPath.row);
                            }
                        }];
                        [cell setDidSelectRowCompletionHandle:^(UITableViewCell *cell, NSIndexPath *indexPath) {
                            if (obj.blockContent.didSelectRowBlock) {
                                obj.blockContent.didSelectRowBlock(cell, indexPath.row);
                            }
                        }];
                        if (obj.blockContent.customHeightBlock) {
                            [cell setCustomHeightBlock:^CGFloat(UITableViewCell *cell, NSIndexPath *indexPath) {
                                return obj.blockContent.customHeightBlock(cell,indexPath.row);
                            }];
                        }
                    }];
                }
            }];
            if (obj.groupFooter && [obj.groupFooter.anyClass isSubclassOfClass:UITableViewHeaderFooterView.class] && obj.groupFooter.enableCell) {
                [group addFooterWithCompletionHandle:^(ZHTableViewHeaderFooter *headerFooter) {
                    headerFooter.anyClass = obj.groupFooter.anyClass;
                    headerFooter.identifier = obj.groupFooter.identifier;
                    headerFooter.height = obj.groupFooter.cellHeight;
                    [headerFooter configurationFooter:^(UITableViewHeaderFooterView *footer, NSUInteger section) {
                        if (obj.groupFooter.blockContent.configBlock) {
                            obj.groupFooter.blockContent.configBlock(footer, section);
                        }
                    }];
                    if (obj.groupFooter.blockContent.customHeightBlock) {
                        [headerFooter setCustomHeightBlock:^CGFloat(UITableViewHeaderFooterView *view, NSUInteger section) {
                            return obj.groupFooter.blockContent.customHeightBlock(view,section);
                        }];
                    }
                }];
            }
        }];
    }];
    [self.tableDataSource reloadTableViewData];
}


@end
