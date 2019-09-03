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

/// 当前正在布局的OCUIStack
static OCUIStack *OCUICurrentStack;

FOUNDATION_EXTERN OCUIMaker *Maker(UIView *contentView, void(^block)(void)) {
    OCUIStack *tempStack = OCUICurrentStack;
    OCUICurrentStack = nil;
    if (!block) {
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

FOUNDATION_EXPORT OCUISpacer *Spacer(NSNumber * _Nullable offset) {
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

- (instancetype)initWithContentView:(UIView *)contentView
                              stack:(nonnull OCUIStack *)stack {
    if (self = [super init]) {
        _contentView = contentView;
        _stack = stack;
        [stack startLayoutWithContentView:contentView];
    }
    return self;
}

@end

