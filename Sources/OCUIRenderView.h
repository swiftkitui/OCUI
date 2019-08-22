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

- (UIView *)makeOCUIView;

@optional
- (CGSize)renderSize;

@end

NS_ASSUME_NONNULL_END
