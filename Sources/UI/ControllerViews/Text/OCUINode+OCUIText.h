//
//  OCUINode+OCUIText.h
//  OCUIExample
//
//  Created by 张行 on 2019/9/11.
//  Copyright © 2019 张行. All rights reserved.
//

#import "OCUINode.h"
#import "OCUIColor.h"

NS_ASSUME_NONNULL_BEGIN

//####################(Bind)####################
@interface OCUINode (OCUITextBind)

/// 绑定值可变的
@property (nonatomic, strong, readonly) CombineBind<NSString *> *uiTextBind;
/// 添加字符串绑定
- (OCUINode *(^)(CombineBind<NSString *> *))textBind;

@end

//####################(TextStyle)####################
@interface OCUINode (OCUITextStyle)

/// 是否使用了粗体
@property (nonatomic, assign, readonly) BOOL isUIBold;
/// 是否使用斜体
@property (nonatomic, assign, readonly) BOOL isUIItalic;

/// 设置使用粗体
- (OCUINode *(^)(void))bold;
/// 设置斜体
- (OCUINode *(^)(void))italic;

@end

@interface OCUINode (OCUITextColor)

@property (nonatomic, strong, readonly) OCUIColor *uiForegroundColor;

- (OCUINode *(^)(OCUIColor *))foregroundColor;

@end

NS_ASSUME_NONNULL_END
