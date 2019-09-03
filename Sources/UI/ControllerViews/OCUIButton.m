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
        
    }
    return self;
}

- (UIView *)makeOCUIView {
    return [UIButton buttonWithType:UIButtonTypeCustom];
}

- (void)configOCUIView:(UIView *)view {}

- (void)buttonClick {
    if (self.uiButtonAction) {
        self.uiButtonAction();
    }
}


@end

@implementation OCUIButton (Chained)

- (instancetype(^)(void(^)(void)))action {
    return ^OCUIButton *(void(^action)(void)) {
        self->_uiButtonAction = action;
        return self;
    };
}

@end
