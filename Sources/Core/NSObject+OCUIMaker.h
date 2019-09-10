//
//  NSObject+OCUIMaker.h
//  OCUIExample
//
//  Created by 张行 on 2019/9/10.
//  Copyright © 2019 张行. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OCUIMakerRenderView.h"

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (OCUIMaker)<OCUIMakerRenderView>

- (void)makeRenderView:(UIView *)view;

@end

NS_ASSUME_NONNULL_END
