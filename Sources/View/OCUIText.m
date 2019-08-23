//
//  OCUIText.m
//  OCUI
//
//  Created by 张行 on 2019/8/21.
//  Copyright © 2019 张行. All rights reserved.
//

#import "OCUIText.h"

@implementation OCUIText

- (instancetype)initWithText:(NSString *)content {
    if (self = [super init]) {
        _content = content;
    }
    return self;
}

- (UIView *)makeOCUIView {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
    label.text = self.content;
    return label;
}

@end
