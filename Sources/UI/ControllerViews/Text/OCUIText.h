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
#import "OCUINode+OCUIText.h"

NS_ASSUME_NONNULL_BEGIN

@interface OCUIText : OCUIView

@property (nonatomic, copy, readonly) NSString *content;

@end

//####################(Init)####################
@interface OCUIText (Init)

- (instancetype)initWithText:(NSString *)content;

@end

NS_ASSUME_NONNULL_END
