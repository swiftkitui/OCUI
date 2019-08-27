//
//  ZHTableViewDataSource.m
//  Pods
//
//  Created by 张行 on 2017/3/18.
//
//

#import "ZHTableViewDataSource.h"
#import "ZHAutoConfigurationTableViewDelegate.h"

@interface ZHTableViewDataSource ()

@property (nonatomic, strong) NSMutableArray<ZHTableViewGroup *> *groups;
@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, strong) ZHAutoConfigurationTableViewDelegate *autoConfiguration;

@end

@implementation ZHTableViewDataSource

- (instancetype)initWithTableView:(UITableView *)tableView {
    if (self = [super init]) {
        _tableView = tableView;
        _autoConfigurationTableViewDelegate = YES;
    }
    return self;
}

- (void)addGroupWithCompletionHandle:(ZHTableViewDataSourceAddGroupCompletionHandle)completionHandle {
    ZHTableViewGroup *group = [[ZHTableViewGroup alloc] init];
    if (completionHandle) {
        completionHandle(group);
    }
    [self.groups addObject:group];
}

- (void)reloadTableViewData {
    if (!self.tableView.dataSource) {
        if (self.isAutoConfigurationTableViewDelegate) {
            self.tableView.dataSource = self.autoConfiguration;
        } else {
            NSAssert(NO, @"必须给 UITableView 设置 DataSource 代理");
        }
    }
    if (!self.tableView.delegate) {
        if (self.isAutoConfigurationTableViewDelegate) {
            self.tableView.delegate = self.autoConfiguration;
        }
    }
    [self registerClass];
    [self.tableView reloadData];
}

+ (NSInteger)numberOfRowsInSectionWithDataSource:(ZHTableViewDataSource *)dataSource
                                         section:(NSInteger)section {
    ZHTableViewGroup *group = [self groupForSectionWithDataSource:dataSource section:section];
    if (!group) {
        return 0;
    }
    return group.cellCount;
}

+ (UITableViewCell *)cellForRowAtWithDataSource:(ZHTableViewDataSource *)dataSource
                                      indexPath:(NSIndexPath *)indexPath {
    return [self cellForRowAtWithDataSource:dataSource indexPath:indexPath config:!dataSource.isWillDisplayData];
}

+ (UITableViewCell *)cellForRowAtWithDataSource:(ZHTableViewDataSource *)dataSource indexPath:(NSIndexPath *)indexPath config:(BOOL)config {
    ZHTableViewGroup *group = [self groupForSectionWithDataSource:dataSource section:indexPath.section];
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    if (!group) {
        return cell;
    }
    UITableViewCell *resultCell = [group cellForTableViewWithTableView:dataSource.tableView indexPath:indexPath config:config];
    if (!resultCell) {
        return cell;
    }
    return resultCell;
}

+ (NSInteger)numberOfSectionsWithDataSource:(ZHTableViewDataSource *)dataSource {
    if (!dataSource) {
        return 0;
    }
    return dataSource.groups.count;
}

+ (CGFloat)heightForRowAtDataSource:(ZHTableViewDataSource *)dataSource
                          indexPath:(NSIndexPath *)indexPath customHeightCompletionHandle:(ZHTableViewDataSourceCustomHeightCompletionHandle)customHeightCompletionHandle {
    ZHTableViewCell *cell = [self cellForIndexPath:dataSource indexPath:indexPath];
    
    if (!cell) {
        return 0;
    }
    if (cell.customHeightBlock) {
        UITableViewCell *tableViewCell = [self cellForRowAtWithDataSource:dataSource indexPath:indexPath];
        NSIndexPath *realyIndexPath = [self indexPathWithDataSource:dataSource
                                                          indexPath:indexPath];
        [cell configCellWithCell:tableViewCell
                       indexPath:realyIndexPath];
        return cell.customHeightBlock(tableViewCell, realyIndexPath);
    }
    if (!dataSource.priorityHeight) {
        CGFloat automaticHeight = ({
            automaticHeight = CGFLOAT_MAX;
            if (cell.height == NSNotFound) {
                UITableViewCell *automaticHeightCell = [self cellForRowAtWithDataSource:dataSource indexPath:indexPath];
                NSIndexPath *realyIndexPath = [self indexPathWithDataSource:dataSource
                                                                  indexPath:indexPath];
                [cell configCellWithCell:automaticHeightCell
                               indexPath:realyIndexPath];
                automaticHeight = [automaticHeightCell sizeThatFits:CGSizeMake([UIScreen mainScreen].bounds.size.width, CGFLOAT_MAX)].height;
            }
            automaticHeight;
        });
        CGFloat height = cell.height;
        if (cell.height == NSNotFound && automaticHeight != CGFLOAT_MAX) {
            height = automaticHeight;
        }
        return [self heightWithCustomHandle:height
                     customCompletionHandle:customHeightCompletionHandle
                                  baseModel:cell];
    } else {
        CGFloat heigh = cell.height;
        if (heigh > 0 && heigh < CGFLOAT_MAX && heigh < NSNotFound) {
            return heigh;
        }
        if (customHeightCompletionHandle) {
            heigh = customHeightCompletionHandle(cell);
            if (heigh > 0 && heigh < CGFLOAT_MAX && heigh < NSNotFound) {
                return heigh;
            }
        }
        CGFloat automaticHeight = ({
            automaticHeight = CGFLOAT_MAX;
            if (cell.height == NSNotFound) {
                UITableViewCell *automaticHeightCell = [self cellForRowAtWithDataSource:dataSource indexPath:indexPath];
                NSIndexPath *realyIndexPath = [self indexPathWithDataSource:dataSource
                                                                  indexPath:indexPath];
                [cell configCellWithCell:automaticHeightCell
                               indexPath:realyIndexPath];
                automaticHeight = [automaticHeightCell sizeThatFits:CGSizeMake([UIScreen mainScreen].bounds.size.width, CGFLOAT_MAX)].height;
            }
            automaticHeight;
        });
        return automaticHeight;
    }
}

