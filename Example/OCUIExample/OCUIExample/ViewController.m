//
//  ViewController.m
//  OCUIExample
//
//  Created by 张行 on 2019/8/21.
//  Copyright © 2019 张行. All rights reserved.
//

#import "ViewController.h"
#import <OCUI/OCUI.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadOCUIInView:self.view];
}

- (void)OCUIMaker:(OCUIMaker *)UI {
    UI.View()
    .backgroundColor([UIColor redColor]);
    
    UI.View()
    .backgroundColor([UIColor blueColor])
    .size(CGSizeMake(100, 100));

    UI.View()
    .backgroundColor([UIColor grayColor]);
}

@end
