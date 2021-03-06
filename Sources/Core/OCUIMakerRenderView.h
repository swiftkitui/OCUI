//
//  OCUIMakerRenderView.h
//  OCUIExample
//
//  Created by 张行 on 2019/9/10.
//  Copyright © 2019 张行. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OCUICreate.h"

NS_ASSUME_NONNULL_BEGIN

@protocol OCUIMakerRenderView <NSObject>

- (void)bodyUI:(OCUICreate *)c;

@end

NS_ASSUME_NONNULL_END
