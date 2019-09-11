//
//  OCUICreate+OCUIText.m
//  OCUIExample
//
//  Created by 张行 on 2019/9/11.
//  Copyright © 2019 张行. All rights reserved.
//

#import "OCUICreate+OCUIText.h"
#import "OCUIText.h"

@implementation OCUICreate (OCUIText)

- (OCUIText *(^)(NSString *content))Text {
    return ^OCUIText *(NSString *content) {
        return [self addElenment:Text(content)];
    };
}

@end

FOUNDATION_EXPORT OCUIText *Text(NSString *content) {
    return [[OCUIText alloc] initWithText:content];
}
