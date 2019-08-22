//
//  OCUIText.h
//  OCUI
//
//  Created by 张行 on 2019/8/21.
//  Copyright © 2019 张行. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OCUIRenderView.h"
#import "OCUINode.h"

NS_ASSUME_NONNULL_BEGIN

@interface OCUIText : OCUINode

@property (nonatomic, copy) NSString *content;

- (instancetype)initWithText:(NSString *)content;

@end

NS_ASSUME_NONNULL_END
