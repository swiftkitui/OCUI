//
//  OCUIList.m
//  OCUIExample
//
//  Created by 张行 on 2019/8/27.
//  Copyright © 2019 张行. All rights reserved.
//

#import "OCUIList.h"

@implementation OCUIList {
    id<OCUIRenderView> _bindRenderView;
    void (^_cellConfig)(UITableViewCell * _Nonnull, NSUInteger);
}

- (instancetype)initWithWithBind:(CombineBind *)bind block:(id<OCUIRenderView>  _Nonnull (^)(void))block {
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
    if (![view isKindOfClass:[UITableView class]]) {
        return;
    }
    if (![[_bindRenderView class] isSubclassOfClass:[UITableViewCell class]]) {
        return;
    }
    UITableViewCell *cell = (UITableViewCell *)_bindRenderView;
    UITableView *tableView = (UITableView *)view;
    NSArray *data = (NSArray *)self.dataBind.wrappedContent;
    tableView.driverData(MakeDriverGroup {
        list.makeGroup(MakeDriverNode {
            DriverNode *node = ZHDriverNode(cell.class, ^(DriverBlockContent * _Nonnull content) {
                [content setConfigBlock:^(UIView * _Nonnull view, NSUInteger index) {
                    if (self->_cellConfig) {
                        self->_cellConfig(view,index);
                    }
                }];
                [content setDidSelectRowBlock:^(UIView * _Nonnull view, NSUInteger index) {
                    
                }];
            });
            group.makeCell(node)
            .number(data.count);
        });
    });
}

- (id<OCUIChained>  _Nonnull (^)(void (^ _Nonnull)(UITableViewCell * _Nonnull, NSUInteger)))config {
    return ^id<OCUIChained>(void (^block)(UITableViewCell * _Nonnull, NSUInteger)) {
        self->_cellConfig = block;
        return self;
    };
}

@end
