//
//  OCUISpacer.h
//  OCUI
//
//  Created by 张行 on 2019/8/22.
//  Copyright © 2019 张行. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OCUINode.h"

NS_ASSUME_NONNULL_BEGIN

@interface OCUISpacer : OCUINode

@property (nonatomic, assign, readonly) CGFloat uiMinOffset;

- (instancetype(^)(CGFloat))minOffset;

@end


NS_ASSUME_NONNULL_END
