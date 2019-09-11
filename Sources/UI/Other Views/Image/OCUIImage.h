//
//  OCUIImage.h
//  OCUIExample
//
//  Created by 张行 on 2019/8/26.
//  Copyright © 2019 张行. All rights reserved.
//

#import "OCUIView.h"
#import "OCUICreate+OCUIImage.h"

NS_ASSUME_NONNULL_BEGIN
@class OCUIImage;

@interface OCUIImage : OCUIView

@property (nonatomic, strong, readonly) UIImage *contentImage;

@end

//####################(Init)####################
@interface OCUIImage (Init)

- (instancetype)initWithImageName:(NSString *)imageName;

@end

NS_ASSUME_NONNULL_END
