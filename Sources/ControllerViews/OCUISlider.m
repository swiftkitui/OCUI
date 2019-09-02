//
//  OCUISlider.m
//  OCUIExample
//
//  Created by 张行 on 2019/8/31.
//  Copyright © 2019 张行. All rights reserved.
//

#import "OCUISlider.h"

@implementation OCUISlider {
    CGFloat _value;
    void(^_valueChangedBlock)(NSNumber *value);
    CombineBind<NSNumber *> *_uiValueBind;
}

- (instancetype)initWithValue:(CGFloat)value {
    if (self = [super init]) {
        _value = value;
        self.height(30);
        NSLog(@"%@",self);
    }
    return self;
}

- (void)print {
    NSLog(@"%@",self);
}

- (UIView *)makeOCUIView {
    return UISlider.new;
}

- (void)configOCUIView:(UIView *)view {
    [super configOCUIView:view];
    [OCUIConfigView<UISlider *> configView:view className:UISlider.class block:^(UISlider * _Nonnull configView) {
        configView.value = self->_value;
        if (self.uiValueBind) {
            self.viewBind(self.uiValueBind,@"SliderValue");
            self->_valueChangedBlock = ^(NSNumber *value) {
                configView.value = [value floatValue];
            };
            [configView addTarget:self action:@selector(valueChanged:) forControlEvents:UIControlEventValueChanged];
        }
    }];
}

- (void)valueChanged:(UISlider *)slider {
    self.uiValueBind.wrappedContent = @(slider.value);
}

- (void)setCombineValue:(id<CombineValue>)value identifier:(NSString *)identifier {
    if ([value isKindOfClass:[NSNumber class]] && [identifier isEqualToString:@"SliderValue"] && _valueChangedBlock) {
        _valueChangedBlock((NSNumber *)value);
    }
}

@end

@implementation OCUISlider (Bind)

- (CombineBind<NSNumber *> *)uiValueBind {
    return _uiValueBind;
}

- (instancetype  _Nonnull (^)(CombineBind<NSNumber *> * _Nonnull))valueBind {
    return ^OCUISlider *(CombineBind<NSNumber *> *valueBind) {
        self->_uiValueBind = valueBind;
        return self;
    };
}

@end
