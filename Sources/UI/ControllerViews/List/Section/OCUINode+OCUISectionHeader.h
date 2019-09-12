//
//  OCUINode+OCUISectionHeader.h
//  OCUIExample
//
//  Created by 张行 on 2019/9/12.
//  Copyright © 2019 张行. All rights reserved.
//

#import "OCUINode.h"
#import "OCUICreate.h"

NS_ASSUME_NONNULL_BEGIN

@interface OCUINode (OCUISectionHeader)

@property (nonatomic, strong, readonly) NSArray<OCUINode *> *headerNodes;

- (OCUINode *(^)(OCUICreateElenmentBlock))header;

@end

NS_ASSUME_NONNULL_END
