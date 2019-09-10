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
                              block:(void (^)(void))block {
    if (self = [super init]) {
        
    }
    return self;
}

@end

FOUNDATION_EXPORT OCUINavigationLink *NavigationLink(Class destination, void(^block)(void)) {
    OCUINavigationLink *link = [[OCUINavigationLink alloc] init];
    return link;
}
