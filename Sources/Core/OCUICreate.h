//
//  OCUICreate.h
//  OCUIExample
//
//  Created by 张行 on 2019/9/9.
//  Copyright © 2019 张行. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OCUINode.h"

NS_ASSUME_NONNULL_BEGIN
static NSMutableArray<OCUINode *> *CurrentUINodes;

FOUNDATION_EXPORT NSArray<OCUINode *> *CreateUINodes(void(^block)(void));
FOUNDATION_EXPORT void AddNodeInUINodes(OCUINode *node);

NS_ASSUME_NONNULL_END
