//
//  OCUINode.m
//  OCUI
//
//  Created by 张行 on 2019/8/22.
//  Copyright © 2019 张行. All rights reserved.
//

#import "OCUINode.h"
#import <objc/runtime.h>

FOUNDATION_EXPORT id OCUINodeGetProperty(OCUINode *node, SEL sel) {
    return objc_getAssociatedObject(node, sel);
}
FOUNDATION_EXPORT void OCUINodeSetProperty(OCUINode *node, SEL sel, id property) {
    objc_setAssociatedObject(node, sel, property, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@implementation OCUINode

- (id  _Nonnull (^)(SEL _Nonnull))propertyGet {
    return ^id(SEL sel) {
        return OCUINodeGetProperty(self, sel);
    };
}

- (void (^)(id _Nonnull, SEL _Nonnull))propertySet {
    return ^(id property, SEL sel) {
        OCUINodeSetProperty(self, sel, property);
    };
}
@end
