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

FOUNDATION_EXTERN OCUIMaker *Maker(UIView *contentView, OCUICreateElenmentBlock) {
    if (!block) {
        return nil;
    }
    OCUIMaker *make = [[OCUIMaker alloc] initWithElenmentsBlock:block];
    [make loadElenmentInContentView:contentView];
    return make;
}

@implementation OCUIMaker

//- (instancetype)initWithContentView:(UIView *)contentView
//                              stack:(nonnull OCUIStack *)stack {
//    if (self = [super init]) {
//        contentView.uiMaker = self;
//        [contentView addSubview:stack.contentView];
//        [stack.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.edges.mas_equalTo(UIEdgeInsetsZero);
//        }];
//        stack.contentView.widthLayoutItem = OCUICreateLayoutItem(CGRectGetWidth(contentView.frame), stack.contentView, nil, nil);
//        stack.contentView.heightLayoutItem = OCUICreateLayoutItem(CGRectGetHeight(contentView.frame), stack.contentView, nil, nil);
//        [stack startLayout];
//    }
//    return self;
//}

- (void)loadElenmentInContentView:(UIView *)contentView {
    if (!contentView) {
        return;
    }
    [self.elenments enumerateObjectsUsingBlock:^(OCUINode * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj loadElenmentInContentView:contentView];
    }];
}

@end

