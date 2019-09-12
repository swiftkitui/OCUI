//
//  OCUICreate+OCUINavigationView.m
//  OCUIExample
//
//  Created by 张行 on 2019/9/12.
//  Copyright © 2019 张行. All rights reserved.
//

#import "OCUICreate+OCUINavigationView.h"
#import "OCUINavigationView.h"

@implementation OCUICreate (OCUINavigationView)

- (OCUINavigationView *(^)(OCUICreateElenmentBlock))NavigationView {
    return ^OCUINavigationView *(OCUICreateElenmentBlock) {
        return [self addElenment:NavigationView(block)];
    };
}

@end

FOUNDATION_EXPORT OCUINavigationView *NavigationView(OCUICreateElenmentBlock) {
    return [[OCUINavigationView alloc] initWithElenmentsBlock:block];
}
