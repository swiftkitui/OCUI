//
//  OCUISpacer.h
//  OCUI
//
//  Created by 张行 on 2019/8/22.
//  Copyright © 2019 张行. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OCUINode.h"
#import "OCUILayoutOffset.h"

NS_ASSUME_NONNULL_BEGIN

@interface OCUISpacer : OCUINode

@property (nonatomic, strong, readonly) OCUILayoutOffset *lenghtOffset;
@property (nonatomic, strong, readonly) OCUILayoutOffset *minOffset;
@property (nonatomic, assign, readonly) CGFloat minSpancer;

- (instancetype)initWithOffset:(NSNumber *)offset;

- (OCUISpacer *(^)(CGFloat))min;

@end

NS_ASSUME_NONNULL_END
