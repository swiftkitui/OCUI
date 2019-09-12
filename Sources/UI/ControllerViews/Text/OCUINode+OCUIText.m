//
//  OCUINode+OCUIText.m
//  OCUIExample
//
//  Created by 张行 on 2019/9/11.
//  Copyright © 2019 张行. All rights reserved.
//

#import "OCUINode+OCUIText.h"

@implementation OCUINode (OCUITextBind)

- (CombineBind<NSString *> *)uiTextBind {
    return (CombineBind<NSString *> *)self.propertyGet(@selector(uiTextBind));
}

- (OCUINode *(^)(CombineBind<NSString *> * _Nonnull))textBind {
    return ^OCUINode *(CombineBind<NSString *> *textBind) {
        self.propertySet(textBind,@selector(uiTextBind));
        return self;
    };
}

@end

@implementation OCUINode (OCUITextStyle)

- (BOOL)isUIBold {
    return [self.propertyGet(@selector(isUIBold)) boolValue];
}

- (BOOL)isUIItalic {
    return [self.propertyGet(@selector(isUIItalic)) boolValue];
}

- (OCUINode *(^)(void))bold {
    return ^OCUINode *{
        self.propertySet(@(YES),@selector(isUIBold));
        return self;
    };
}
/// 设置斜体
- (OCUINode *(^)(void))italic {
    return ^OCUINode *{
        self.propertySet(@(YES),@selector(isUIItalic));
        return self;
    };
}

@end

@implementation OCUINode (OCUITextColor)

- (OCUIColor *)uiForegroundColor {
    return self.propertyGet(@selector(uiForegroundColor));
}

- (OCUINode *(^)(OCUIColor *))foregroundColor {
    return ^OCUINode *(OCUIColor *foregroundColor) {
        self.propertySet(foregroundColor,@selector(uiForegroundColor));
        return self;
    };
}

@end
