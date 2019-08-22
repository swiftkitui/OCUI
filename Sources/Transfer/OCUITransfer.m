//
//  OCUITransfer.m
//  OCUI
//
//  Created by 张行 on 2019/8/21.
//  Copyright © 2019 张行. All rights reserved.
//

#import "OCUITransfer.h"
#import "OCUIMaker.h"
#import <Masonry/Masonry.h>

@implementation OCUITransfer

- (UIView *)transferView:(OCUIMaker *)marker {
    UIView *view = [[UIView alloc] initWithFrame:CGRectZero];
    UILabel *label = nil;
    [view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(view);
    }];
    return view;
}

- (UILabel *)transferLabelWithText:(OCUIText *)text {
    UILabel *label = [[UILabel alloc] init];
    label.text = text.content;
    return label;
}

@end
