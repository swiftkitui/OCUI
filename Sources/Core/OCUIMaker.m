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
FOUNDATION_EXTERN OCUIMaker *Maker(void(^block)(void)) {
    OCUIStack *tempStack = OCUICurrentStack;
    OCUICurrentStack = nil;
    block();
    OCUIMaker *make = [[OCUIMaker alloc] initWithStack:OCUICurrentStack];
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
FOUNDATION_EXPORT void AddRenderViewInStack(id<OCUIRenderView> view) {
    if (!view) {
        return;
    }
    if (!OCUICurrentStack) {
        OCUICurrentStack = VStack(nil);
    }
    [OCUICurrentStack.nodes addObject:view];
}

FOUNDATION_EXPORT OCUIText *Text(NSString *_Nullable content) {
    OCUIText *text = [[OCUIText alloc] initWithText:content];
    AddRenderViewInStack(text);
    return text;
}

FOUNDATION_EXPORT OCUISpacer *Spacer(NSNumber * _Nullable offset) {
    OCUISpacer *spacer = [[OCUISpacer alloc] initWithOffset:offset];
    AddRenderViewInStack(spacer);
    return spacer;
}

FOUNDATION_EXPORT OCUIImage *Image(NSString * _Nullable imageName) {
    OCUIImage *image = [[OCUIImage alloc] initWithImageName:imageName];
    AddRenderViewInStack(image);
    return image;
}

FOUNDATION_EXPORT OCUIList *List(CombineBind<NSArray *> *bind, UITableViewCell *(^block)(void)) {
    OCUIList *list = [[OCUIList alloc] initWithWithBind:bind block:block];
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

@implementation OCUIMaker {
    OCUIStack *_stack;
}

- (instancetype)initWithStack:(OCUIStack *)stack {
    if (self = [super init]) {
        _stack = stack;
    }
    return self;
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

- (void)loadOCUIInView:(UIView *)view {
    [self.stack loadAndLayoutViewsInView:view];
}

@end

@implementation NSObject (OCUIMaker)

- (void)loadOCUIInView:(UIView *)view {
    OCUIMaker *maker = Maker(^{
        [self OCUIMaker];
    });
    objc_setAssociatedObject(self, @selector(OCUIMaker), maker, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [maker loadOCUIInView:view];
}

- (void)OCUIMaker {}

@end
