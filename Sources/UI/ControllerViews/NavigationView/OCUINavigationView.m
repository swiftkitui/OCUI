//
//  OCUINavigationView.m
//  OCUIExample
//
//  Created by 张行 on 2019/9/9.
//  Copyright © 2019 张行. All rights reserved.
//

#import "OCUINavigationView.h"
#import "OCUIVStack.h"

@implementation OCUINavigationView

- (void)loadElenmentInContentView:(UIView *)contentView {
    UIViewController *viewController = OCUIControllerWithView(contentView);
    NSParameterAssert(viewController.navigationController);
    [OCUIVStack boxElenmentsWithElenment:self];
    [self.elenments enumerateObjectsUsingBlock:^(OCUINode * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj loadElenmentInContentView:contentView];
    }];
}

@end



