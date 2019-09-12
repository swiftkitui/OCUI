//
//  OCUIList.m
//  OCUIExample
//
//  Created by 张行 on 2019/8/27.
//  Copyright © 2019 张行. All rights reserved.
//

#import "OCUIList.h"

@implementation OCUIList

- (void)loadElenmentInContentView:(UIView *)contentView {
    UITableView *tableView = (UITableView *)self.uiRenderView;
//    [tableView reloadListWithDriverBlock:^{
//        [self.elenments enumerateObjectsUsingBlock:^(OCUINode * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//            if (![obj isKindOfClass:[OCUISection class]]) {
//                return;
//            }
//            OCUISection *section = (OCUISection *)obj;
//            DriverGroup *group = ZHDriverGroup();
//            if (section.headerNodes.count > 0) {
//                DriverNode *header = ZHDriverHeader(UITableViewHeaderFooterView.self, ^DriverBlockContent * _Nonnull{
//                    DriverBlockContent<UITableViewHeaderFooterView *> *content = [[DriverBlockContent alloc] init];
//                    return contentView;
//                });
//            }
//        }];
//    }];
}

@end



