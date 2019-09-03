//
//  OCUIZStack.m
//  OCUI
//
//  Created by 张行 on 2019/8/22.
//  Copyright © 2019 张行. All rights reserved.
//

#import "OCUIZStack.h"

@implementation OCUIZStack

- (instancetype  _Nonnull (^)(OCUIAlignment * _Nonnull))alignment {
    return ^OCUIZStack *(OCUIAlignment *alignment) {
        self->_uiAlignment = alignment;
        return self;
    };
}

@end
