//
//  OCUINode+OCUIListStyle.m
//  OCUIExample
//
//  Created by 张行 on 2019/9/12.
//  Copyright © 2019 张行. All rights reserved.
//

#import "OCUINode+OCUIListStyle.h"

@implementation OCUINode (OCUIListStyle)

- (OCUIListStyle *)uiListStyle {
    return self.propertyGet(@selector(uiListStyle));
}

- (OCUINode *(^)(OCUIListStyle *))listStyle {
    return ^OCUINode *(OCUIListStyle *listStyle) {
        self.propertySet(listStyle,@selector(uiListStyle));
        return self;
    };
}

@end
