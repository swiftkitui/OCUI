//
//  OCUIText.h
//  OCUI
//
//  Created by 张行 on 2019/8/21.
//  Copyright © 2019 张行. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OCUIView.h"

NS_ASSUME_NONNULL_BEGIN

@interface OCUIText : OCUIView

@property (nonatomic, copy, readonly) NSString *content;

- (instancetype)initWithText:(NSString *)content;

@end

@interface OCUIText (Bind)

/// 绑定值可变的
@property (nonatomic, strong, readonly) CombineBind<NSString *> *uiTextBind;

/// 添加字符串绑定
- (instancetype(^)(CombineBind<NSString *> *))textBind;

@end

NS_ASSUME_NONNULL_END
