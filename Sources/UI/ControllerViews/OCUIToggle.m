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

- (void)configOCUIView:(UIView *)view {}

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
