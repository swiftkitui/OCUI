//
//  OCUIImage.h
//  OCUIExample
//
//  Created by 张行 on 2019/8/26.
//  Copyright © 2019 张行. All rights reserved.
//

#import "OCUIView.h"

NS_ASSUME_NONNULL_BEGIN

@interface OCUIImage : OCUIView

@property (nonatomic, strong, readonly) UIImage *contentImage;

- (instancetype)initWithImageName:(NSString *)imageName;

@end

NS_ASSUME_NONNULL_END