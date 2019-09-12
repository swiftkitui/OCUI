//
//  OCUIZStack.m
//  OCUI
//
//  Created by 张行 on 2019/8/22.
//  Copyright © 2019 张行. All rights reserved.
//

#import "OCUIZStack.h"
#import "OCUICreate.h"

@implementation OCUIZStack

@end

@implementation OCUIZStack (Alignment)

- (OCUIAlignment *)uiAlignment {
    return self.propertyGet(@selector(uiAlignment));
}

- (instancetype  _Nonnull (^)(OCUIAlignment * _Nonnull))alignment {
    return ^OCUIZStack *(OCUIAlignment *alignment) {
        self.propertySet(alignment,@selector(uiAlignment));
        return self;
    };
}

@end
