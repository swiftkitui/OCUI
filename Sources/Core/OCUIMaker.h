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
#import "OCUISpacer.h"

NS_ASSUME_NONNULL_BEGIN
@class OCUIMaker;

FOUNDATION_EXTERN OCUIMaker *Maker(UIView *contentView, void(^)(void));
FOUNDATION_EXPORT OCUIVStack *VStack(void(^ _Nullable block)(void));
FOUNDATION_EXPORT OCUIHStack *HStack(void(^ _Nullable block)(void));
FOUNDATION_EXPORT OCUIZStack *ZStack(void(^ _Nullable block)(void));
FOUNDATION_EXPORT OCUIText *Text(NSString * _Nullable content);
FOUNDATION_EXPORT OCUISpacer *Spacer();
FOUNDATION_EXPORT OCUIImage *Image(NSString * _Nullable imageName);
FOUNDATION_EXPORT OCUIList *List(void);
FOUNDATION_EXPORT OCUIView *View(void);
FOUNDATION_EXTERN OCUIButton *Button(NSString * _Nullable text,void(^ _Nullable block)(void));
FOUNDATION_EXPORT OCUIToggle *Toggle(BOOL isOn);
FOUNDATION_EXPORT OCUISlider *Slider(CGFloat value);

/// UI 构造器
@interface OCUIMaker : NSObject

@property (nonatomic, weak, readonly) OC_VIEW *contentView;
@property (nonatomic, strong, readonly) OCUIStack *stack;

- (instancetype)initWithContentView:(OC_VIEW *)contentView
                              stack:(OCUIStack *)stack;

@end

@interface UIView (OCUIMaker)

@property (nonatomic, strong) OCUIMaker *uiMaker;

@end

NS_ASSUME_NONNULL_END
