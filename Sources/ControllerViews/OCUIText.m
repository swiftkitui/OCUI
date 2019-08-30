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
    return [[UILabel alloc] initWithFrame:CGRectZero];
}

- (void)configOCUIView:(UIView *)view {
    [super configOCUIView:view];
    if (![view isKindOfClass:[UILabel class]]) {
        return;
    }
    UILabel *label = (UILabel *)view;
    label.text = self.content;
    label.viewBind(self.textBind,UILabelIdentifier.text);
}

@end
