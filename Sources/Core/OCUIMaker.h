//
//  OCUIMaker.h
//  OCUI
//
//  Created by 张行 on 2019/8/21.
//  Copyright © 2019 张行. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OCUICreate.h"
#import "OCUIHStack.h"
#import "OCUIVStack.h"
#import "OCUIZStack.h"
#import "OCUIImage.h"
#import "OCUIText.h"
#import "OCUINavigationView.h"
#import "OCUIList.h"

NS_ASSUME_NONNULL_BEGIN
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

FOUNDATION_EXTERN OCUIMaker *Maker(UIView *contentView, void(^block)(void));

NS_ASSUME_NONNULL_END
