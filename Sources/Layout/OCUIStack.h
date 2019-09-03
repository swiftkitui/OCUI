//
//  OCUIStack.h
//  OCUIExample
//
//  Created by 张行 on 2019/9/3.
//  Copyright © 2019 张行. All rights reserved.
//

#import "OCUINode.h"

NS_ASSUME_NONNULL_BEGIN
@class OCUIStack;

@interface OCUIStack<S:OCUIStack *> : OCUINode

@property (nonatomic, copy, readonly) NSMutableArray<OCUINode *> *nodes;
@property (nonatomic, strong, readonly) OC_VIEW *contentView;
@property (nonatomic, copy, readonly) NSArray<OC_VIEW *> *allLayoutViews;

- (void)startLayoutWithContentView:(OC_VIEW *)contentView;

@end

@interface OCUIStack<S:OCUIStack *> (Layout)

+ (void)LoadLayoutWithClassName:(Class)className
                    layoutBlock:(void(^)(S stack))layoutBlock;

@end

NS_ASSUME_NONNULL_END
