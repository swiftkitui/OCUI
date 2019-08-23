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
- (OCUIText *(^)(NSString * _Nonnull))Text;
- (OCUISpacer *(^)(void))Spacer;
- (OCUIView *(^)(void))View;

- (void)loadAndLayoutViewsInView:(UIView *)view;

- (UIView *)viewWithRenderView:(id<OCUIRenderView>)renderView;
- (CGSize)sizeWithRenderView:(id<OCUIRenderView>)renderView;


/**
 自动布局占位符的个数

 @return NSUInteger
 */
- (NSUInteger)automaticSpacerCount;

/**
 自动渲染试图的个数

 @return NSUInteger
 */
- (NSUInteger)automaticRenderViewCount;

@end

NS_ASSUME_NONNULL_END
