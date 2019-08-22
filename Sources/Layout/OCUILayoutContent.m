//
//  OCUILayoutContent.m
//  OCUI
//
//  Created by 张行 on 2019/8/22.
//  Copyright © 2019 张行. All rights reserved.
//

#import "OCUILayoutContent.h"


@implementation OCUILayoutContent

- (instancetype)initWithView:(UIView *)view {
    if (self = [super init]) {
        _view = view;
    }
    return self;
}

- (void)addLayout:(BOOL (^)(MASConstraintMaker * make))block {
    if (self.isAutolayoutOK) {
        return;
    }
    [self.view mas_makeConstraints:^(MASConstraintMaker *make) {
        if (block) {
            self->_isAutolayoutOK = block(make);
        }
    }];
}

@end
