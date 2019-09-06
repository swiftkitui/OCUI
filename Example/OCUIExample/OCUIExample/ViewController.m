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
#import "DetailViewController.h"
#import "OCUIExample.h"

@interface ViewController ()<UITableViewDelegate>


@end

@implementation ViewController {
    NSString *_title;
    DetailViewController *_destinationViewController;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    _title = [(UITableViewCell *)sender textLabel].text;
    _destinationViewController = (DetailViewController *)segue.destinationViewController;
    _destinationViewController.title = _title;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [OCUIExample exampleWithController:_destinationViewController indexPath:indexPath];
}

@end
