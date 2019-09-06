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


@end

@implementation ViewController {
}

- (void)viewDidLoad {
    [super viewDidLoad];
    Maker(self.view, ^{
        View()
        .backgroundColor([UIColor redColor]);
        View()
        .backgroundColor([UIColor blueColor]);
        View()
        .backgroundColor([UIColor grayColor]);
    });
}

@end
