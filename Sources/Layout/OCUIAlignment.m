//
//  OCUIAlignment.m
//  OCUIExample
//
//  Created by 张行 on 2019/9/3.
//  Copyright © 2019 张行. All rights reserved.
//

#import "OCUIAlignment.h"

@implementation OCUIAlignment

- (instancetype)initWithVerticalAlignment:(OCUIVerticalAlignment)verticalAlignment
                      horizontalAlignment:(OCUIHorizontalAlignment)horizontalAlignment {
    if (self = [super init]) {
        _uiVerticalAlignment = verticalAlignment;
        _uiHorizontalAlignment = horizontalAlignment;
    }
    return self;
}

@end

@implementation OCUIAlignment (ClassAlignment)

+ (OCUIAlignment *)bottom {
    return [[OCUIAlignment alloc] initWithVerticalAlignment:OCUIVerticalAlignmentBottom
                                        horizontalAlignment:OCUIHorizontalAlignmentCenter];
}

+ (OCUIAlignment *)bottomLeading {
    return [[OCUIAlignment alloc] initWithVerticalAlignment:OCUIVerticalAlignmentBottom
                                        horizontalAlignment:OCUIHorizontalAlignmentLeading];
}

+ (OCUIAlignment *)bottomTrailing {
    return [[OCUIAlignment alloc] initWithVerticalAlignment:OCUIVerticalAlignmentBottom
                                        horizontalAlignment:OCUIHorizontalAlignmentTrailing];
}

+ (OCUIAlignment *)center {
    return [[OCUIAlignment alloc] initWithVerticalAlignment:OCUIVerticalAlignmentCenter
                                        horizontalAlignment:OCUIHorizontalAlignmentCenter];
}

+ (OCUIAlignment *)leading {
    return [[OCUIAlignment alloc] initWithVerticalAlignment:OCUIVerticalAlignmentCenter
                                        horizontalAlignment:OCUIHorizontalAlignmentLeading];
}

+ (OCUIAlignment *)top {
    return [[OCUIAlignment alloc] initWithVerticalAlignment:OCUIVerticalAlignmentTop
                                        horizontalAlignment:OCUIHorizontalAlignmentCenter];
}

+ (OCUIAlignment *)topLeading {
    return [[OCUIAlignment alloc] initWithVerticalAlignment:OCUIVerticalAlignmentTop
                                        horizontalAlignment:OCUIHorizontalAlignmentLeading];
}

+ (OCUIAlignment *)topTrailing {
    return [[OCUIAlignment alloc] initWithVerticalAlignment:OCUIVerticalAlignmentTop
                                        horizontalAlignment:OCUIHorizontalAlignmentTrailing];
}

+ (OCUIAlignment *)trailing {
    return [[OCUIAlignment alloc] initWithVerticalAlignment:OCUIVerticalAlignmentCenter
                                        horizontalAlignment:OCUIHorizontalAlignmentTrailing];
}

@end
