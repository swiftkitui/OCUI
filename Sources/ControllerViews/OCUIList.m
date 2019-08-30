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

- (instancetype)initWithWithBind:(CombineBind *)bind block:(UITableViewCell * _Nonnull (^)(void))block {
    if (self = [super init]) {
        _dataBind = bind;
        _bindRenderView = block();
    }
    return self;
}

- (UIView *)makeOCUIView {
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    return tableView;
}

- (void)configOCUIView:(UIView *)view {
    [super configOCUIView:view];
    if (![view isKindOfClass:[UITableView class]]) {
        return;
    }
    UITableView *tableView = (UITableView *)view;
    NSArray *data = (NSArray *)self.dataBind.wrappedContent;
    [tableView reloadListWithDriverBlock:^{
        ZHDriverCell([self->_bindRenderView class], ^DriverBlockContent * _Nonnull{
            return self->_bindRenderView.ocui.uiDriverBlockContent;
        })
        .number(data.count);
    }];
}

@end
