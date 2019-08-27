//
//  ZHCollectionViewDataSource.m
//  Pods
//
//  Created by 张行 on 2018/2/6.
//
//

#import "ZHCollectionViewDataSource.h"
#import "ZHAutoConfigurationCollectionViewDelegate.h"

@interface ZHCollectionViewDataSource ()

@property (nonatomic, strong) NSMutableArray<ZHCollectionViewGroup *> *groups;
@property (nonatomic, weak) UICollectionView *collectionView;
@property (nonatomic, strong) ZHAutoConfigurationCollectionViewDelegate *autoConfiguration;

@end

@implementation ZHCollectionViewDataSource {
	
}

- (void)dealloc {
    NSLog(@"ZHCollectionViewDataSource 释放了");
}

- (instancetype)initWithCollectionView:(UICollectionView *)CollectionView {
    if (self = [super init]) {
        _collectionView = CollectionView;
        _autoConfigurationCollectionViewDelegate = YES;
    }
    return self;
}

- (void)addGroupWithCompletionHandle:(ZHCollectionViewDataSourceAddGroupCompletionHandle)completionHandle {
    ZHCollectionViewGroup *group = [[ZHCollectionViewGroup alloc] init];
    if (completionHandle) {
        completionHandle(group);
    }
    [self.groups addObject:group];
}

- (void)reloadCollectionViewData {
    if (!self.collectionView.dataSource && self.isAutoConfigurationCollectionViewDelegate) {
        self.collectionView.dataSource = self.autoConfiguration;
    }
    if (!self.collectionView.delegate && self.isAutoConfigurationCollectionViewDelegate) {
        self.collectionView.delegate = self.autoConfiguration;
    }
    [self registerClasss];
    [self.collectionView reloadData];
}

+ (NSInteger)numberOfRowsInSectionWithDataSource:(ZHCollectionViewDataSource *)dataSource
                                         section:(NSInteger)section {
    ZHCollectionViewGroup *group = [self groupForSectionWithDataSource:dataSource section:section];
    if (!group) {
        return 0;
    }
    return group.cellCount;
}

+ (UICollectionViewCell *)cellForRowAtWithDataSource:(ZHCollectionViewDataSource *)dataSource
                                      indexPath:(NSIndexPath *)indexPath {
    ZHCollectionViewGroup *group = [self groupForSectionWithDataSource:dataSource section:indexPath.section];
    UICollectionViewCell *cell = [[UICollectionViewCell alloc] initWithFrame:CGRectZero];
    if (!group) {
        return cell;
    }
    UICollectionViewCell *resultCell = [group cellForCollectionViewWithCollectionView:dataSource.collectionView indexPath:indexPath];
    if (!resultCell) {
        return cell;
    }
    return resultCell;
}

+ (NSInteger)numberOfSectionsWithDataSource:(ZHCollectionViewDataSource *)dataSource {
    if (!dataSource) {
        return 0;
    }
    return dataSource.groups.count;
}

+ (void)didSelectRowAtWithDataSource:(ZHCollectionViewDataSource *)dataSource
                           indexPath:(NSIndexPath *)indexPath {
    ZHCollectionViewCell *CollectionViewCell = [self cellForIndexPath:dataSource indexPath:indexPath];
    if (!CollectionViewCell) {
        return;
    }
    UICollectionViewCell *cell = [self cellForRowAtWithDataSource:dataSource indexPath:indexPath];
    ZHCollectionViewGroup *group = [self groupForSectionWithDataSource:dataSource section:indexPath.section];
    [CollectionViewCell didSelectRowAtWithCell:cell indexPath:[group indexPathWithCell:CollectionViewCell indexPath:indexPath]];
}

+ (UICollectionReusableView *)viewForHeaderInSectionWithDataSource:(ZHCollectionViewDataSource *)dataSource
                                                              section:(NSInteger)section {
    return [self viewHeaderFooterInSectionWithDtaSource:dataSource section:section style:ZHCollectionViewHeaderFooterStyleHeader];
}

+ (UICollectionReusableView *)viewForFooterInSectionWithDataSource:(ZHCollectionViewDataSource *)dataSource
                                                              section:(NSInteger)section {
    return [self viewHeaderFooterInSectionWithDtaSource:dataSource section:section style:ZHCollectionViewHeaderFooterStyleFooter];
}

- (void)clearData {
    [self.groups removeAllObjects];
}

