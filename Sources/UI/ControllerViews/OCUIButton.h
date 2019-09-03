//
//  OCUIButton.h
//  OCUIExample
//
//  Created by 张行 on 2019/8/30.
//  Copyright © 2019 张行. All rights reserved.
//

#import "OCUIView.h"

NS_ASSUME_NONNULL_BEGIN

@interface OCUIButton : OCUIView

@property (nonatomic, copy, readonly) void(^uiButtonAction)(void);

- (instancetype)initWithText:(NSString *)text
                        make:(void(^)(void))makeBlock;

@end

@interface OCUIButton (Chained)

- (instancetype(^)(void(^)(void)))action;

@end

NS_ASSUME_NONNULL_END
