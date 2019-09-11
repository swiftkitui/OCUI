//
//  OCUINavigationLink.m
//  OCUIExample
//
//  Created by 张行 on 2019/9/9.
//  Copyright © 2019 张行. All rights reserved.
//

#import "OCUINavigationLink.h"

@implementation OCUINavigationLink

- (instancetype)initWithDestination:(Class)destination
                              block:(void(^)(OCUICreate *c))block {
    if (self = [super initWithElenmentsBlock:block]) {
        _destination = destination;
    }
    return self;
}

@end

FOUNDATION_EXPORT OCUINavigationLink *NavigationLink(Class destination, OCUICreateElenmentBlock) {
    OCUINavigationLink *link = [[OCUINavigationLink alloc] initWithDestination:destination block:block];
    return link;
}

@implementation OCUICreate (OCUINavigationLink)

- (OCUINavigationLink *(^)(Class destination, OCUICreateElenmentBlock))NavigationLink {
    return ^OCUINavigationLink *(Class destination, OCUICreateElenmentBlock) {
        return NavigationLink(destination, block);
    };
}

@end
