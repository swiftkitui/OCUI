//
//  OCUIRenderView.h
//  OCUI
//
//  Created by 张行 on 2019/8/22.
//  Copyright © 2019 张行. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol OCUIRenderView <NSObject>

/**
 返回自定义 UIView 试图

 @return UIView *
 */
- (UIView *)makeOCUIView;
/**
  配置生成的 UIView 试图

 @param view 通过makeOCUIView创建的试图
 */
- (void)configOCUIView:(UIView *)view;

@end

NS_ASSUME_NONNULL_END
