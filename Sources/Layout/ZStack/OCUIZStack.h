//
//  OCUIZStack.h
//  OCUI
//
//  Created by 张行 on 2019/8/22.
//  Copyright © 2019 张行. All rights reserved.
//

#import "OCUIStack.h"
#import "OCUICreate+OCUIZStack.h"

NS_ASSUME_NONNULL_BEGIN

@interface OCUIZStack : OCUIStack

@end

@interface OCUIZStack (Alignment)

@property (nonatomic, strong, readonly) OCUIAlignment *uiAlignment;

- (instancetype(^)(OCUIAlignment *))alignment;

@end


NS_ASSUME_NONNULL_END
