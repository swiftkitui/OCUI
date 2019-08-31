//
//  OCUIMaker.h
//  OCUI
//
//  Created by 张行 on 2019/8/21.
//  Copyright © 2019 张行. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OCUIText.h"
#import "OCUIZStack.h"
#import "OCUIHStack.h"
#import "OCUIVStack.h"
#import "OCUIImage.h"
#import "OCUIList.h"
#import "OCUIButton.h"
#import "OCUIToggle.h"
#import "OCUISlider.h"

NS_ASSUME_NONNULL_BEGIN
@class OCUIMaker;

/// 当前正在布局的OCUIStack
static OCUIStack *OCUICurrentStack;

FOUNDATION_EXTERN OCUIMaker *Maker(void(^)(void));
FOUNDATION_EXPORT OCUIVStack *VStack(void(^ _Nullable block)(void));
FOUNDATION_EXPORT OCUIHStack *HStack(void(^ _Nullable block)(void));
FOUNDATION_EXPORT OCUIZStack *ZStack(void(^ _Nullable block)(void));
FOUNDATION_EXPORT OCUIText *Text(NSString * _Nullable content);
FOUNDATION_EXPORT OCUISpacer *Spacer(NSNumber * _Nullable offset);
FOUNDATION_EXPORT OCUIImage *Image(NSString * _Nullable imageName);
FOUNDATION_EXPORT OCUIList *List(CombineBind<NSArray *> *bind, UITableViewCell *(^block)(void));
FOUNDATION_EXPORT OCUIView *View(void);
FOUNDATION_EXTERN OCUIButton *Button(NSString * _Nullable text,void(^ _Nullable block)(void));
FOUNDATION_EXPORT OCUIToggle *Toggle(BOOL isOn);
FOUNDATION_EXPORT OCUISlider *Slider(CGFloat value);

/// UI 构造器
@interface OCUIMaker : NSObject

@property (nonatomic, strong, readonly) OCUIStack *stack;

- (instancetype)initWithStack:(OCUIStack *)stack;

- (OCUIVStack *(^)(OCUIHorizontalAlignment))alignment;

- (void)loadOCUIInView:(UIView *)view;

@end

@interface NSObject (OCUIMaker)

- (void)loadOCUIInView:(UIView *)view;
- (void)OCUIMaker;
@end

NS_ASSUME_NONNULL_END
