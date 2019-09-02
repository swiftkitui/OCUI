//
//  OCUIToggle.m
//  OCUIExample
//
//  Created by 张行 on 2019/8/31.
//  Copyright © 2019 张行. All rights reserved.
//

#import "OCUIToggle.h"
#import "OCUIMaker.h"

@implementation OCUIToggle {
    BOOL _isOn;
    void(^_isOnChangedBlock)(NSNumber *isOn);
    CombineBind<NSNumber *> *_uiOnBind;
}

- (instancetype)initWithIsOn:(BOOL)isOn {
    if (self = [super init]) {
        _isOn = isOn;
    }
    return self;
}

- (UIView *)makeOCUIView {
    return UISwitch.new;
}

- (void)configOCUIView:(UIView *)view {
    [super configOCUIView:view];
    if (![view isKindOfClass:[UISwitch class]]) {
        return;
    }
    [OCUIConfigView<UISwitch *> configView:view className:[UISwitch class] block:^(UISwitch * _Nonnull configView) {
        configView.on = self->_isOn;
        if (self.uiOnBind) {
            self.viewBind(self.uiOnBind,@"isOn");
            self->_isOnChangedBlock = ^(NSNumber *isOn) {
                [configView setOn:[isOn boolValue] animated:YES];
            };
            [configView addTarget:self action:@selector(toggleClick:) forControlEvents:UIControlEventValueChanged];
        }
    }];
}

- (void)toggleClick:(UISwitch *)switchView {
    self.uiOnBind.wrappedContent = @(switchView.isOn);
}

- (void)setCombineValue:(id<CombineValue>)value identifier:(NSString *)identifier {
    if ([value isKindOfClass:[NSNumber class]] && [identifier isEqualToString:@"isOn"]) {
        if (_isOnChangedBlock) {
            _isOnChangedBlock((NSNumber *)value);
        }
    }
}

@end

@implementation OCUIToggle (Bind)

- (CombineBind<NSNumber *> *)uiOnBind {
    return _uiOnBind;
}

- (instancetype  _Nonnull (^)(CombineBind<NSNumber *> * _Nonnull))onBind {
    return ^OCUIToggle *(CombineBind<NSNumber *> *onBind) {
        self->_uiOnBind = onBind;
        return self;
    };
}

@end
