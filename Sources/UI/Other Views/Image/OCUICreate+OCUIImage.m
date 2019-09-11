//
//  OCUICreate+OCUIImage.m
//  OCUIExample
//
//  Created by 张行 on 2019/9/11.
//  Copyright © 2019 张行. All rights reserved.
//

#import "OCUICreate+OCUIImage.h"
#import "OCUIImage.h"

@implementation OCUICreate (OCUIImage)

- (OCUIImage *(^)(NSString *imageName))Image {
    return ^OCUIImage *(NSString *imageName) {
        return [self addElenment:Image(imageName)];
    };
}

@end

FOUNDATION_EXPORT OCUIImage *Image(NSString *imageName) {
    OCUIImage *image = [[OCUIImage alloc] initWithImageName:imageName];
    return image;
}
