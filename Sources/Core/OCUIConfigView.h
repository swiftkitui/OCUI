//
//  OCUIConfigView.h
//  OCUIExample
//
//  Created by 张行 on 2019/8/31.
//  Copyright © 2019 张行. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface OCUIConfigView<T:UIView *> : NSObject

+ (void)configView:(UIView *)view
         className:(Class)className
             block:(void(^)(T configView))block;

@end

NS_ASSUME_NONNULL_END
