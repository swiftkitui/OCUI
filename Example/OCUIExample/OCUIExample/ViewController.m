//
//  ViewController.m
//  OCUIExample
//
//  Created by 张行 on 2019/8/21.
//  Copyright © 2019 张行. All rights reserved.
//

#import "ViewController.h"
#import "OCUI.h"
#import <CombineObjectObjc/NSObject+CombineBind.h>
#import <Masonry/Masonry.h>

@interface ViewController ()

@property (nonatomic, strong) CombineBind<NSArray *> *bind;
@property (nonatomic, strong) CombineBind<NSNumber *> *toggleBind;

@end

@implementation ViewController {
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _bind = [[CombineBind alloc] initWithContent:@[@"1",@"2",@"3"]];
    _toggleBind = [[CombineBind alloc] initWithContent:@YES];
    [_toggleBind setContentChanged:^(NSNumber * _Nonnull content) {
        NSLog(@"当前 Slider 值:%@",[content stringValue]);
    }];
    [self loadOCUIInView:self.view];
    
}

- (void)OCUIMaker {
    Slider(1).ocui
    .bind(_toggleBind);
}
@end
