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
        }
    }
    return self;
}



@end
