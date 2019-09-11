//
//  OCUICreate+OCUIView.m
//  OCUIExample
//
//  Created by 张行 on 2019/9/11.
//  Copyright © 2019 张行. All rights reserved.
//

#import "OCUICreate+OCUIView.h"
#import "OCUIView.h"

@implementation OCUICreate (OCUIView)

- (OCUIView *(^)(void))View {
    return ^OCUIView *{
        return [self addElenment:View()];
    };
}

@end

FOUNDATION_EXPORT OCUIView *View(void) {
    OCUIView *view = [[OCUIView alloc] init];
    return view;
}
