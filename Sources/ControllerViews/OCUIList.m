//
//  OCUIList.m
//  OCUIExample
//
//  Created by 张行 on 2019/8/27.
//  Copyright © 2019 张行. All rights reserved.
//

#import "OCUIList.h"
#import <DriverListNode/DriverListNode.h>

@implementation OCUIList {
    UITableViewCell *_bindRenderView;
    void (^_cellConfig)(UITableViewCell * _Nonnull, NSUInteger);
}

- (instancetype)initWithBlock:(void (^)(void))block {
    if (self = [super init]) {
    }
    return self;
}

- (UIView *)makeOCUIView {
    return [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
}

- (void)configOCUIView:(UIView *)view {
    [super configOCUIView:view];
    [OCUIConfigView<UITableView *> configView:view className:[UITableView class] block:^(UITableView * _Nonnull configView) {
        [configView reloadListWithDriverBlock:^{
            ZHDriverCell([self->_bindRenderView class], ^DriverBlockContent * _Nonnull{
                return nil;
            })
            .number(0);
        }];
    }];
}

@end
