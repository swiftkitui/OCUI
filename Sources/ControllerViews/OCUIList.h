//
//  OCUIList.h
//  OCUIExample
//
//  Created by 张行 on 2019/8/27.
//  Copyright © 2019 张行. All rights reserved.
//

#import "OCUIView.h"
#import "NSArray+CombineValue.h"
#import "UITableViewCell+OCUIRenderView.h"

NS_ASSUME_NONNULL_BEGIN

@interface OCUIList<T:NSObject *> : OCUIView

@property (nonatomic, weak, readonly) CombineBind<NSArray<T> *> *dataBind;

- (instancetype)initWithWithBind:(CombineBind<NSArray<T> *> *)bind
                           block:(UITableViewCell *(^)(void))block;

@end

NS_ASSUME_NONNULL_END
