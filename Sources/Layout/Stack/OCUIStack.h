//
//  OCUIStack.h
//  OCUIExample
//
//  Created by 张行 on 2019/9/3.
//  Copyright © 2019 张行. All rights reserved.
//

#import "OCUINode.h"
#import "OCUISpacer.h"
#import "OCUIView.h"
#import "OCUIAlignment.h"

NS_ASSUME_NONNULL_BEGIN
@class OCUIStack;

@interface OCUIStack<S:OCUIStack *> : OCUINode
    
@end

@interface OCUIStack (UIView)

@property (nonatomic, strong, readonly) UIView *contentView;
@property (nonatomic, copy, readonly) NSArray<UIView *> *allLayoutViews;

@end

@interface OCUIStack<S:OCUIStack *> (Layout)

+ (void)loadLayoutWithClassName:(Class)className
                    layoutBlock:(void(^)(S stack))layoutBlock;

@end

@interface OCUIStack (Spacer)

/// 获取所有浮动布局的 Spacer 数组
- (NSArray<OCUISpacer *> *)allFloatSpacers;
- (OCUISpacer *)layoutSpacerWithView:(UIView *)view;

@end

@interface OCUIStack (OCUIView)

- (OCUIView *)viewNodeWithRenderView:(UIView *)view;

@end


NS_ASSUME_NONNULL_END
