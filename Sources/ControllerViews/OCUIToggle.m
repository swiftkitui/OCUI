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
    UISwitch *switchView = (UISwitch *)view;
    switchView.on = _isOn;
    OCUINode *node = [self ocui];
    if (node.uiBind) {
        self.viewBind(node.uiBind,@"isOn");
        _isOnChangedBlock = ^(NSNumber *isOn) {
            [switchView setOn:[isOn boolValue] animated:YES];
        };
        [switchView addTarget:self action:@selector(toggleClick:) forControlEvents:UIControlEventValueChanged];
    }
}

- (void)toggleClick:(UISwitch *)switchView {
    [self ocui].uiBind.wrappedContent = @(switchView.isOn);
}

- (void)setCombineValue:(id<CombineValue>)value identifier:(NSString *)identifier {
    if ([value isKindOfClass:[NSNumber class]] && [identifier isEqualToString:@"isOn"]) {
        if (_isOnChangedBlock) {
            _isOnChangedBlock((NSNumber *)value);
        }
    }
}

@end
