//
//  OCUILayoutCenter.h
//  OCUIExample
//
//  Created by 张行 on 2019/9/5.
//  Copyright © 2019 张行. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OCUILayoutItem.h"
#import "OCUISpacer.h"

NS_ASSUME_NONNULL_BEGIN

@interface OCUILayoutCenter : NSObject

- (instancetype)initWithContentViewLayoutItem:(OCUILayoutItem *)contentViewLayoutItem
                             floatLayoutItems:(NSArray<OCUILayoutItem *> *)floatLayoutItems
                             flxedLayoutItems:(NSArray<OCUILayoutItem *> *)flxedLayoutItems;

@end

@interface UIView (OCUILayoutCenter)

@property (nonatomic, strong) OCUILayoutCenter *layoutCenter;

@end

NS_ASSUME_NONNULL_END
