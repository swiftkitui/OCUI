//
//  OCUINode+OCUISectionHeader.m
//  OCUIExample
//
//  Created by 张行 on 2019/9/12.
//  Copyright © 2019 张行. All rights reserved.
//

#import "OCUINode+OCUISectionHeader.h"

@implementation OCUINode (OCUISectionHeader)

- (NSArray<OCUINode *> *)headerNodes {
    return self.propertyGet(@selector(headerNodes));
}

- (OCUINode *(^)(OCUICreateElenmentBlock))header {
    return ^OCUINode *(OCUICreateElenmentBlock) {
        if (block) {
            OCUICreate *create = [[OCUICreate alloc] init];
            block(create);
            self.propertySet(create.elenments,@selector(headerNodes));
        }
        return self;
    };
}


@end
