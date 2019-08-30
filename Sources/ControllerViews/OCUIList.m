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
    
}

@end
