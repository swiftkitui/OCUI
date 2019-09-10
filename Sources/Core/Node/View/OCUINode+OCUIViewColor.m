//
//  OCUINode+OCUIViewColor.m
//  OCUIExample
//
//  Created by 张行 on 2019/9/10.
//  Copyright © 2019 张行. All rights reserved.
//

#import "OCUINode+OCUIViewColor.h"

@implementation OCUINode (OCUIViewColor)

- (OCUIColor *)uiBackgroundColor {
    return self.propertyGet(@selector(uiBackgroundColor));
}

- (OCUINode *(^)(OCUIColor *))backgroundColor {
    return ^OCUINode *(OCUIColor *backgroundColor) {
        self.propertySet(backgroundColor,@selector(uiBackgroundColor));
        return self;
    };
}

@end
