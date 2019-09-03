//
//  OCUIHStack.m
//  OCUI
//
//  Created by 张行 on 2019/8/22.
//  Copyright © 2019 张行. All rights reserved.
//

#import "OCUIHStack.h"

@implementation OCUIHStack {
    
}

- (instancetype)init {
    if (self = [super init]) {
        _uiAlignment = OCUIVerticalAlignmentCenter;
    }
    return self;
}

- (OCUIHStack * _Nonnull (^)(OCUIVerticalAlignment))alignment {
    return ^OCUIHStack *(OCUIVerticalAlignment alignment) {
        self->_uiAlignment = alignment;
        return self;
    };
}

@end
