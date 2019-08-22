//
//  OCUIStack.h
//  OCUI
//
//  Created by 张行 on 2019/8/22.
//  Copyright © 2019 张行. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OCUIText.h"
#import "OCUISpacer.h"

NS_ASSUME_NONNULL_BEGIN

@interface OCUIStack : NSObject

@property (nonatomic, copy, readonly) NSMutableArray<id<OCUIRenderView>> *nodes;
- (OCUIText * _Nonnull (^)(NSString * _Nonnull))Text;
- (OCUISpacer *(^)(void))spacer;

- (void)loadAndLayoutViewsInView:(UIView *)view;

@end

NS_ASSUME_NONNULL_END
