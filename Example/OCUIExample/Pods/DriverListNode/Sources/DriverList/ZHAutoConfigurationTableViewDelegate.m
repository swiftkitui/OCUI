//
//  ZHAutoConfigurationTableViewDelegate.m
//  Pods
//
//  Created by 张行 on 2017/4/20.
//
//

#import "ZHAutoConfigurationTableViewDelegate.h"
#import "ZHTableViewDataSource.h"

@interface ZHAutoConfigurationTableViewDelegate ()

@property (nonatomic, weak) ZHTableViewDataSource *dataSource;

@end

@implementation ZHAutoConfigurationTableViewDelegate

- (instancetype)initWithDataSource:(ZHTableViewDataSource *)dataSource {
    if (self = [super init]) {
        _dataSource = dataSource;
    }
    return self;
}

- (ZHTableViewDataSourceCustomHeightCompletionHandle)completionHandleWithTableView:(UITableView *)tableView
                                                                 heightAtIndexPath:(NSIndexPath *)indexPath {
    return ^CGFloat(ZHTableViewBaseModel *model) {
        if (!model.customHeightCompletionHandle) {
            return model.height;
        }
        NSIndexPath *reallyIndexPath = [ZHTableViewDataSource indexPathWithDataSource:self->_dataSource
                                                                            indexPath:indexPath];
        return model.customHeightCompletionHandle(tableView,reallyIndexPath,model);
    };;
}

- (CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZHTableViewDataSourceCustomHeightCompletionHandle handle = [self completionHandleWithTableView:tableView
                                                                                 heightAtIndexPath:indexPath];
    CGFloat height = [ZHTableViewDataSource heightForRowAtDataSource:_dataSource
                                                           indexPath:indexPath
                                        customHeightCompletionHandle:handle];
    if (_dataSource.heightForRowAtIndexPath) {
        _dataSource.heightForRowAtIndexPath(tableView, indexPath, height);
    }
    return height;
}
- (CGFloat)tableView:(UITableView *)tableView
heightForHeaderInSection:(NSInteger)section {
    CGFloat height = [ZHTableViewDataSource heightForHeaderInSectionWithDataSource:_dataSource
                                                                           section:section
                                                      customHeightCompletionHandle:[self completionHandleWithTableView:tableView
                                                                                                     heightAtIndexPath:[NSIndexPath indexPathForRow:0
                                                                                                                                          inSection:section]]];
    if (_dataSource.heightForHeaderInSection) {
        _dataSource.heightForHeaderInSection(tableView, section, height);
    }
    return height;
}
- (CGFloat)tableView:(UITableView *)tableView
heightForFooterInSection:(NSInteger)section {
    CGFloat height = [ZHTableViewDataSource heightForFooterInSectionWithDataSource:_dataSource section:section customHeightCompletionHandle:[self completionHandleWithTableView:tableView heightAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:section]]];
    if (_dataSource.heightForFooterInSection) {
        _dataSource.heightForFooterInSection(tableView, section, height);
    }
    return height;
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [ZHTableViewDataSource viewForHeaderInSectionWithDataSource:_dataSource section:section];
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [ZHTableViewDataSource viewForFooterInSectionWithDataSource:_dataSource section:section];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [ZHTableViewDataSource numberOfRowsInSectionWithDataSource:_dataSource section:section];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [ZHTableViewDataSource cellForRowAtWithDataSource:_dataSource indexPath:indexPath];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [ZHTableViewDataSource numberOfSectionsWithDataSource:_dataSource];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [ZHTableViewDataSource didSelectRowAtWithDataSource:_dataSource indexPath:indexPath];
}

- (void)tableView:(UITableView *)tableView willDisplayFooterView:(UIView *)view forSection:(NSInteger)section {
    
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section {
    
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    [ZHTableViewDataSource dataSource:_dataSource willDisplayCell:cell forRowAtIndexPath:indexPath];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (_dataSource.scrollViewDidScrollCompletionHandle) {
        _dataSource.scrollViewDidScrollCompletionHandle(scrollView);
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    if (_dataSource.scrollViewWillBeginDraggingCompletionHandle) {
        _dataSource.scrollViewWillBeginDraggingCompletionHandle(scrollView);
    }
}

@end