+ (void)didSelectRowAtWithDataSource:(ZHTableViewDataSource *)dataSource
                           indexPath:(NSIndexPath *)indexPath {
    
    ZHTableViewCell *tableViewCell = [self cellForIndexPath:dataSource indexPath:indexPath];
    if (!tableViewCell) {
        return;
    }
    __block UITableViewCell *cell = ({
        cell = nil;
        /* 因为点击的 CELL 一定是在屏幕可见的范围之内 所以直接取 */
        [dataSource.tableView.visibleCells enumerateObjectsUsingBlock:^(__kindof UITableViewCell * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSIndexPath *visibleIndexPath = [dataSource.tableView indexPathForCell:obj];
            if ([indexPath compare:visibleIndexPath] == NSOrderedSame) {
                cell = obj;
            }
        }];
        cell;
    });
    if (!cell) {
        return;
    }
	ZHTableViewGroup *group = [self groupForSectionWithDataSource:dataSource section:indexPath.section];
    [tableViewCell didSelectRowAtWithCell:cell indexPath:[group indexPathWithCell:tableViewCell indexPath:indexPath]];
}

+ (CGFloat)heightForHeaderInSectionWithDataSource:(ZHTableViewDataSource *)dataSource
                                          section:(NSInteger)section customHeightCompletionHandle:(ZHTableViewDataSourceCustomHeightCompletionHandle)customHeightCompletionHandle {
    return [self heightForHeaderFooterInSectionWithDataSource:dataSource section:section style:ZHTableViewHeaderFooterStyleHeader customHeightCompletionHandle:customHeightCompletionHandle];
}

+ (CGFloat)heightForFooterInSectionWithDataSource:(ZHTableViewDataSource *)dataSource
                                          section:(NSInteger)section customHeightCompletionHandle:(ZHTableViewDataSourceCustomHeightCompletionHandle)customHeightCompletionHandle {
    return [self heightForHeaderFooterInSectionWithDataSource:dataSource section:section style:ZHTableViewHeaderFooterStyleFooter customHeightCompletionHandle:customHeightCompletionHandle];
}

+ (UITableViewHeaderFooterView *)viewForHeaderInSectionWithDataSource:(ZHTableViewDataSource *)dataSource
                                                              section:(NSInteger)section {
    return [self viewHeaderFooterInSectionWithDtaSource:dataSource section:section style:ZHTableViewHeaderFooterStyleHeader];
}

+ (UITableViewHeaderFooterView *)viewForFooterInSectionWithDataSource:(ZHTableViewDataSource *)dataSource
                                                              section:(NSInteger)section {
    return [self viewHeaderFooterInSectionWithDtaSource:dataSource section:section style:ZHTableViewHeaderFooterStyleFooter];
}

- (void)clearData {
    [self.groups removeAllObjects];
}

+ (UITableViewHeaderFooterView *)viewHeaderFooterInSectionWithDtaSource:(ZHTableViewDataSource *)dataSource
                                                                section:(NSInteger)section style:(ZHTableViewHeaderFooterStyle)style {
    ZHTableViewGroup *group = [self groupForSectionWithDataSource:dataSource section:section];
    if (!group) {
        return nil;
    }
    return [group headerFooterForStyle:style tableView:dataSource.tableView section:section];
}

