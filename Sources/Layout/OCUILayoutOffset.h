//
//  OCUILayoutOffset.h
//  OCUI
//
//  Created by 张行 on 2019/8/22.
//  Copyright © 2019 张行. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface OCUILayoutOffset : NSObject

@property (nonatomic, assign, readonly) CGFloat height;

- (instancetype)initWithHeight:(CGFloat)height;

@end

NS_ASSUME_NONNULL_END
