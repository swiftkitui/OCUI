//
//  OCUIImage.m
//  OCUIExample
//
//  Created by 张行 on 2019/8/26.
//  Copyright © 2019 张行. All rights reserved.
//

#import "OCUIImage.h"
#import "OCUICreate.h"

@implementation OCUIImage

- (instancetype)initWithImageName:(NSString *)imageName {
    if (self = [super init]) {
        _contentImage = [UIImage imageNamed:imageName];
    }
    return self;
}

@end

FOUNDATION_EXPORT OCUIImage *Image(NSString *imageName) {
    OCUIImage *image = [[OCUIImage alloc] initWithImageName:imageName];
    AddNodeInUINodes(image);
    return image;
}
