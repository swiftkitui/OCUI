//
//  OCUICreate+OCUINavigationLink.m
//  OCUIExample
//
//  Created by 张行 on 2019/9/12.
//  Copyright © 2019 张行. All rights reserved.
//

#import "OCUICreate+OCUINavigationLink.h"
#import "OCUINavigationLink.h"

@implementation OCUICreate (OCUINavigationLink)

- (OCUINavigationLink *(^)(Class destination, OCUICreateElenmentBlock))NavigationLink {
    return ^OCUINavigationLink *(Class destination, OCUICreateElenmentBlock) {
        return [self addElenment:NavigationLink(destination, block)];
    };
}

@end

FOUNDATION_EXPORT OCUINavigationLink *NavigationLink(Class destination, OCUICreateElenmentBlock) {
    return [[OCUINavigationLink alloc] initWithDestination:destination block:block];
}
