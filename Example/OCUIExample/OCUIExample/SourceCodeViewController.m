//
//  SourceCodeViewController.m
//  OCUIExample
//
//  Created by 张行 on 2019/9/6.
//  Copyright © 2019 张行. All rights reserved.
//

#import "SourceCodeViewController.h"

@interface SourceCodeViewController ()

@end

@implementation SourceCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.textView.text = self.sourceCode;
}

@end
