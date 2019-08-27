//
//  OCUIText.h
//  OCUI
//
//  Created by 张行 on 2019/8/21.
//  Copyright © 2019 张行. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OCUIRenderView.h"
#import "OCUIView.h"

NS_ASSUME_NONNULL_BEGIN

@interface OCUIText : OCUIView

@property (nonatomic, copy, readonly) NSString *content;
@property (nonatomic, strong, readonly) CombineBind *textBind;

- (instancetype)initWithText:(NSString *)content;

@end

NS_ASSUME_NONNULL_END
