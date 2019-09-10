//
//  OCUINavigationView.m
//  OCUIExample
//
//  Created by 张行 on 2019/9/9.
//  Copyright © 2019 张行. All rights reserved.
//

#import "OCUINavigationView.h"
#import "OCUICreate.h"

@implementation OCUINavigationView

- (instancetype)initWithBlock:(void (^)(void))block {
    if (self = [super init]) {
        
    }
    return self;
}

@end

FOUNDATION_EXPORT OCUINavigationView *NavigationView(void(^block)(void)) {
    if (!block) {
        return nil;
    }
    NSArray<OCUINode *> *node = CreateUINodes(block);
    OCUINavigationView *view = [[OCUINavigationView alloc] init];
    return view;
}
