//
//  OCUIText.h
//  OCUI
//
//  Created by 张行 on 2019/8/21.
//  Copyright © 2019 张行. All rights reserved.
//

#import "OCUIView.h"
#import "OCUIColor.h"
#import "OCUICreate+OCUIText.h"
#import "OCUINode+BindText.h"

NS_ASSUME_NONNULL_BEGIN

@interface OCUIText : OCUIView

@property (nonatomic, copy, readonly) NSString *content;

@end

//####################(Init)####################
@interface OCUIText (Init)

- (instancetype)initWithText:(NSString *)content;

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

@interface OCUINode (TextColor)

@property (nonatomic, strong, readonly) OCUIColor *uiForegroundColor;

- (OCUINode *(^)(OCUIColor *))foregroundColor;

@end

@interface FontWeight : NSObject

@property (nonatomic, strong, class, readonly) FontWeight *black;

@end

NS_ASSUME_NONNULL_END
