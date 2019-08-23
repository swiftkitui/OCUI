//
//  OCUIMaker.m
//  OCUI
//
//  Created by 张行 on 2019/8/21.
//  Copyright © 2019 张行. All rights reserved.
//
#import <objc/runtime.h>
#import <Masonry/Masonry.h>
#import "OCUIMaker.h"


@implementation OCUIMaker {
    OCUIStack *_stack;
}

- (instancetype)init {
    if (self = [super init]) {
    }
    return self;
}

- (OCUIText * _Nonnull (^)(NSString * _Nonnull))Text {
    return ^OCUIText *(NSString *content) {
        return self.stack.Text(content);
    };
}

- (OCUISpacer * _Nonnull (^)(void))Spacer {
    return ^OCUISpacer *{
        return self.stack.Spacer();
    };
}

- (OCUIView * _Nonnull (^)(void))View {
    return ^OCUIView * {
        return self.stack.View();
    };
}

- (OCUIStack *)stack {
    if (!_stack) {
        _stack = [[OCUIVStack alloc] init];
    }
    return _stack;
}

- (OCUIVStack * _Nonnull (^)(OCUIHorizontalAlignment))alignment {
    return ^OCUIVStack *(OCUIHorizontalAlignment alignment) {
        if ([self.stack isKindOfClass:[OCUIVStack class]]) {
            OCUIVStack *vStack = (OCUIVStack *)self.stack;
            vStack.alignment(alignment);
            return vStack;
        } else {
            return nil;
        }
    };
}

@end

@implementation NSObject (OCUIMaker)

- (void)loadOCUIInView:(UIView *)view {
    OCUIMaker *maker = [[OCUIMaker alloc] init];
    [self OCUIMaker:maker];
    [maker.stack loadAndLayoutViewsInView:view];
}

- (void)OCUIMaker:(OCUIMaker *)UI {}

@end
