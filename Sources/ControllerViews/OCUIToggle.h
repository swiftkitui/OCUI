//
//  OCUIToggle.h
//  OCUIExample
//
//  Created by 张行 on 2019/8/31.
//  Copyright © 2019 张行. All rights reserved.
//

#import "OCUIView.h"

NS_ASSUME_NONNULL_BEGIN

@interface OCUIToggle : OCUIView<CombineView>

- (instancetype)initWithIsOn:(BOOL)isOn;

@end

NS_ASSUME_NONNULL_END
