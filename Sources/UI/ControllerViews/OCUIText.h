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

FOUNDATION_EXPORT OCUIText *Text(NSString *content);

@interface OCUINode (Bind)

/// 绑定值可变的
@property (nonatomic, strong, readonly) CombineBind<NSString *> *uiTextBind;

/// 添加字符串绑定
- (OCUINode *(^)(CombineBind<NSString *> *))textBind;

@end

@interface OCUINode (TextStyle)

/// 是否使用了粗体
@property (nonatomic, assign, readonly) BOOL isUIBold;
/// 是否使用斜体
@property (nonatomic, assign, readonly) BOOL isUIItalic;

/// 设置使用粗体
- (OCUINode *(^)(void))bold;
/// 设置斜体
- (OCUINode *(^)(void))italic;

@end

@interface FontWeight : NSObject

@property (nonatomic, strong, class, readonly) FontWeight *black;

@end

NS_ASSUME_NONNULL_END
