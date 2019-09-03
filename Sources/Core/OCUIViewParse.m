//
//  OCUIViewParse.m
//  OCUIExample
//
//  Created by 张行 on 2019/9/3.
//  Copyright © 2019 张行. All rights reserved.
//

#import "OCUIViewParse.h"

@implementation OCUIViewParse {
    NSMutableDictionary<NSString *, OC_VIEW *(^)(void)> *_makeViewBlockMap;
    NSMutableDictionary<NSString *, void(^)(OC_VIEW *, OCUIView *)> *_configViewBlockMap;
    NSMutableDictionary<NSString *, void(^)(OCUIStack *)> *_layoutViewBlockMap;
}

+ (instancetype)shareParse {
    static OCUIViewParse *parse;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        parse = [[OCUIViewParse alloc] init];
    });
    return parse;
}

- (instancetype)init {
    if (self = [super init]) {
        _makeViewBlockMap = [NSMutableDictionary dictionary];
        _configViewBlockMap = [NSMutableDictionary dictionary];
        _layoutViewBlockMap = [NSMutableDictionary dictionary];
    }
    return self;
}

@end

@implementation OCUIViewParse (MakeView)

- (void)addMakeViewBlock:(OC_VIEW * _Nonnull (^)(void))block
               className:(Class)className {
    if (!block) {
        return;
    }
    _makeViewBlockMap[NSStringFromClass(className)] = block;
}

- (OC_VIEW * _Nonnull (^)(void))makeViewBlockWithClassName:(Class)className {
    return _makeViewBlockMap[NSStringFromClass(className)];
}

@end

@implementation OCUIViewParse (ConfigView)

- (void)addConfigViewBlock:(void (^)(OC_VIEW * _Nonnull, OCUIView * _Nonnull))block
                 className:(Class)className {
    if (!block) {
        return;
    }
    _configViewBlockMap[NSStringFromClass(className)] = block;
}

- (void (^)(OC_VIEW * _Nonnull, OCUIView * _Nonnull))configViewBlockWithClassName:(Class)className {
    return _configViewBlockMap[NSStringFromClass(className)];
}

@end

@implementation OCUIViewParse (Layout)

- (void)addLayoutBlock:(void (^)(OCUIStack * _Nonnull))block
             className:(Class)className {
    if (!block) {
        return;
    }
    _layoutViewBlockMap[NSStringFromClass(className)] = block;
}

- (void (^)(OCUIStack *))layoutViewBlockWithClassName:(Class)className {
    return _layoutViewBlockMap[NSStringFromClass(className)];
}

@end
