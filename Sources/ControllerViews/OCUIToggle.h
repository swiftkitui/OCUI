//
//  OCUIToggle.h
//  OCUIExample
//
//  Created by 张行 on 2019/8/31.
//  Copyright © 2019 张行. All rights reserved.
//

#import "OCUIView.h"

NS_ASSUME_NONNULL_BEGIN

@interface OCUIToggle : OCUIView

- (instancetype)initWithIsOn:(BOOL)isOn;

@end

@interface OCUIToggle (Bind)

@property (nonatomic, strong, readonly) CombineBind<NSNumber *> *uiOnBind;

- (instancetype(^)(CombineBind<NSNumber *> *))onBind;

@end

NS_ASSUME_NONNULL_END
