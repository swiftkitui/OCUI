//
//  OCUIButton.m
//  OCUIExample
//
//  Created by 张行 on 2019/8/30.
//  Copyright © 2019 张行. All rights reserved.
//

#import "OCUIButton.h"

@implementation OCUIButton {
    
}

- (instancetype)initWithAction:(void(^)(void))actionBlock
                         label:(void(^)(OCUICreate *c))labelBlock {
    if (self = [super initWithElenmentsBlock:labelBlock]) {
        _uiButtonAction = actionBlock;
    }
    return self;
}

@end

