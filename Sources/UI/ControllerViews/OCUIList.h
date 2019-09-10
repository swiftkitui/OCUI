//
//  OCUIList.h
//  OCUIExample
//
//  Created by 张行 on 2019/8/27.
//  Copyright © 2019 张行. All rights reserved.
//

#import "OCUIView.h"

NS_ASSUME_NONNULL_BEGIN
@class OCUISection;

@interface OCUIList : OCUIView

- (instancetype)initWithBlock:(void(^)(void))block;

@end

FOUNDATION_EXPORT OCUIList *List(void(^block)(void));

@interface OCUISection : OCUINode

- (instancetype)initWithBlock:(void(^)(void))block;

FOUNDATION_EXPORT OCUISection *Section(void(^block)(void));

@end

NS_ASSUME_NONNULL_END
