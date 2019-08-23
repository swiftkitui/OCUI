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
    UI.alignment(OCUIHorizontalAlignmentTrailing);
    
    UI.Text(@"Hello");
    UI.Text(@"World");
}

@end
