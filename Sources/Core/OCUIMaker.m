//
//  OCUIMaker.m
//  OCUI
//
//  Created by 张行 on 2019/8/21.
//  Copyright © 2019 张行. All rights reserved.
//
#import <objc/runtime.h>
#import <Masonry/Masonry.h>
#import <objc/runtime.h>
#import "OCUIMaker.h"
#import "OCUILayoutItem.h"



@implementation OCUIMaker

- (instancetype)initWithContentView:(UIView *)contentView
                              stack:(nonnull OCUIStack *)stack {
    if (self = [super init]) {
        contentView.uiMaker = self;
        _contentView = contentView;
        _stack = stack;
        [contentView addSubview:stack.contentView];
        [stack.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsZero);
        }];
        stack.contentView.widthLayoutItem = OCUICreateLayoutItem(CGRectGetWidth(contentView.frame), stack.contentView, nil, nil);
        stack.contentView.heightLayoutItem = OCUICreateLayoutItem(CGRectGetHeight(contentView.frame), stack.contentView, nil, nil);
        [stack startLayout];
    }
    return self;
}

@end

@implementation UIView (OCUIMaker)

- (void)setUiMaker:(OCUIMaker * _Nonnull)uiMaker {
    objc_setAssociatedObject(self, @selector(uiMaker), uiMaker, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (OCUIMaker *)uiMaker {
    return objc_getAssociatedObject(self, @selector(uiMaker));
}

@end

FOUNDATION_EXTERN OCUIMaker *Maker(UIView *contentView, void(^block)(void)) {
    if (!block) {
        return nil;
    }
    NSArray<OCUINode *> *nodes = CreateUINodes(block);
    OCUIMaker *make = [[OCUIMaker alloc] initWithContentView:contentView stack:nil];
    return make;
}
