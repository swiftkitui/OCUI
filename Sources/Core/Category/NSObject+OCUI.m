//
//  NSObject+OCUI.m
//  OCUIExample
//
//  Created by 张行 on 2019/8/29.
//  Copyright © 2019 张行. All rights reserved.
//

#import "NSObject+OCUI.h"
#import <objc/runtime.h>

@implementation NSObject (OCUI)

- (OCUINode *)ocui {
    OCUINode *node = objc_getAssociatedObject(self, @selector(ocui));
    if (!node) {
        node = [[OCUINode alloc] init];
        objc_setAssociatedObject(self, @selector(ocui), node, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return node;
}

- (instancetype  _Nonnull (^)(void (^ _Nonnull)(OCUINode * _Nonnull)))UI {
    return ^NSObject *((void (^block)(OCUINode * _Nonnull))) {
        if (block) {
            block(self.ocui);
        }
        return self;
    };
}

- (void)configOCUIViewWithClass:(Class)className {
    
}

#pragma mark - OCUIRenderView
- (UIView *)makeOCUIView {
    return nil;
}

- (void)configOCUIView:(UIView *)view {
}


@end
