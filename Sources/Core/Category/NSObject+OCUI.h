//
//  NSObject+OCUI.h
//  OCUIExample
//
//  Created by 张行 on 2019/8/29.
//  Copyright © 2019 张行. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OCUINode.h"
#import "OCUIRenderView.h"

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (OCUI)<OCUIRenderView>

/// 用于链式设置 OCUI 的属性值
@property (nonatomic, strong, readonly) OCUINode *ocui;

@end

NS_ASSUME_NONNULL_END
