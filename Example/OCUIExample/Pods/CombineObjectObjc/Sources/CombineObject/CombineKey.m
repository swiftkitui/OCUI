//
//  CombineKey.m
//  CombineObject
//
//  Created by 张行 on 2019/8/5.
//  Copyright © 2019 张行. All rights reserved.
//

#import "CombineKey.h"

@implementation UIViewIdentifier

+ (NSString *)userInteractionEnabled {
    return @"UIView.userInteractionEnabled";
}

+ (NSString *)frame {
    return @"UIView.frame";
}

+ (NSString *)alpha {
    return @"UIVIew.alpha";
}

+ (NSString *)hidden {
    return @"UIVIew.hidden";
}

+ (NSString *)backgroundColor {
    return @"UIVIew.backgroundColor";
}

@end

@implementation UILabelIdentifier

+ (NSString *)text {
    return @"UILabel.text";
}

+ (NSString *)font {
    return @"UILabel.font";
}

+ (NSString *)textColor {
    return @"UILabel.textColor";
}

+ (NSString *)attributedText {
    return @"UILabel.attributedText";
}

@end

@implementation UISwitchIdentidier

+ (NSString *)on {
    return @"UISwitch.on";
}

@end

@implementation UITextFieldIdentifier

+ (NSString *)text {
    return @"UITextField.text";
}

+ (NSString *)placeholder {
    return @"UITextField.placeholder";
}

@end

@implementation UISliderIdentifier

+ (NSString *)value {
    return @"UISlider.value";
}

@end

@implementation UIProgressViewIdentifier

+ (NSString *)progress {
    return @"UIProgressView.progress";
}

@end

@implementation UITextViewIdentifier

+ (NSString *)text {
    return @"UITextView.text";
}

@end
