//
//  OCUIText.m
//  OCUI
//
//  Created by 张行 on 2019/8/21.
//  Copyright © 2019 张行. All rights reserved.
//

#import "OCUIText.h"
#import "OCUICreate.h"

@implementation OCUIText

@end

@implementation OCUIText (Init)

- (instancetype)initWithText:(NSString *)content {
    if (self = [super init]) {
        _content = content;
    }
    return self;
}

@end

@implementation OCUINode (TextStyle)

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

@implementation OCUINode (TextColor)

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

@implementation FontWeight

+ (FontWeight *)black {
    return [FontWeight new];
}

@end
