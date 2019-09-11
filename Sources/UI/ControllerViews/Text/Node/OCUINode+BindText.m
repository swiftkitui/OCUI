//
//  OCUINode+BindText.m
//  OCUIExample
//
//  Created by 张行 on 2019/9/11.
//  Copyright © 2019 张行. All rights reserved.
//

#import "OCUINode+BindText.h"

@implementation OCUINode (BindText)

- (CombineBind<NSString *> *)uiTextBind {
    return (CombineBind<NSString *> *)self.propertyGet(@selector(uiTextBind));
}

- (OCUINode *(^)(CombineBind<NSString *> * _Nonnull))textBind {
    return ^OCUINode *(CombineBind<NSString *> *textBind) {
        self.propertySet(textBind,@selector(uiTextBind));
        return self;
    };
}

@end
