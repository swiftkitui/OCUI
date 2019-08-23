//
//  CombineBind.m
//  CombineObject
//
//  Created by 张行 on 2019/8/2.
//  Copyright © 2019 张行. All rights reserved.
//

#import "CombineBind.h"

@implementation CombineBindBlockContent

- (void)registerWrappedValue:(Class)valueClass
                   viewClass:(Class)viewClass
                  identifier:(NSString *)identifier
                       block:(void (^)(id<CombineValue> _Nullable, id<CombineView> _Nullable))block {
    if (![self.value isKindOfClass:valueClass]) {
        return;
    }
    if (![self.view isKindOfClass:viewClass]) {
        return;
    }
    if (![self.identifier isEqualToString:identifier]) {
        return;
    }
    if (block) {
        block(self.value.value,self.view.view);
    }
}

@end

@implementation CombineBind

- (instancetype)init {
    if (self = [super init]) {
        _views = [NSMutableArray array];
    }
    return self;
}

- (void)setContent:(id<CombineValue>)content {
    _content = content;
    if (self.contentChanged) {
        self.contentChanged(content);
    }
}

@end
