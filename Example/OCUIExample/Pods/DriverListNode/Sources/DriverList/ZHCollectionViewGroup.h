//
//  ZHCollectionViewGroup.h
//  Pods
//
//  Created by 张行 on 2018/2/6.
//
//

#import <Foundation/Foundation.h>
#import "ZHCollectionViewHeaderFooter.h"
#import "ZHCollectionViewCell.h"

typedef void(^ZHCollectionViewGroupAddCellCompletionHandle)(ZHCollectionViewCell *cell);
typedef void(^ZHCollectionViewGroupAddHeaderFooterCompletionHandle)(ZHCollectionViewHeaderFooter *headerFooter);

@interface ZHCollectionViewGroup : NSObject

@property (nonatomic, strong) ZHCollectionViewHeaderFooter *header;
@property (nonatomic, strong) ZHCollectionViewHeaderFooter *footer;
@property (nonatomic, assign, readonly) NSInteger cellCount;
@property (nonatomic, strong, readonly) NSMutableArray<ZHCollectionViewCell *> *cells;
@property (nonatomic, assign) UIEdgeInsets sectionEdgeInsets;

- (void)registerHeaderFooterCellWithCollectionView:(UICollectionView *)CollectionView;

- (UICollectionViewCell *)cellForCollectionViewWithCollectionView:(UICollectionView *)CollectionView indexPath:(NSIndexPath *)indexPath;

- (void)addCellWithCompletionHandle:(ZHCollectionViewGroupAddCellCompletionHandle)completionHandle;

- (void)addHeaderWithCompletionHandle:(ZHCollectionViewGroupAddHeaderFooterCompletionHandle)completionHandle;

- (void)addFooterWithCompletionHandle:(ZHCollectionViewGroupAddHeaderFooterCompletionHandle)completionHandle;

- (ZHCollectionViewCell *)CollectionViewCellForIndexPath:(NSIndexPath *)indexPath;

- (UICollectionReusableView *)headerFooterForStyle:(ZHCollectionViewHeaderFooterStyle)style collectionView:(UICollectionView *)collectionView section:(NSUInteger)section;

- (NSIndexPath *)indexPathWithCell:(ZHCollectionViewCell *)cell indexPath:(NSIndexPath *)indexPath;
@end

