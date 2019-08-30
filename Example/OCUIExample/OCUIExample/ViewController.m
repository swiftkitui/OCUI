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

@end

@implementation ViewController {
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _bind = [[CombineBind alloc] initWithContent:@[@"1",@"2",@"3"]];
    [self loadOCUIInView:self.view];

}

- (void)OCUIMaker {
    HStack(^{
        List(self.bind, ^UITableViewCell * _Nonnull{
            UITableViewCell *cell = UITableViewCell.new;
            cell.ocui.driverBlockContent(^DriverBlockContent * {
                DriverBlockContent<UITableViewCell *> *content = [DriverBlockContent new];
                [content setConfigBlock:^(UITableViewCell * _Nonnull view, NSUInteger index) {
                    view.textLabel.text = self.bind.wrappedContent[index];
                }];
                return content;
            });
            return cell;
        });
    });
}
@end
