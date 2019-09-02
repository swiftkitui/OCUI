//
//  OCUISpacer.m
//  OCUI
//
//  Created by 张行 on 2019/8/22.
//  Copyright © 2019 张行. All rights reserved.
//

#import "OCUISpacer.h"

@implementation OCUISpacer {
    
}


- (instancetype)initWithOffset:(NSNumber * _Nullable )offset {
    if (self = [super init]) {
        if (offset) {
            _flxedOffset = [[OCUILayoutOffset alloc] initWithValue:[offset floatValue]];
            _uiMinOffset = 0;
        }
    }
    return self;
}

@end

@implementation OCUISpacer (Chained)

- (instancetype  _Nonnull (^)(CGFloat))minOffset {
    return ^OCUISpacer *(CGFloat minOffset) {
        self->_uiMinOffset = minOffset;
        return self;
    };
}

@end
