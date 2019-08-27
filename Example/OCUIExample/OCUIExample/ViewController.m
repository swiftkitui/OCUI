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
    CombineBind<NSString *> *_textBind;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _textBind = CombineBindMaker(@"Hello!");
    [self loadOCUIInView:self.view];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSLog(@"self->_text.wrappedValue");
        self->_textBind.wrappedContent = @"Hello World!";
    });
}

- (void)OCUIMaker {
    HStack(^{
        /// 左侧15
        Spacer(@(15));
        /// 左侧图标25x25
        Image(@"")
        .size(CGSizeMake(25, 25))
        .backgroundColor(UIColor.redColor);
        /// 左侧10
        Spacer(@(10));
        Text(@"飞行模式")
        .priority(750);
        /// 左侧自动布局
        Spacer(nil)
        .min(10);
        Text(@"未连接");
        /// 右侧文本距离15
        Spacer(@(15));
    });
}

@end
