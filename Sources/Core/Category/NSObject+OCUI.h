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
#import "OCUIConfigView.h"

NS_ASSUME_NONNULL_BEGIN

#define UINode ^(OCUINode *UI)

@interface NSObject (OCUI)<OCUIRenderView>

/// 用于链式设置 OCUI 的属性值
@property (nonatomic, strong, readonly) OCUINode *ocui;
- (instancetype(^)(void(^)(OCUINode *ui)))UI;

@end

NS_ASSUME_NONNULL_END
