//
//  DetailViewController.m
//  OCUIExample
//
//  Created by 张行 on 2019/9/6.
//  Copyright © 2019 张行. All rights reserved.
//

#import "DetailViewController.h"
#import "SourceCodeViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.navigationController.navigationBar.translucent = NO;
//    Maker(self.view, self.uiMaker);
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    SourceCodeViewController *controller = (SourceCodeViewController *)segue.destinationViewController;
    controller.sourceCode = self.sourceCode;
}


@end
