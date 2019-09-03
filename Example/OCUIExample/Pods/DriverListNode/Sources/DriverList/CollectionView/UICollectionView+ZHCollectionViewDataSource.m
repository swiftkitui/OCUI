//
//  UICollectionView+ZHCollectionViewDataSource.m
//  DriverList
//
//  Created by 张行 on 2019/8/20.
//  Copyright © 2019 张行. All rights reserved.
//

#import "UICollectionView+ZHCollectionViewDataSource.h"
#import <objc/runtime.h>

@implementation UICollectionView (ZHCollectionViewDataSource)

- (ZHCollectionViewDataSource *)collectionDataSource {
    ZHCollectionViewDataSource *dataSource = objc_getAssociatedObject(self, @selector(collectionDataSource));
    if (!dataSource) {
        dataSource = [[ZHCollectionViewDataSource alloc] initWithCollectionView:self];
        objc_setAssociatedObject(self, @selector(collectionDataSource), dataSource, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
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
    [self.collectionDataSource clearData];
    [groups enumerateObjectsUsingBlock:^(DriverGroup * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self.collectionDataSource addGroupWithCompletionHandle:^(ZHCollectionViewGroup *group) {
            group.sectionEdgeInsets = obj.groupSectionEdgeInsets;
            if (obj.groupHeader && [obj.groupHeader.anyClass isSubclassOfClass:UICollectionReusableView.class] && obj.groupHeader.enableCell) {
                [group addHeaderWithCompletionHandle:^(ZHCollectionViewHeaderFooter *headerFooter) {
                    headerFooter.anyClass = obj.groupHeader.anyClass;
                    headerFooter.identifier = obj.groupHeader.identifier;
                    headerFooter.size = obj.groupHeader.cellSize;
                    [headerFooter configurationHeader:^(UICollectionReusableView *header, NSUInteger section) {
                        if (obj.groupHeader.blockContent.configBlock) {
                            obj.groupHeader.blockContent.configBlock(header, section);
                        }
                    }];
                    if (obj.groupHeader.blockContent.customSizeBlock) {
                        [headerFooter setCustomSizeBlock:^CGSize(UICollectionReusableView *view, NSUInteger section) {
                            return obj.groupHeader.blockContent.customSizeBlock(view,section);
                        }];
                    }
                }];
            }
            [obj.groupCells enumerateObjectsUsingBlock:^(DriverNode * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                
                if ([obj.anyClass isSubclassOfClass:UICollectionViewCell.class] && obj.enableCell) {
                    [group addCellWithCompletionHandle:^(ZHCollectionViewCell *cell) {
                        cell.anyClass = obj.anyClass;
                        cell.identifier = obj.identifier;
                        cell.size = obj.cellSize;
                        cell.cellNumber = obj.cellNumber;
                        [cell setConfigCompletionHandle:^(UICollectionViewCell *cell, NSIndexPath *indexPath) {
                            if (obj.blockContent.configBlock) {
                                obj.blockContent.configBlock(cell, indexPath.row);
                            }
                        }];
                        [cell setDidSelectRowCompletionHandle:^(UICollectionViewCell *cell, NSIndexPath *indexPath) {
                            if (obj.blockContent.didSelectRowBlock) {
                                obj.blockContent.didSelectRowBlock(cell, indexPath.row);
                            }
                        }];
                        if (obj.blockContent.customSizeBlock) {
                            [cell setCustomSizeBlock:^CGSize(UICollectionViewCell *cell, NSIndexPath *indexPath) {
                               return obj.blockContent.customSizeBlock(cell,indexPath.row);
                            }];
                        }
                    }];
                }
            }];
            if (obj.groupFooter && [obj.groupFooter.anyClass isSubclassOfClass:UICollectionReusableView.class] && obj.groupFooter.enableCell) {
                [group addFooterWithCompletionHandle:^(ZHCollectionViewHeaderFooter *headerFooter) {
                    headerFooter.anyClass = obj.groupFooter.anyClass;
                    headerFooter.identifier = obj.groupFooter.identifier;
                    headerFooter.size = obj.groupFooter.cellSize;
                    [headerFooter configurationFooter:^(UICollectionReusableView *footer, NSUInteger section) {
                        if (obj.groupFooter.blockContent.configBlock) {
                            obj.groupFooter.blockContent.configBlock(footer, section);
                        }
                    }];
                    if (obj.groupFooter.blockContent.customSizeBlock) {
                        [headerFooter setCustomSizeBlock:^CGSize(UICollectionReusableView *view, NSUInteger section) {
                            return obj.groupFooter.blockContent.customSizeBlock(view,section);
                        }];
                    }
                }];
            }
        }];
    }];
    [self.collectionDataSource reloadCollectionViewData];
}


@end
