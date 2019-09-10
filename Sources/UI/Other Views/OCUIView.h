//
//  OCUIView.h
//  OCUI
//
//  Created by 张行 on 2019/8/23.
//  Copyright © 2019 张行. All rights reserved.
//

#import "OCUINode.h"

NS_ASSUME_NONNULL_BEGIN
@class OCUIView;

@interface OCUIView<V:UIView *, N:OCUIView *> : OCUINode

@end

FOUNDATION_EXPORT OCUIView *View(void);

@interface OCUIView (Color)

@property (nonatomic, strong, readonly) UIColor *uiBackgroundColor;

@end

@interface OCUIView<V:UIView *, N:OCUIView *> (RenderView)

@property (nonatomic, strong, readonly) UIView *uiRenderView;

+ (void)loadViewWithClassName:(Class)className
                makeViewBlock:(V(^)(N node))makeViewBlock
              configViewBlock:(void(^)(V view, N node))configViewBlock;

- (void)configViewWithClassName:(Class)className;

@end

NS_ASSUME_NONNULL_END
