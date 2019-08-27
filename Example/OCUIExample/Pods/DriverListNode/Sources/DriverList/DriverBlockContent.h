//
//  DriverBlockContent.h
//  ZHTableViewGroup iOS
//
//  Created by 张行 on 2019/8/19.
//  Copyright © 2019 15038777234. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DriverBlockContent<__covariant T:UIView *> : NSObject

@property (nonatomic, copy) void(^configBlock)(T view, NSUInteger index);
@property (nonatomic, copy) void(^didSelectRowBlock)(T view, NSUInteger index);
@property (nonatomic, copy) CGFloat(^customHeightBlock)(T view, NSUInteger index);
@property (nonatomic, copy) CGSize(^customSizeBlock)(T view, NSUInteger index);

@end

NS_ASSUME_NONNULL_END