+ (CGFloat)heightForHeaderFooterInSectionWithDataSource:(ZHTableViewDataSource *)dataSource
                                                section:(NSInteger)section style:(ZHTableViewHeaderFooterStyle)style
                           customHeightCompletionHandle:(ZHTableViewDataSourceCustomHeightCompletionHandle)customHeightCompletionHandle {
    ZHTableViewGroup *group = [self groupForSectionWithDataSource:dataSource section:section];
    if(!group) {
        return 0;
    }
    NSInteger height = 0;
    ZHTableViewBaseModel *baseModel;
    UITableViewHeaderFooterView *headFooter = [self viewHeaderFooterInSectionWithDtaSource:dataSource section:section style:style];
    CGFloat automaticHeight = [headFooter sizeThatFits:CGSizeMake([UIScreen mainScreen].bounds.size.width, CGFLOAT_MAX)].height;
    switch (style) {
        case ZHTableViewHeaderFooterStyleHeader: {
            height = group.header.height;
            baseModel = group.header;
            if (group.header.customHeightBlock) {
                [group.header setHeaderFooter:headFooter section:section];
                return group.header.customHeightBlock(headFooter,section);
            }
        }
            break;
        case  ZHTableViewHeaderFooterStyleFooter: {
            height = group.footer.height;
            baseModel = group.footer;
            if (group.footer.customHeightBlock) {
                [group.footer setHeaderFooter:headFooter section:section];
                return group.footer.customHeightBlock(headFooter,section);
            }
        }
            break;
    }
    if (height == NSNotFound && automaticHeight != CGFLOAT_MAX) {
        height = automaticHeight;
    }
    return [self heightWithCustomHandle:height customCompletionHandle:customHeightCompletionHandle baseModel:baseModel];
}

+ (CGFloat)heightWithCustomHandle:(CGFloat)height
           customCompletionHandle:(ZHTableViewDataSourceCustomHeightCompletionHandle)customCompletionHandle
                        baseModel:(ZHTableViewBaseModel *)baseModel {
    return [self lookBestHeightWithBlock:^CGFloat(NSUInteger index, BOOL *stop) {
        if (index == 0) {
            return height;
        } else if (index == 1 && customCompletionHandle) {
            return customCompletionHandle(baseModel);
        } else {
            *stop = YES;
            return 0;
        }
    }];
}

+ (BOOL)isVirifyHeight:(CGFloat)height {
    return height != NSNotFound && height != CGFLOAT_MAX;
}

+ (CGFloat)lookBestHeightWithBlock:(CGFloat(^)(NSUInteger index, BOOL *stop))block {
    CGFloat height = 0;
    BOOL stop = NO;
    NSUInteger index = 0;
    while (!stop) {
        height = block(index, &stop);
        if ([self isVirifyHeight:height]) {
            return height;
        }
        index ++;
    }
    return height;
}

+ (ZHTableViewGroup *)groupForSectionWithDataSource:(ZHTableViewDataSource *)dataSource
                                            section:(NSInteger)section {
    if (!dataSource) {
        return nil;
    }
    if (dataSource.groups.count <= section) {
        return nil;
    }
    return  dataSource.groups[section];
}

+ (ZHTableViewCell *)cellForIndexPath:(ZHTableViewDataSource *)dataSource
                            indexPath:(NSIndexPath *)indexPath {
    ZHTableViewGroup *group = [self groupForSectionWithDataSource:dataSource section:indexPath.section];
    if (!group) {
        return nil;
    }
    return [group tableViewCellForIndexPath:indexPath];
}

+ (NSIndexPath *)indexPathWithDataSource:(ZHTableViewDataSource *)dataSource indexPath:(NSIndexPath *)indexPath {
	ZHTableViewGroup *group = [self groupForSectionWithDataSource:dataSource section:indexPath.section];
	ZHTableViewCell *tableViewCell = [self cellForIndexPath:dataSource indexPath:indexPath];
	return [group indexPathWithCell:tableViewCell indexPath:indexPath];
}

+ (void)dataSource:(ZHTableViewDataSource *)dataSource
   willDisplayCell:(UITableViewCell *)cell
 forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (!dataSource.isWillDisplayData) {
        return;
    }
    ZHTableViewGroup *group = [self groupForSectionWithDataSource:dataSource
                                                          section:indexPath.section];
    ZHTableViewCell *tableViewCell = [self cellForIndexPath:dataSource
                                                  indexPath:indexPath];
    [group tableViewCell:tableViewCell
              configCell:cell
             atIndexPath:indexPath];
}

- (void)registerClass {
    for (ZHTableViewGroup *group in self.groups) {
        [group registerHeaderFooterCellWithTableView:self.tableView];
    }
}

- (NSMutableArray<ZHTableViewGroup *> *)groups {
    if (!_groups) {
        _groups = [NSMutableArray array];
    }
    return _groups;
}

- (ZHAutoConfigurationTableViewDelegate *)autoConfiguration {
    if (!_autoConfiguration) {
        _autoConfiguration = [[ZHAutoConfigurationTableViewDelegate alloc] initWithDataSource:self];
    }
    return _autoConfiguration;
}

@end
