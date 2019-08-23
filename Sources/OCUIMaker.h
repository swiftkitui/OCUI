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

NS_ASSUME_NONNULL_BEGIN

/// UI 构造器
@interface OCUIMaker : NSObject

@property (nonatomic, strong, readonly) OCUIStack *stack;

- (OCUIText *(^)(NSString *content))Text;
- (OCUISpacer *(^)(void))Spacer;
- (OCUIView *(^)(void))View;

@end

@interface NSObject (OCUIMaker)

- (void)OCUIMaker:(OCUIMaker *)UI;
- (void)loadOCUIInView:(UIView *)view;

@end

NS_ASSUME_NONNULL_END
