//
//  OCUINode.h
//  OCUI
//
//  Created by 张行 on 2019/8/22.
//  Copyright © 2019 张行. All rights reserved.
//

#import "OCUIHeader.h"

NS_ASSUME_NONNULL_BEGIN
@class OCUINode;

FOUNDATION_EXPORT id OCUINodeGetProperty(OCUINode *node, SEL sel);
FOUNDATION_EXPORT void OCUINodeSetProperty(OCUINode *node, SEL sel, id property);

@interface OCUINode : NSObject

- (id(^)(SEL))propertyGet;
- (void(^)(id,SEL))propertySet;

@end
NS_ASSUME_NONNULL_END
