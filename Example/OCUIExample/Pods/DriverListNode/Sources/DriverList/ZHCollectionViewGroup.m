//
//  ZHCollectionViewGroup.m
//  Pods
//
//  Created by 张行 on 2018/2/6.
//
//

#import "ZHCollectionViewGroup.h"

@interface ZHCollectionViewGroup ()

@property (nonatomic, strong) NSMutableArray<ZHCollectionViewCell *> *cells;

@end

@implementation ZHCollectionViewGroup

- (instancetype)init {
    if (self = [super init]) {
        _sectionEdgeInsets = UIEdgeInsetsZero;
    }
    return self;
}

- (void)registerHeaderFooterCellWithCollectionView:(UICollectionView *)collectionView {
    if (self.header && self.header.identifier) {
        [collectionView registerClass:self.header.anyClass forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:self.header.identifier];
    }
    if (self.footer && self.footer.identifier) {
        [collectionView registerClass:self.footer.anyClass forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:self.footer.identifier];
    }
    for (ZHCollectionViewCell *collectionViewCell in self.cells) {
        if (collectionViewCell.identifier) {
            [collectionView registerClass:collectionViewCell.anyClass forCellWithReuseIdentifier:collectionViewCell.identifier];
        }
    }
}

- (void)addCellWithCompletionHandle:(ZHCollectionViewGroupAddCellCompletionHandle)completionHandle {
    ZHCollectionViewCell *cell = [[ZHCollectionViewCell alloc] init];
    if (completionHandle) {
        completionHandle(cell);
    }
    [self.cells addObject:cell];
}

- (void)addHeaderWithCompletionHandle:(ZHCollectionViewGroupAddHeaderFooterCompletionHandle)completionHandle {
    ZHCollectionViewHeaderFooter *header= [[ZHCollectionViewHeaderFooter alloc] initWithStyle:ZHCollectionViewHeaderFooterStyleHeader];
    if (completionHandle) {
        completionHandle(header);
    }
    _header = header;
}

- (void)addFooterWithCompletionHandle:(ZHCollectionViewGroupAddHeaderFooterCompletionHandle)completionHandle {
    ZHCollectionViewHeaderFooter *footer = [[ZHCollectionViewHeaderFooter alloc] initWithStyle:ZHCollectionViewHeaderFooterStyleFooter];
    if (completionHandle) {
        completionHandle(footer);
    }
    _footer = footer;
}

- (UICollectionViewCell *)cellForCollectionViewWithCollectionView:(UICollectionView *)collectionView indexPath:(NSIndexPath *)indexPath {
    if (!collectionView) {
        return nil;
    }
    ZHCollectionViewCell *collectionViewCell = [self CollectionViewCellForIndexPath:indexPath];
    if (!collectionViewCell) {
        return nil;
    }
    if (!collectionViewCell.identifier) {
        return nil;
    }
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:collectionViewCell.identifier forIndexPath:indexPath];
    [collectionViewCell configCellWithCell:cell indexPath:[self indexPathWithCell:collectionViewCell indexPath:indexPath]];
    return cell;
}

- (NSIndexPath *)indexPathWithCell:(ZHCollectionViewCell *)cell indexPath:(NSIndexPath *)indexPath {
    __block    NSUInteger startIndex = 0;
    [self.cells enumerateObjectsUsingBlock:^(ZHCollectionViewCell * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj == cell) {
            *stop = YES;
            return;
        }
        startIndex += obj.cellNumber;
    }];
    return [NSIndexPath indexPathForRow:indexPath.row - startIndex inSection:indexPath.section];
}

- (ZHCollectionViewCell *)CollectionViewCellForIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row >= self.cellCount) {
        return nil;
    }
    NSInteger count = 0;
    ZHCollectionViewCell *CollectionViewCell;
    for (NSUInteger i = 0; i < self.cells.count; i ++) {
        ZHCollectionViewCell *cell = self.cells[i];
        NSUInteger tempCount = count;
        count += cell.cellNumber;
        if (indexPath.row >= tempCount && indexPath.row < count) {
            CollectionViewCell = cell;
            break;
        }
    }
    return CollectionViewCell;
}

- (UICollectionReusableView *)headerFooterForStyle:(ZHCollectionViewHeaderFooterStyle)style collectionView:(UICollectionView *)collectionView section:(NSUInteger)section {
    if (!collectionView) {
        return nil;
    }
    ZHCollectionViewHeaderFooter *headerFooter;
    NSString *kind;
    switch (style) {
        case ZHCollectionViewHeaderFooterStyleHeader: {
            headerFooter = self.header;
            kind = UICollectionElementKindSectionHeader;
        }
            break;
        case ZHCollectionViewHeaderFooterStyleFooter: {
            headerFooter = self.footer;
            kind = UICollectionElementKindSectionFooter;
        }
            break;
    }
    if (!headerFooter) {
        return nil;
    }
    if (!headerFooter.identifier) {
        return nil;
    }
    UICollectionReusableView *headerFooterView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:headerFooter.identifier forIndexPath:[NSIndexPath indexPathForItem:0 inSection:section]];
    [headerFooter setHeaderFooter:headerFooterView section:section];
    return headerFooterView;
}


- (NSMutableArray<ZHCollectionViewCell *> *)cells {
    if (!_cells) {
        _cells = [NSMutableArray array];
    }
    return _cells;
}

- (NSInteger)cellCount {
    NSInteger count = 0;
    for (ZHCollectionViewCell *collectionViewCell in self.cells) {
        count += collectionViewCell.cellNumber;
    }
    return count;
}

@end

