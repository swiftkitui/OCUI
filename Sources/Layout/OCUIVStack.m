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
#import <Masonry/Masonry.h>

@implementation OCUIVStack {

}

- (OCUIVStack * _Nonnull (^)(OCUIHorizontalAlignment))alignment {
    return ^OCUIVStack *(OCUIHorizontalAlignment alignment) {
        self->_stackAlignment = alignment;
        return self;
    };
}

- (void)loadAndLayoutViewsInView:(UIView *)contentView {
    [super loadAndLayoutViewsInView:contentView];
    
    CGFloat viewHeight = CGRectGetHeight(contentView.frame);
    /// 设置距离顶部默认为0
    CGFloat top = 0;
    /// 设置距离底部默认为0
    CGFloat bottom = 0;
    /// 自动布局占位符的个数
    NSUInteger automaticSpacerCount = [self automaticSpacerCount];
    /// 自动布局占位符的高度默认为0
    CGFloat automaticSpacerHeight = 0;
    /// 自动渲染的试图个数
    NSUInteger automaticRenderViewCount = [self automaticRenderViewCount];
    /// 自动试图自动高度默认为0
    CGFloat automaticViewHeight = 0;
    CGFloat intrinsicContentHeight = [self intrinsicContentHeight];
    if (automaticRenderViewCount == 0 && automaticSpacerCount == 0) {
        /// 代表两端自动适应
        if (top > 0) {
            bottom = viewHeight - intrinsicContentHeight - top;
        } else if (bottom > 0) {
            top = viewHeight - intrinsicContentHeight - bottom;
        } else {
            top = (viewHeight - intrinsicContentHeight) / 2;
            bottom = top;
        }
    } else if (automaticRenderViewCount > 0) {
        automaticViewHeight = (viewHeight - intrinsicContentHeight - top - bottom) / automaticRenderViewCount;
    } else {
        automaticSpacerHeight = (viewHeight - intrinsicContentHeight - top- bottom) / automaticSpacerCount;
    }
    
    __block UIView *topView = contentView;
    [self.nodes enumerateObjectsUsingBlock:^(id<OCUIRenderView>  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIView *view = [self viewWithRenderView:obj];
        if (!view) {
            return;
        }
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            /// 布局位置
            if (self.stackAlignment == OCUIHorizontalAlignmentLeading) {
                make.leading.equalTo(contentView);
            } else if (self.stackAlignment == OCUIHorizontalAlignmentCenter) {
                make.centerX.equalTo(contentView);
            } else {
                make.trailing.equalTo(contentView);
            }
            /// 布局大小
            CGSize renderSize = [self sizeWithRenderView:obj];
            if (renderSize.width == 0) {
                make.width.equalTo(contentView);
            } else {
                make.width.mas_equalTo(renderSize.width);
            }
            
            if (renderSize.height == 0) {
                make.height.mas_equalTo(automaticViewHeight);
            } else {
                make.height.mas_equalTo(renderSize.height);
            }
            
            /// 布局顶部
            if ([obj isEqual:self.nodes.firstObject]) {
                make.top.mas_offset(top);
            } else if([obj isEqual:self.nodes.lastObject]) {
                make.bottom.mas_offset(-bottom);
            } else {
                id<OCUIRenderView> upRenderView = self.nodes[idx - 1];
                if (!([upRenderView isKindOfClass:[OCUISpacer class]])) {
                    make.top.equalTo(topView.mas_bottom);
                } else {
                    OCUISpacer *spacer = [[OCUISpacer alloc] init];
                    if (spacer.lenghtOffset) {
                        if ([topView isEqual:contentView]) {
                            make.top.equalTo(topView).offset(spacer.lenghtOffset.height);
                        } else {
                            make.top.equalTo(topView.mas_bottom).offset(spacer.lenghtOffset.height);
                        }
                    } else {
                        if ([topView isEqual:contentView]) {
                           make.top.equalTo(topView).offset(automaticSpacerHeight);
                        } else {
                           make.top.equalTo(topView.mas_bottom).offset(automaticSpacerHeight);
                        }
                        
                    }
                }
            }
        }];
        topView = view;
    }];
    
}

- (CGFloat)intrinsicContentHeight {
    __block CGFloat height = 0;
    [self.nodes enumerateObjectsUsingBlock:^(id<OCUIRenderView>  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[OCUISpacer class]]) {
            OCUISpacer *spacer = [[OCUISpacer alloc] init];
            height += spacer.lenghtOffset.height;
        } else {
            height += [self sizeWithRenderView:obj].height;
        }
    }];
    return height;
}


@end
