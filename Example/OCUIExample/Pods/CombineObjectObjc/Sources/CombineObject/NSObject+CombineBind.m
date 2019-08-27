//
//  NSObject+CombineBind.m
//  CombineObject
//
//  Created by 张行 on 2019/8/2.
//  Copyright © 2019 张行. All rights reserved.
//

#import "NSObject+CombineBind.h"
#import "CombineWeakView.h"
#import <objc/runtime.h>

@implementation NSObject (CombineBind)

- (void(^)(CombineBind *, NSString *))viewBind {
    return ^(CombineBind *bind, NSString *identifier) {
        if (!bind) {
            return;
        }
        identifier = identifier ?: @"";
        id<CombineView> view = (id<CombineView>)self;
        CombineWeakView *weakView = [[CombineWeakView alloc] init];
        weakView.view = view;
        weakView.identifier = identifier;
        [bind.views addObject:weakView];
        [self setViewBind:bind identifier:identifier];
        [self updateWithBind:bind identifier:identifier];
    };
}

- (void (^)(id<CombineValue> _Nonnull, NSString * _Nonnull))wrappedContent {
    return ^(id<CombineValue> value, NSString *identifier) {
        identifier = identifier ?: @"";
        CombineBind *bind = [self viewBinds][identifier];
        bind.wrappedContent = value;
    };
}


- (void)updateWithBind:(CombineBind *)bind
            identifier:(NSString *)identifier {
    if (bind.customSetWrappedValueBlock) {
        CombineBindBlockContent *content = [[CombineBindBlockContent alloc] init];
        content.value = ({
            CombineWeakValue *value = [[CombineWeakValue alloc] init];
            value.value = bind.wrappedContent;
            value;
        });
        content.view = ({
            CombineWeakView *weakView = [[CombineWeakView alloc] init];
            weakView.view = self;
            weakView.identifier = identifier;
            weakView;
        });
        bind.customSetWrappedValueBlock(content);
    } else {
        [self setCombineValue:bind.wrappedContent identifier:identifier];
    }
}


- (NSMutableDictionary<NSString *,CombineBind *> *)viewBinds {
    return [NSMutableDictionary dictionaryWithDictionary:objc_getAssociatedObject(self, @selector(viewBinds))];
}

- (void)setViewBind:(CombineBind *)bind identifier:(NSString *)identifier {
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionaryWithDictionary:[self viewBinds]];
    dictionary[identifier] = bind;
    objc_setAssociatedObject(self, @selector(viewBinds), dictionary, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

@end