+ (UICollectionReusableView *)viewHeaderFooterInSectionWithDtaSource:(ZHCollectionViewDataSource *)dataSource
                                                                section:(NSInteger)section style:(ZHCollectionViewHeaderFooterStyle)style {
    ZHCollectionViewGroup *group = [self groupForSectionWithDataSource:dataSource section:section];
    if (!group) {
        return nil;
    }
    return [group headerFooterForStyle:style collectionView:dataSource.collectionView section:section];
}

+ (CGFloat)heightWithCustomHandle:(CGFloat)height
           customCompletionHandle:(ZHCollectionViewDataSourceCustomHeightCompletionHandle)customCompletionHandle
                        baseModel:(ZHCollectionViewBaseModel *)baseModel {
    if (height != 0 && height != NSNotFound && height != CGFLOAT_MAX) {
        return height;
    }
    if (customCompletionHandle) {
        return customCompletionHandle(baseModel);
    }
    return 44;
}


+ (ZHCollectionViewGroup *)groupForSectionWithDataSource:(ZHCollectionViewDataSource *)dataSource
                                            section:(NSInteger)section {
    if (!dataSource) {
        return nil;
    }
    if (dataSource.groups.count <= section) {
        return nil;
    }
    return  dataSource.groups[section];
}

+ (ZHCollectionViewCell *)cellForIndexPath:(ZHCollectionViewDataSource *)dataSource
                            indexPath:(NSIndexPath *)indexPath {
    ZHCollectionViewGroup *group = [self groupForSectionWithDataSource:dataSource section:indexPath.section];
    if (!group) {
        return nil;
    }
    return [group CollectionViewCellForIndexPath:indexPath];
}

+ (NSIndexPath *)indexPathWithDataSource:(ZHCollectionViewDataSource *)dataSource indexPath:(NSIndexPath *)indexPath {
    ZHCollectionViewGroup *group = [self groupForSectionWithDataSource:dataSource section:indexPath.section];
    ZHCollectionViewCell *CollectionViewCell = [self cellForIndexPath:dataSource indexPath:indexPath];
    return [group indexPathWithCell:CollectionViewCell indexPath:indexPath];
}

+ (CGSize)sizeForItemWithDataSource:(ZHCollectionViewDataSource *)dataSource indexPath:(NSIndexPath *)indexPath {
	ZHCollectionViewCell *cell = [self cellForIndexPath:dataSource indexPath:indexPath];
	if (!CGSizeEqualToSize(cell.size, CGSizeZero)) {
		return cell.size;
	}
	UICollectionViewCell *collectionViewCell = [dataSource collectionViewWithClass:cell.anyClass];
	[cell configCellWithCell:collectionViewCell indexPath:indexPath];
	return [collectionViewCell sizeThatFits:[dataSource sizeFit]];
}

+ (CGSize)referenceSizeForHeaderFooterWithDataSource:(ZHCollectionViewDataSource *)dataSource style:(ZHCollectionViewHeaderFooterStyle)style section:(NSUInteger)section {
	ZHCollectionViewGroup *group = [self groupForSectionWithDataSource:dataSource section:section];
	ZHCollectionViewHeaderFooter *headerFooter  = style == ZHCollectionViewHeaderFooterStyleHeader ? group.header : group.footer;
	if (!CGSizeEqualToSize(headerFooter.size, CGSizeZero)) {
		return headerFooter.size;
	}
	UICollectionReusableView *view = [[headerFooter.anyClass alloc] initWithFrame:CGRectZero];
	[headerFooter setHeaderFooter:view section:section];
	return [view sizeThatFits:[dataSource sizeFit]];
}

- (UICollectionViewCell *)collectionViewWithClass:(Class)class {
	UICollectionViewCell *cell = [[class alloc] initWithFrame:CGRectZero];
	return cell;
}

- (CGSize)sizeFit {
	return CGSizeMake(CGRectGetWidth(_collectionView.frame), CGFLOAT_MAX);
}

- (void)registerClasss {
    for (ZHCollectionViewGroup *group in self.groups) {
        [group registerHeaderFooterCellWithCollectionView:self.collectionView];
    }
}

- (NSMutableArray<ZHCollectionViewGroup *> *)groups {
    if (!_groups) {
        _groups = [NSMutableArray array];
    }
    return _groups;
}

- (ZHAutoConfigurationCollectionViewDelegate *)autoConfiguration {
    if (!_autoConfiguration) {
        _autoConfiguration = [[ZHAutoConfigurationCollectionViewDelegate alloc] initWithDataSource:self];
    }
    return _autoConfiguration;
}

@end

