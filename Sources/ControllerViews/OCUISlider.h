//
//  OCUISlider.h
//  OCUIExample
//
//  Created by 张行 on 2019/8/31.
//  Copyright © 2019 张行. All rights reserved.
//

#import "OCUIView.h"

NS_ASSUME_NONNULL_BEGIN

@interface OCUISlider : OCUIView

- (instancetype)initWithValue:(CGFloat)value;

@end

@interface OCUISlider (Bind)

@property (nonatomic, strong, readonly) CombineBind<NSNumber *> *uiValueBind;

- (instancetype(^)(CombineBind<NSNumber *> *))valueBind;

@end

NS_ASSUME_NONNULL_END
