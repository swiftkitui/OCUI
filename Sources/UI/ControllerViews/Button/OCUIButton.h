//
//  OCUIButton.h
//  OCUIExample
//
//  Created by 张行 on 2019/8/30.
//  Copyright © 2019 张行. All rights reserved.
//

#import "OCUIView.h"
#import "OCUICreate.h"
#import "OCUICreate+OCUIButton.h"

NS_ASSUME_NONNULL_BEGIN

@interface OCUIButton : OCUIView

@property (nonatomic, copy, readonly) void(^uiButtonAction)(void);

- (instancetype)initWithAction:(void(^)(void))actionBlock
                         label:(void(^)(OCUICreate *c))labelBlock;

@end


NS_ASSUME_NONNULL_END
