//
//  OCUICreate+OCUISection.m
//  OCUIExample
//
//  Created by 张行 on 2019/9/12.
//  Copyright © 2019 张行. All rights reserved.
//

#import "OCUICreate+OCUISection.h"
#import "OCUISection.h"

@implementation OCUICreate (OCUISection)

- (OCUISection *(^)(OCUICreateElenmentBlock))Section {
    return ^OCUISection *(OCUICreateElenmentBlock) {
        return [self addElenment:Section(block)];
    };
}

@end

FOUNDATION_EXPORT OCUISection *Section(OCUICreateElenmentBlock) {
    return [[OCUISection alloc] initWithElenmentsBlock:block];
}
