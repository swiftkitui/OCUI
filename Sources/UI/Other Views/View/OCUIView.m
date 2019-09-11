//
//  OCUIView.m
//  OCUI
//
//  Created by 张行 on 2019/8/23.
//  Copyright © 2019 张行. All rights reserved.
//

#import "OCUIView.h"
#import "OCUIViewParse.h"

@implementation OCUIView

@end

@implementation OCUIView (RenderView)

- (UIView *)uiRenderView {
    UIView *view = self.propertyGet(@selector(uiRenderView));
    if (!view) {
        UIView *(^makeBlock)(OCUIView *) = [[OCUIViewParse shareParse] makeViewBlockWithClassName:[self class]];
        if (makeBlock) {
            view = makeBlock(self);
            self.propertySet(view,@selector(uiRenderView));
        }
        void(^configBlock)(UIView *, OCUIView*) = [[OCUIViewParse shareParse] configViewBlockWithClassName:[self class]];
        if (configBlock) {
            configBlock(view,self);
        }
    }
    return view;
}

+ (void)loadViewWithClassName:(Class)className
                makeViewBlock:(UIView * _Nonnull (^)(OCUIView *))makeViewBlock
              configViewBlock:(void (^)(UIView * _Nonnull, OCUIView * _Nonnull))configViewBlock {
    [[OCUIViewParse shareParse] addMakeViewBlock:makeViewBlock className:className];
    [[OCUIViewParse shareParse] addConfigViewBlock:configViewBlock className:className];
}

- (void)configViewWithClassName:(Class)className {
    void(^configBlock)(UIView *, OCUIView*) = [[OCUIViewParse shareParse] configViewBlockWithClassName:className];
    if (configBlock) {
        configBlock(self.uiRenderView,self);
    }
}

@end

