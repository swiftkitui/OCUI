//
//  OCUIZStack.h
//  OCUI
//
//  Created by 张行 on 2019/8/22.
//  Copyright © 2019 张行. All rights reserved.
//

#import "OCUIStack.h"
#import "OCUIAlignment.h"

NS_ASSUME_NONNULL_BEGIN

@interface OCUIZStack : OCUIStack

@property (nonatomic, strong, readonly) OCUIAlignment *uiAlignment;

- (instancetype(^)(OCUIAlignment *))alignment;

@end

FOUNDATION_EXPORT OCUIZStack *ZStack(void(^block)(void));

NS_ASSUME_NONNULL_END
