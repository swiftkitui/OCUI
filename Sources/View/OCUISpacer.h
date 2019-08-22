//
//  OCUISpacer.h
//  OCUI
//
//  Created by 张行 on 2019/8/22.
//  Copyright © 2019 张行. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OCUIRenderView.h"
#import "OCUILayoutOffset.h"

NS_ASSUME_NONNULL_BEGIN

@interface OCUISpacer : NSObject<OCUIRenderView>

@property (nonatomic, strong) OCUILayoutOffset *lenghtOffset;

- (OCUISpacer*(^)(CGFloat))lenght;

@end

NS_ASSUME_NONNULL_END
