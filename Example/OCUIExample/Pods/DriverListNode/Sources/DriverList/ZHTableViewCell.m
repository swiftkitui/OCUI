//
//  ZHTableViewCell.m
//  Pods
//
//  Created by 张行 on 2017/3/18.
//
//

#import "ZHTableViewCell.h"

@implementation ZHTableViewCell {
}

- (instancetype)init {
    if (self = [super init]) {
        _cellNumber = 1;
    }
    return self;
}

- (void)setConfigCompletionHandle:(void (^)(UITableViewCell *, NSIndexPath *))configCompletionHandle {
    _configCompletionHandle = configCompletionHandle;
}

- (void)setDidSelectRowCompletionHandle:(void (^)(UITableViewCell *, NSIndexPath *))didSelectRowCompletionHandle {
    _didSelectRowCompletionHandle = didSelectRowCompletionHandle;
}

- (void)didSelectRowAtWithCell:(UITableViewCell *)cell
                     indexPath:(NSIndexPath *)indexPath {
    if (!self.didSelectRowCompletionHandle) {
        return;
    }
    self.didSelectRowCompletionHandle(cell,indexPath);
}

- (void)configCellWithCell:(UITableViewCell *)cell
                 indexPath:(NSIndexPath *)indexPath {
    if (!self.configCompletionHandle) {
        return;
    }
    self.configCompletionHandle(cell,indexPath);
}

- (void)configurationCellWithCellNumber:(NSUInteger)cellNumber identifier:(NSString *)identifier anyClass:(Class)anyClass height:(CGFloat)height configCompletionHandle:(void (^)(UITableViewCell *, NSIndexPath *))configCompletionHandle didSelectRowCompletionHandle:(void (^)(UITableViewCell *, NSIndexPath *))didSelectRowCompletionHandle {
    self.cellNumber = cellNumber;
    self.identifier = identifier;
    self.anyClass = anyClass;
    self.height = height;
    self.configCompletionHandle = configCompletionHandle;
    self.didSelectRowCompletionHandle = didSelectRowCompletionHandle;
}

@end
