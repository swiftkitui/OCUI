//
//  OCUIConfigView.m
//  OCUIExample
//
//  Created by 张行 on 2019/8/31.
//  Copyright © 2019 张行. All rights reserved.
//

#import "OCUIConfigView.h"

@implementation OCUIConfigView

+ (void)configView:(UIView *)view className:(Class)className block:(void (^)(UIView * _Nonnull))block {
    if (view && [view isKindOfClass:className] && block) {
        block(view);
    }
}

@end
