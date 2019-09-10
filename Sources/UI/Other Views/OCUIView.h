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

@interface OCUIView<V:OC_VIEW *, N:OCUIView *> : OCUINode

@end

FOUNDATION_EXPORT OCUIView *View(void);

@interface OCUIView (Color)

@property (nonatomic, strong, readonly) UIColor *uiBackgroundColor;

@end

@interface OCUIView<V:OC_VIEW *, N:OCUIView *> (RenderView)

@property (nonatomic, strong, readonly) OC_VIEW *uiRenderView;

+ (void)loadViewWithClassName:(Class)className
                makeViewBlock:(V(^)(void))makeViewBlock
              configViewBlock:(void(^)(V view, N node))configViewBlock;

- (void)configViewWithClassName:(Class)className;

@end

NS_ASSUME_NONNULL_END
