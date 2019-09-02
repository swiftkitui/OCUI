//
//  OCUIView.h
//  OCUI
//
//  Created by 张行 on 2019/8/23.
//  Copyright © 2019 张行. All rights reserved.
//

#import "OCUINode.h"

NS_ASSUME_NONNULL_BEGIN

@interface OCUIView : OCUINode

@property (nonatomic, strong, readonly) UIColor *uiBackgroundColor;

- (instancetype(^)(UIColor *))backgroundColor;

@end



NS_ASSUME_NONNULL_END
