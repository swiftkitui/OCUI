//
//  CombineBind.m
//  CombineObject
//
//  Created by 张行 on 2019/8/2.
//  Copyright © 2019 张行. All rights reserved.
//

#import "CombineBind.h"
#import "NSObject+CombineBind.h"

@implementation CombineBindBlockContent

- (void)registerCombineViewClass:(Class)viewClass
                      identifier:(NSString *)identifier
                           block:(void (^)(id<CombineValue> _Nonnull, id<CombineView> _Nonnull))block {
    if (![self.value.value conformsToProtocol:@protocol(CombineValue)]) {
        return;
    }
    if (![self.view.view isKindOfClass:viewClass]) {
        return;
    }
    if (![self.view.identifier isEqualToString:identifier]) {
        return;
    }
    if (block) {
        block(self.value.value,self.view.view);
    }
}

@end

@implementation CombineBind

- (instancetype)initWithContent:(id<CombineValue>)content {
    if (self = [super init]) {
        _wrappedContent = content;
        _views = [NSMutableArray array];
    }
    return self;
}

- (void)setWrappedContent:(id<CombineValue>)wrappedContent {
    _wrappedContent = wrappedContent;
    for (CombineWeakView *weakView in self.views) {
        NSObject *view = weakView.view;
        [view updateWithBind:self identifier:weakView.identifier];
    }
    if (self.contentChanged) {
        self.contentChanged(wrappedContent);
    }
}

@end

FOUNDATION_EXPORT CombineBind *CombineBindMaker(id<CombineValue> value) {
    CombineBind *bind = [[CombineBind alloc] initWithContent:value];
    return bind;
}
