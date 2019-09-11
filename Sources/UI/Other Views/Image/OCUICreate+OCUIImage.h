//
//  OCUICreate+OCUIImage.h
//  OCUIExample
//
//  Created by 张行 on 2019/9/11.
//  Copyright © 2019 张行. All rights reserved.
//

#import "OCUICreate.h"

NS_ASSUME_NONNULL_BEGIN
@class OCUIImage;

@interface OCUICreate (OCUIImage)

- (OCUIImage *(^)(NSString *imageName))Image;

@end

FOUNDATION_EXPORT OCUIImage *Image(NSString *imageName);

NS_ASSUME_NONNULL_END
