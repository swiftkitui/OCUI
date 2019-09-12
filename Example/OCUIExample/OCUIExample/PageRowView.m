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

- (void)bodyUI:(OCUICreate *)c {
    c.Text(self.title)
    .bold();
    if (self.subTitle) {
        c.Text(self.subTitle);
    }
}

@end

@implementation OCUICreate (PageRowView)

- (PageRowView *(^)(NSString *title, NSString *subTitle))PageRow {
    return ^PageRowView *(NSString *title, NSString *subTitle) {
        return [self addElenment:PageRow(title, subTitle)];
    };
}

@end

FOUNDATION_EXPORT PageRowView *PageRow(NSString *title, NSString *subTitle) {
    return [[PageRowView alloc] initWithTitle:title subTitle:subTitle];
}
