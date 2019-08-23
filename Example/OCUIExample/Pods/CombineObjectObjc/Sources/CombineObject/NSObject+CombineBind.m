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
        identifier = identifier ?: @"";
        id<CombineView> view = (id<CombineView>)self;
        CombineWeakView *weakView = [[CombineWeakView alloc] init];
        weakView.view = view;
        weakView.identifier = identifier;
        [bind.views addObject:weakView];
        [self setViewBind:bind identifier:identifier];
        [self updateView:view bind:bind identifier:identifier];
    };
}

- (CombineBind *)bind {
    CombineBind *bindCache = objc_getAssociatedObject(self, @selector(bind));
    if (!bindCache) {
        __weak id<CombineValue> combindValue = (id<CombineValue>)self;
        bindCache = [[CombineBind alloc] init];
        bindCache.content = combindValue;
        objc_setAssociatedObject(self, @selector(bind), bindCache, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return bindCache;
}

- (void (^)(id<CombineValue> _Nonnull, NSString * _Nonnull))updateWrappedValue {
    return ^(id<CombineValue> value, NSString *identifier) {
        identifier = identifier ?: @"";
        CombineBind *bind = [self viewBinds][identifier];
        bind.content = value;
        for (CombineWeakView *weakView in bind.views) {
            [self updateView:weakView.view bind:bind identifier:weakView.identifier];
        }
    };
}

- (void)setWrappedValue:(id<CombineValue>)wrappedValue {
    self.bind.content = wrappedValue;
    for (CombineWeakView *weakView in self.bind.views) {
        [self updateView:weakView.view bind:self.bind identifier:weakView.identifier];
    }
}

- (void)updateView:(id<CombineView>)view bind:(CombineBind *)bind identifier:(NSString *)identifier {
    if (bind.customSetWrappedValueBlock) {
        CombineBindBlockContent *content = [[CombineBindBlockContent alloc] init];
        content.value = ({
            CombineWeakValue *value = [[CombineWeakValue alloc] init];
            value.value = bind.content;
            value;
        });
        content.view = ({
            CombineWeakView *weakView = [[CombineWeakView alloc] init];
            weakView.view = view;
            weakView;
        });
        content.identifier = identifier;
        bind.customSetWrappedValueBlock(content);
    } else {
        [view setCombineValue:bind.content identifier:identifier];
    }
}

- (id<CombineValue>)wrappedValue {
    return self.bind.content;
}

- (NSMutableDictionary<NSString *,CombineBind *> *)viewBinds {
    return [NSMutableDictionary dictionaryWithDictionary:objc_getAssociatedObject(self, @selector(viewBinds))];
}

- (void)setViewBind:(CombineBind *)bind identifier:(NSString *)identifier {
    NSLog(@"setViewBind");
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionaryWithDictionary:[self viewBinds]];
    dictionary[identifier] = bind;
    objc_setAssociatedObject(self, @selector(viewBinds), dictionary, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

@end
