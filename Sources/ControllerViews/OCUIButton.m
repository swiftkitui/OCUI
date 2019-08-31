//
//  OCUIButton.m
//  OCUIExample
//
//  Created by 张行 on 2019/8/30.
//  Copyright © 2019 张行. All rights reserved.
//

#import "OCUIButton.h"
#import "OCUIMaker.h"

@implementation OCUIButton {
    NSString *_buttonText;
    OCUIMaker *_uiMaker;
}

- (instancetype)initWithText:(NSString *)text
                        make:(void(^)(void))makeBlock {
    if (self = [super init]) {
        _buttonText = text;
        if (makeBlock) {
            _uiMaker = Maker(makeBlock);
        }
    }
    return self;
}

- (UIView *)makeOCUIView {
    return [UIButton buttonWithType:UIButtonTypeCustom];
}

- (void)configOCUIView:(UIView *)view {
    [super configOCUIView:view];
    if (![view isKindOfClass:[UIButton class]]) {
        return;
    }
    UIButton *btn = (UIButton *)view;
    OCUINode *node = self.ocui;
    if (_uiMaker) {
        node.isUseIntrinsicContentSize(NO);
        node.size([self intrinsicContentSize]);
        [_uiMaker loadOCUIInView:btn];
        [_uiMaker.stack updateContentViewLenght:[self intrinsicContentSize].height];
    } else {
        [btn setTitle:_buttonText forState:UIControlStateNormal];
    }
    if (node.uiButtonAction) {
        [btn addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    }
}

- (void)buttonClick {
    if (self.ocui.uiButtonAction) {
        self.ocui.uiButtonAction();
    }
}

- (CGSize)intrinsicContentSize {
    CGSize size = [_uiMaker.stack intrinsicContentSize];
    UIEdgeInsets contentEdgeInsets = [self ocui].uiContentEdgeInsets;
    return CGSizeMake(size.width + contentEdgeInsets.left + contentEdgeInsets.right, size.height + contentEdgeInsets.top + contentEdgeInsets.bottom);
}

@end
