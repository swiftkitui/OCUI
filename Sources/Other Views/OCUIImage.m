//
//  OCUIImage.m
//  OCUIExample
//
//  Created by 张行 on 2019/8/26.
//  Copyright © 2019 张行. All rights reserved.
//

#import "OCUIImage.h"

@implementation OCUIImage

- (instancetype)initWithImageName:(NSString *)imageName {
    if (self = [super init]) {
        _contentImage = [UIImage imageNamed:imageName];
    }
    return self;
}


- (UIView *)makeOCUIView {
    return [[UIImageView alloc] initWithFrame:CGRectZero];
}

- (void)configOCUIView:(UIView *)view {
    [super configOCUIView:view];
    if (![view isKindOfClass:[UIImageView class]]) {
        return;
    }
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.image = _contentImage;
}

@end
