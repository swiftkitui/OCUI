//
//  OCUIView.m
//  OCUI
//
//  Created by 张行 on 2019/8/23.
//  Copyright © 2019 张行. All rights reserved.
//

#import "OCUIView.h"
#import "OCUIViewParse.h"

@implementation OCUIView {
    UIColor *_uiBackgroundColor;
    OC_VIEW *_uiRenderView;
}

@end

@implementation OCUIView (Color)

- (UIColor *)uiBackgroundColor {
    return _uiBackgroundColor;
}

- (OCUINode * _Nonnull (^)(UIColor * _Nonnull))backgroundColor {
    return ^OCUINode *(UIColor *backgroundColor) {
        self->_uiBackgroundColor = backgroundColor;
        return self;
    };
}

@end

@implementation OCUIView (RenderView)

- (OC_VIEW *)uiRenderView {
    if (!_uiRenderView) {
        OC_VIEW *(^makeBlock)(void) = [[OCUIViewParse shareParse] makeViewBlockWithClassName:[self class]];
        if (makeBlock) {
            _uiRenderView = makeBlock();
        }
        void(^configBlock)(OC_VIEW *, OCUIView*) = [[OCUIViewParse shareParse] configViewBlockWithClassName:[self class]];
        if (configBlock) {
            configBlock(_uiRenderView,self);
        }
    }
    return _uiRenderView;
}

+ (void)loadViewWithClassName:(Class)className
                makeViewBlock:(OC_VIEW * _Nonnull (^)(void))makeViewBlock
              configViewBlock:(void (^)(OC_VIEW * _Nonnull, OCUIView * _Nonnull))configViewBlock {
    [[OCUIViewParse shareParse] addMakeViewBlock:makeViewBlock className:className];
    [[OCUIViewParse shareParse] addConfigViewBlock:configViewBlock className:className];
}

- (void)configViewWithClassName:(Class)className {
    void(^configBlock)(OC_VIEW *, OCUIView*) = [[OCUIViewParse shareParse] configViewBlockWithClassName:className];
    if (configBlock) {
        configBlock(self.uiRenderView,self);
    }
}

@end

