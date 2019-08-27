//
//  ZHCollectionViewCell.m
//  Pods
//
//  Created by 张行 on 2018/2/6.
//
//

#import "ZHCollectionViewCell.h"

@implementation ZHCollectionViewCell {
}

- (instancetype)init {
    if (self = [super init]) {
        _cellNumber = 1;
    }
    return self;
}

- (void)setConfigCompletionHandle:(void (^)(UICollectionViewCell *, NSIndexPath *))configCompletionHandle {
    _configCompletionHandle = configCompletionHandle;
}

- (void)setDidSelectRowCompletionHandle:(void (^)(UICollectionViewCell *, NSIndexPath *))didSelectRowCompletionHandle {
    _didSelectRowCompletionHandle = didSelectRowCompletionHandle;
}

- (void)didSelectRowAtWithCell:(UICollectionViewCell *)cell
                     indexPath:(NSIndexPath *)indexPath {
    if (!self.didSelectRowCompletionHandle) {
        return;
    }
    self.didSelectRowCompletionHandle(cell,indexPath);
}

- (void)configCellWithCell:(UICollectionViewCell *)cell
                 indexPath:(NSIndexPath *)indexPath {
    if (!self.configCompletionHandle) {
        return;
    }
    self.configCompletionHandle(cell,indexPath);
}

- (void)configurationCellWithCellNumber:(NSUInteger)cellNumber
                             identifier:(NSString *)identifier
                               anyClass:(Class)anyClass
                                 size:(CGSize)size
                 configCompletionHandle:(void (^)(UICollectionViewCell *, NSIndexPath *))configCompletionHandle
           didSelectRowCompletionHandle:(void (^)(UICollectionViewCell *, NSIndexPath *))didSelectRowCompletionHandle {
    self.cellNumber = cellNumber;
    self.identifier = identifier;
    self.anyClass = anyClass;
    self.size = size;
    self.configCompletionHandle = configCompletionHandle;
    self.didSelectRowCompletionHandle = didSelectRowCompletionHandle;
}

@end

