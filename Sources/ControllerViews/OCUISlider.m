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
}

- (instancetype)initWithValue:(CGFloat)value {
    if (self = [super init]) {
        _value = value;
        self.ocui.height(30);
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
        if (self.ocui.uiBind) {
            self.viewBind(self.ocui.uiBind,@"SliderValue");
            self->_valueChangedBlock = ^(NSNumber *value) {
                configView.value = [value floatValue];
            };
            [configView addTarget:self action:@selector(valueChanged:) forControlEvents:UIControlEventValueChanged];
        }
    }];
}

- (void)valueChanged:(UISlider *)slider {
    self.ocui.uiBind.wrappedContent = @(slider.value);
}

- (void)setCombineValue:(id<CombineValue>)value identifier:(NSString *)identifier {
    if ([value isKindOfClass:[NSNumber class]] && [identifier isEqualToString:@"SliderValue"] && _valueChangedBlock) {
        _valueChangedBlock((NSNumber *)value);
    }
}

@end
