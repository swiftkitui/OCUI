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

/// 当前正在布局的OCUIStack
static OCUIStack *OCUICurrentStack;

FOUNDATION_EXTERN OCUIMaker *Maker(UIView *contentView, void(^block)(void)) {
    OCUIStack *tempStack = OCUICurrentStack;
    OCUICurrentStack = nil;
    if (block) {
        block();
    }
    OCUIMaker *make = [[OCUIMaker alloc] initWithContentView:contentView stack:OCUICurrentStack];
    OCUICurrentStack = tempStack;
    return make;
}
FOUNDATION_EXPORT OCUIVStack *VStack(void(^ _Nullable block)(void)) {
    OCUIVStack *stack = [[OCUIVStack alloc] init];
    OCUICurrentStack = stack;
    if (block) {
        block();
    }
    return stack;
}
FOUNDATION_EXPORT OCUIHStack *HStack(void(^ _Nullable block)(void)) {
    OCUIHStack *stack = [[OCUIHStack alloc] init];
    OCUICurrentStack = stack;
    if (block) {
        block();
    }
    return stack;
}
FOUNDATION_EXPORT OCUIZStack *ZStack(void(^ _Nullable block)(void)) {
    OCUIZStack *stack = [[OCUIZStack alloc] init];
    OCUICurrentStack = stack;
    if (block) {
        block();
    }
    return stack;
}
FOUNDATION_EXPORT void AddRenderViewInStack(OCUINode *node) {
    if (!node) {
        return;
    }
    if (!OCUICurrentStack) {
        OCUICurrentStack = VStack(nil);
    }
    [OCUICurrentStack.nodes addObject:node];
}

FOUNDATION_EXPORT OCUIText *Text(NSString *_Nullable content) {
    OCUIText *text = [[OCUIText alloc] initWithText:content];
    AddRenderViewInStack(text);
    return text;
}

FOUNDATION_EXPORT OCUISpacer *Spacer() {
    OCUISpacer *spacer = [OCUISpacer new];
    AddRenderViewInStack(spacer);
    return spacer;
}

FOUNDATION_EXPORT OCUIImage *Image(NSString * _Nullable imageName) {
    OCUIImage *image = [[OCUIImage alloc] initWithImageName:imageName];
    AddRenderViewInStack(image);
    return image;
}

FOUNDATION_EXPORT OCUIList *List(void) {
    OCUIList *list = [[OCUIList alloc] init];
    AddRenderViewInStack(list);
    return list;
}
FOUNDATION_EXTERN OCUIButton *Button(NSString * _Nullable text,void(^ _Nullable block)(void)) {
    OCUIButton *button = [[OCUIButton alloc] initWithText:text make:block];
    AddRenderViewInStack(button);
    return button;
}
FOUNDATION_EXPORT OCUIView *View(void) {
    OCUIView *view = [[OCUIView alloc] init];
    AddRenderViewInStack(view);
    return view;
}

FOUNDATION_EXPORT OCUIToggle *Toggle(BOOL isOn) {
    OCUIToggle *toggle = [[OCUIToggle alloc] initWithIsOn:isOn];
    AddRenderViewInStack(toggle);
    return toggle;
}

FOUNDATION_EXPORT OCUISlider *Slider(CGFloat value) {
    OCUISlider *slider = [[OCUISlider alloc] initWithValue:value];
    AddRenderViewInStack(slider);
    return slider;
}

@implementation OCUIMaker

- (instancetype)initWithContentView:(OC_VIEW *)contentView
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
