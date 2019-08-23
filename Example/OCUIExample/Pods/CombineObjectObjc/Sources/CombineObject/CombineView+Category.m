//
//  CombineView+Category.m
//  CombineObject
//
//  Created by 张行 on 2019/8/2.
//  Copyright © 2019 张行. All rights reserved.
//

#import "CombineView+Category.h"
#import "CombineValue+Category.h"
#import "CombineKey.h"


@implementation UIView (CombineView)

- (void)setCombineValue:(id<CombineValue>)value identifier:(NSString *)identifier {
    NSString *_identifier = CombineKeyBox(identifier, UIViewIdentifier.backgroundColor);
    if ([value isKindOfClass:[UIColor class]] && [_identifier isEqualToString:UIViewIdentifier.backgroundColor]) {
        self.backgroundColor = (UIColor *)value;
    } else if ([value isKindOfClass:[NSNumber class]] && [_identifier isEqualToString:UIViewIdentifier.userInteractionEnabled]) {
        self.userInteractionEnabled = [(NSNumber *)value boolValue];
    } else if ([value isKindOfClass:[NSNumber class]] && [_identifier isEqualToString:UIViewIdentifier.frame]) {
        self.frame = [(NSNumber *)value CGRectValue];
    } else if ([value isKindOfClass:[NSNumber class]] && [_identifier isEqualToString:UIViewIdentifier.alpha]) {
        self.alpha = [(NSNumber *)value floatValue];
    } else if ([value isKindOfClass:[UIColor class]] && [_identifier isEqualToString:UIViewIdentifier.hidden]) {
        self.hidden = [(NSNumber *)value boolValue];
    } else {
        [self setOtherCombineValue:value identifier:identifier];
    }
}

- (void)setOtherCombineValue:(id<CombineValue>)value identifier:(NSString *)identifier {}

@end

@implementation UILabel (CombineView)

- (void)setCombineValue:(id<CombineValue>)value identifier:(nonnull NSString *)identifier {
    NSString *_identifier = CombineKeyBox(identifier, UILabelIdentifier.text);
    if ([value isKindOfClass:[NSString class]] && [_identifier isEqualToString:UILabelIdentifier.text]) {
        self.attributedText = nil;
        self.text = (NSString *)value;
    } else if ([value isKindOfClass:[UIFont class]] && [_identifier isEqualToString:UILabelIdentifier.font]) {
        self.font = (UIFont *)value;
    } else if ([value isKindOfClass:[UIColor class]] && [_identifier isEqualToString:UILabelIdentifier.textColor]) {
        self.textColor = (UIColor *)value;
    } else if ([value isKindOfClass:[NSAttributedString class]] && [_identifier isEqualToString:UILabelIdentifier.attributedText]) {
        self.text = nil;
        self.attributedText = (NSAttributedString *)value;
    }
    [super setCombineValue:value identifier:identifier];
}

@end

@implementation UIProgressView (CombineView)

- (void)setCombineValue:(id<CombineValue>)value identifier:(nonnull NSString *)identifier {
    NSString *_identifier = CombineKeyBox(identifier, UIProgressViewIdentifier.progress);
    if ([value isKindOfClass:[NSNumber class]] && [_identifier isEqualToString:UIProgressViewIdentifier.progress]) {
        self.progress = [(NSNumber *)value floatValue];
    }
    [super setCombineValue:value identifier:identifier];
}

@end

@implementation UITextField (CombineView)

- (void)setCombineValue:(id<CombineValue>)value identifier:(nonnull NSString *)identifier {
    NSString *_identifier = CombineKeyBox(identifier, UITextFieldIdentifier.text);
    if ([value isKindOfClass:[NSString class]] && [_identifier isEqualToString:UITextFieldIdentifier.text]) {
        self.text = (NSString *)value;
    } else if ([value isKindOfClass:[NSString class]] && [_identifier isEqualToString:UITextFieldIdentifier.placeholder]) {
        self.placeholder = (NSString *)value;
    }
    [super setCombineValue:value identifier:identifier];
}

@end

@implementation UISlider (CombineView)

- (void)setCombineValue:(id<CombineValue>)value identifier:(nonnull NSString *)identifier {
    NSString *_identifier = CombineKeyBox(identifier, UISliderIdentifier.value);
    if ([value isKindOfClass:[NSNumber class]] && [_identifier isEqualToString:UISliderIdentifier.value]) {
        self.value = [(NSNumber *)value floatValue];
    }
    [super setCombineValue:value identifier:identifier];
}

@end

@implementation UISwitch (CombineView)

- (void)setCombineValue:(id<CombineValue>)value identifier:(nonnull NSString *)identifier {
    NSString *_identifier = CombineKeyBox(identifier, UISwitchIdentidier.on);
    if ([value isKindOfClass:[NSNumber class]] && [_identifier isEqualToString:UISwitchIdentidier.on]) {
        self.on = [(NSNumber *)value boolValue];
    }
    [super setCombineValue:value identifier:identifier];
}

@end

@implementation UITextView (CombineView)

- (void)setCombineValue:(id<CombineValue>)value identifier:(nonnull NSString *)identifier {
    NSString *_identifier = CombineKeyBox(identifier, UITextFieldIdentifier.text);
    if ([value isKindOfClass:[NSString class]] && [_identifier isEqualToString:UITextFieldIdentifier.text]) {
        self.text = (NSString *)value;
    }
    [super setCombineValue:value identifier:identifier];
}

@end
