//
//  OCUIiOSLayout.m
//  OCUIExample
//
//  Created by 张行 on 2019/9/3.
//  Copyright © 2019 张行. All rights reserved.
//

#import "OCUIiOSLayout.h"
#import "OCUIMaker.h"

@implementation OCUIiOSLayout

+ (void)loadLayout {
    [self loadHStackLayout];
}

+ (void)loadHStackLayout {
    [OCUIStack<OCUIHStack *> LoadLayoutWithClassName:OCUIHStack.self layoutBlock:^(OCUIHStack * _Nonnull stack) {
        
    }];
}

@end
