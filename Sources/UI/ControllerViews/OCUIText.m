//
//  OCUIText.m
//  OCUI
//
//  Created by 张行 on 2019/8/21.
//  Copyright © 2019 张行. All rights reserved.
//

#import "OCUIText.h"

@implementation OCUIText {
    CombineBind<NSString *> *_uiTextBind;
}

- (instancetype)initWithText:(NSString *)content {
    if (self = [super init]) {
        _content = content;
    }
    return self;
}

- (UIView *)makeOCUIView {
    return [UILabel new];
}

- (void)configOCUIView:(UIView *)view {
    
}

@end

@implementation OCUIText (Bind)

- (CombineBind<NSString *> *)uiTextBind {
    return _uiTextBind;
}

- (instancetype  _Nonnull (^)(CombineBind<NSString *> * _Nonnull))textBind {
    return ^OCUIText *(CombineBind<NSString *> *textBind) {
        self->_uiTextBind = textBind;
        return self;
    };
}

@end