//
//  OCUILayoutOffset.h
//  OCUI
//
//  Created by 张行 on 2019/8/22.
//  Copyright © 2019 张行. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/// 布局的偏移值
@interface OCUILayoutOffset : NSObject

@property (nonatomic, assign, readonly) CGFloat value;

- (instancetype)initWithValue:(CGFloat)value;

@end

NS_ASSUME_NONNULL_END
