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
#import "OCUIButton.h"

NS_ASSUME_NONNULL_BEGIN
@class OCUIMaker;

FOUNDATION_EXTERN OCUIMaker *Maker(UIView *contentView, OCUICreateElenmentBlock);

/// UI 构造器
@interface OCUIMaker : OCUINode

@end

NS_ASSUME_NONNULL_END
