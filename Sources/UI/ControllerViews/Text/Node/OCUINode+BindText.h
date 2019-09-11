//
//  OCUINode+BindText.h
//  OCUIExample
//
//  Created by 张行 on 2019/9/11.
//  Copyright © 2019 张行. All rights reserved.
//

#import "OCUINode.h"

NS_ASSUME_NONNULL_BEGIN

@interface OCUINode (BindText)

/// 绑定值可变的
@property (nonatomic, strong, readonly) CombineBind<NSString *> *uiTextBind;
/// 添加字符串绑定
- (OCUINode *(^)(CombineBind<NSString *> *))textBind;

@end

NS_ASSUME_NONNULL_END
