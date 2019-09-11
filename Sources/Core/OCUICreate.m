//
//  OCUICreate.m
//  OCUIExample
//
//  Created by 张行 on 2019/9/9.
//  Copyright © 2019 张行. All rights reserved.
//


#import "OCUICreate.h"

@implementation OCUICreate {
    NSMutableArray<OCUINode *> *_elenmentNodes;
}

- (instancetype)init {
    if (self = [super init]) {
        _elenmentNodes = [NSMutableArray array];
    }
    return self;
}

- (__kindof OCUINode *)addElenment:(OCUINode *)elenment {
    if (elenment) {
        [_elenmentNodes addObject:elenment];
    }
    return elenment;
}

- (NSArray<OCUINode *> *)elenments {
    return _elenmentNodes;
}

@end


