//
//  OCUIVStack.m
//  OCUI
//
//  Created by 张行 on 2019/8/22.
//  Copyright © 2019 张行. All rights reserved.
//

#import "OCUIVStack.h"
#import "OCUILayout.h"
#import "OCUILayoutContent.h"

@implementation OCUIVStack {
    NSMutableDictionary<NSString *, UIView *> *_makeViewMap;
    
}

- (void)loadAndLayoutViewsInView:(UIView *)contentView {
    _makeViewMap = [NSMutableDictionary dictionary];
    for (id<OCUIRenderView> renderView in self.nodes) {
        UIView *makeView = [self lookMakeViewWithRenderView:renderView];
        if (!makeView) {
            continue;
        }
        [contentView addSubview:makeView];
    }
    for (id<OCUIRenderView> renderView in self.nodes) {
        UIView *makeView = [self lookMakeViewWithRenderView:renderView];
        if (!makeView) {
            continue;
        }
        [self addLayoutInView:renderView
                         view:makeView
                  contentView:contentView];
    }
    _makeViewMap = nil;
}

/**
 默认的居中布局

 @param contentView 父试图
 @param layoutContent 约束
 @param renderView 描述 UI
 @param view 整整的 UI
 */
- (void)centerYSize:(UIView *)contentView layoutContent:(OCUILayoutContent *)layoutContent renderView:(id<OCUIRenderView>)renderView view:(UIView *)view {
    [layoutContent addLayout:^BOOL(MASConstraintMaker * _Nonnull make) {
        CGSize renderSize = CGSizeZero;
        if ([renderView respondsToSelector:@selector(renderSize)]) {
            renderSize = [renderView renderSize];
        }
        CGSize size = [self addSizeInMake:make
                               renderSize:renderSize
                     intrinsicContentSize:[view intrinsicContentSize]];
        if (CGSizeEqualToSize(size, CGSizeZero)) {
            return NO;
        }
        NSUInteger index = [self.nodes indexOfObject:renderView];
        make.centerX.equalTo(contentView);
        BOOL isDoubleNumber = self.nodes.count % 2 == 0;
        NSUInteger countCenterIndex = self.nodes.count / 2;
        if (isDoubleNumber) {
            countCenterIndex --;
        }
        if (index < countCenterIndex) {
            make.bottom.equalTo([self lookMakeViewWithRenderViewIndex:(index + 1)].mas_top);
        } else if (index == countCenterIndex) {
            if (self.nodes.count % 2 != 0) {
                make.bottom.equalTo(contentView.mas_centerY);
            } else {
                make.centerY.equalTo(contentView.mas_centerY);
            }
        } else {
            make.top.equalTo([self lookMakeViewWithRenderViewIndex:(index - 1)].mas_bottom);
        }
        return YES;
    }];
}

- (void)addLayoutInView:(id<OCUIRenderView>)renderView
                   view:(UIView *)view
            contentView:(UIView *)contentView  {
    OCUILayoutContent *layoutContent = [[OCUILayoutContent alloc] initWithView:view];
    
    /// Sparce 布局
    [layoutContent addLayout:^BOOL(MASConstraintMaker * _Nonnull make) {
        if (![self isExitSpacer]) {
            return NO;
        }
        NSUInteger index = [self.nodes indexOfObject:renderView];
        if ([renderView isEqual:self.nodes.firstObject]) {
            make.top.equalTo(contentView).offset(0);
        } else if ([renderView isEqual:self.nodes.lastObject]) {
            make.bottom.equalTo(contentView).offset(0);
        } else if([renderView isKindOfClass:[OCUISpacer class]]){
            
        } else {
            id<OCUIRenderView> upRenderView = self.nodes[(index - 1)];
            if ([upRenderView isKindOfClass:[OCUISpacer class]]) {
                make.top.greaterThanOrEqualTo([self lookMakeViewWithRenderViewIndex:(index - 2)].mas_bottom).offset(0);
            } else {
                make.top.equalTo([self lookMakeViewWithRenderViewIndex:(index - 1)].mas_bottom);
            }
        }
        make.centerX.equalTo(contentView);
        return YES;
    }];
    
    /// 默认布局
    [self centerYSize:contentView layoutContent:layoutContent renderView:renderView view:view];
    
    if (!layoutContent.isAutolayoutOK) {
        NSString *message = [NSString stringWithFormat:@"renderView:%@ layout error",renderView];
        NSAssert(NO, message);
    }
}

- (CGSize)addSizeInMake:(MASConstraintMaker *)make
             renderSize:(CGSize)renderSize
   intrinsicContentSize:(CGSize)intrinsicContentSize{
    if (renderSize.width != 0 && renderSize.height != 0) {
        make.size.mas_equalTo(renderSize);
        return renderSize;
    } else if (intrinsicContentSize.width != 0 && intrinsicContentSize.height != 0) {
        return intrinsicContentSize;
    } else {
        return CGSizeZero;
    }
}

- (UIView *)lookMakeViewWithRenderView:(id<OCUIRenderView>)renderView {
    NSUInteger index = [self.nodes indexOfObject:renderView];
    return [self lookMakeViewWithRenderViewIndex:index];
}

- (UIView *)lookMakeViewWithRenderViewIndex:(NSUInteger)index {
    NSString *key = [@(index) stringValue];
    UIView *view = _makeViewMap[key];
    if (!view) {
        id<OCUIRenderView> renderView = self.nodes[index];
        view = [renderView makeOCUIView];
        if (view) {
            _makeViewMap[key] = view;
        }
        return view;
    } else {
        if (view.superview) {
            return view;
        } else {
            return nil;
        }
    }
    
}

- (BOOL)isExitSpacer {
    for (id<OCUIRenderView> renderView in self.nodes) {
        if ([renderView isKindOfClass:[OCUISpacer class]]) {
            return YES;
        }
    }
    return NO;
}

@end
