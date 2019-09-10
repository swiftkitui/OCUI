//
//  PageRowView.m
//  OCUIExample
//
//  Created by 张行 on 2019/9/10.
//  Copyright © 2019 张行. All rights reserved.
//

#import "PageRowView.h"

@implementation PageRowView

- (instancetype)initWithTitle:(NSString *)title
                     subTitle:(NSString *)subTitle {
    if (self = [super init]) {
        _title = title;
        _subTitle = subTitle;
    }
    return self;
}

- (void)bodyUI {
    Text(self.title)
    .bold();
    if (self.subTitle) {
        Text(self.subTitle);
    }
}

@end

FOUNDATION_EXPORT PageRowView *PageRow(NSString *title, NSString *subTitle) {
    PageRowView *view = [[PageRowView alloc] initWithTitle:title subTitle:subTitle];
    return view;
}
