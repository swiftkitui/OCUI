//
//  OCUIiOSLayout.m
//  OCUIExample
//
//  Created by 张行 on 2019/9/3.
//  Copyright © 2019 张行. All rights reserved.
//

#import "OCUIiOSLayout.h"
#import "OCUI.h"
#import <Masonry/Masonry.h>
#import "OCUILayoutCenter.h"

@implementation OCUIiOSLayout

+ (void)loadLayout {
    [self loadVStackLayout];
}

+ (void)loadHStackLayout {
    [OCUIStack<OCUIHStack *> loadLayoutWithClassName:OCUIHStack.self layoutBlock:^(OCUIHStack * _Nonnull stack) {
        
    }];
}

+ (void)loadVStackLayout {
    [OCUIStack<OCUIVStack *> loadLayoutWithClassName:OCUIVStack.self layoutBlock:^(OCUIVStack * _Nonnull stack) {
        __block UIView *topView;
        __block BOOL isExitFloatView = NO;
        [stack.allLayoutViews enumerateObjectsUsingBlock:^(UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (obj.intrinsicContentSize.height <= 0) {
                isExitFloatView = YES;
            }
        }];
        [stack.elenments enumerateObjectsUsingBlock:^(OCUINode * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (![obj isKindOfClass:[OCUISpacer class]]) {
                return;
            }
            OCUISpacer *spacer = (OCUISpacer *)obj;
            if (spacer.uiFlxedOffset == NSNotFound && isExitFloatView) {
                spacer.flxedOffset(spacer.uiMinOffset);
            }
        }];
        UIView *contentView = stack.contentView;
        NSMutableArray<OCUILayoutItem *> *flxedLayoutItems = [NSMutableArray array];
        NSMutableArray<OCUILayoutItem *> *floatLayoutItems = [NSMutableArray array];
        [stack.allLayoutViews enumerateObjectsUsingBlock:^(UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [obj mas_makeConstraints:^(MASConstraintMaker *make) {
                
                /// 布局居左 居中 居右
                if (stack.uiAlignment == OCUIHorizontalAlignmentLeading) {
                    make.leading.equalTo(stack.contentView);
                } else if (stack.uiAlignment == OCUIHorizontalAlignmentCenter) {
                    make.centerX.equalTo(stack.contentView);
                } else {
                    make.trailing.equalTo(stack.contentView);
                }
                
                OCUIView *viewNode = [stack viewNodeWithRenderView:obj];
                CGSize intrinsicContentSize = [obj intrinsicContentSize];
                CGFloat width = viewNode.uiSize.width > 0 ? viewNode.uiSize.width : intrinsicContentSize.width;
                CGFloat height = viewNode.uiSize.height > 0 ? viewNode.uiSize.height : intrinsicContentSize.height;
                if (width > 0) {
                    OCUILayoutItem *item = OCUICreateLayoutItem(width, obj, ^(OCUILayoutItem * _Nonnull item) {
                        item.width(make.width.mas_equalTo(item.value));
                        make.leading.greaterThanOrEqualTo(contentView).offset(0);
                        make.trailing.lessThanOrEqualTo(contentView).offset(0);
                    }, ^(OCUILayoutItem * _Nonnull item) {
                        item.widthConstraints.mas_equalTo(item.value);
                    });
                    obj.widthLayoutItem = item;
                } else {
                    make.width.equalTo(stack.contentView);
                }
                
                if (height > 0) {
                    OCUILayoutItem *item = OCUICreateLayoutItem(height, obj, ^(OCUILayoutItem * _Nonnull item) {
                        item.height(make.height.mas_equalTo(item.value));
                    }, ^(OCUILayoutItem * _Nonnull item) {
                        item.heightConstraints.mas_equalTo(item.value);
                    });
                    obj.heightLayoutItem = item;
                    [flxedLayoutItems addObject:item];
                } else {
                    OCUILayoutItem *item = OCUICreateLayoutItem(0, obj, ^(OCUILayoutItem * _Nonnull item) {
                        item.height(make.height.mas_equalTo(item.value));
                    }, ^(OCUILayoutItem * _Nonnull item) {
                        item.heightConstraints.mas_equalTo(item.value);
                    });
                    [floatLayoutItems addObject:item];
                }
                
                OCUISpacer *spacer = [stack layoutSpacerWithView:obj];
                if (!spacer || spacer.uiFlxedOffset != NSNotFound) {
                    if (spacer && spacer.uiFlxedOffset != NSNotFound) {
                        if (!topView) {
                            OCUILayoutItem *item = OCUICreateLayoutItem(spacer.uiFlxedOffset, obj, ^(OCUILayoutItem * _Nonnull item) {
                                item.top(make.top.equalTo(contentView).offset(spacer.uiFlxedOffset));
                            }, ^(OCUILayoutItem * _Nonnull item) {
                                item.topConstraints.offset(item.value);
                            });
                            [flxedLayoutItems addObject:item];
                        } else {
                            OCUILayoutItem *item = OCUICreateLayoutItem(spacer.uiFlxedOffset, obj, ^(OCUILayoutItem * _Nonnull item) {
                                item.top(make.top.equalTo(topView.mas_bottom).offset(spacer.uiFlxedOffset));
                            }, ^(OCUILayoutItem * _Nonnull item) {
                                item.topConstraints.offset(item.value);
                            });
                            [flxedLayoutItems addObject:item];
                        }
                    } else {
                        if (!topView) {
                            make.top.equalTo(contentView);
                        } else {
                            make.top.equalTo(topView.mas_bottom);
                        }
                    }
                    
                } else {
                    if (!topView) {
                        OCUILayoutItem *item = OCUICreateLayoutItem(spacer.uiMinOffset, obj, ^(OCUILayoutItem * _Nonnull item) {
                            item.top(make.top.equalTo(contentView).offset(item.value));
                        }, ^(OCUILayoutItem * _Nonnull item) {
                            item.topConstraints.offset(item.value);
                        });
                        [floatLayoutItems addObject:item];
                    } else {
                        OCUILayoutItem *item = OCUICreateLayoutItem(spacer.uiMinOffset, obj, ^(OCUILayoutItem * _Nonnull item) {
                            item.top(make.top.equalTo(topView.mas_bottom).offset(item.value));
                        }, ^(OCUILayoutItem * _Nonnull item) {
                            item.topConstraints.offset(item.value);
                        });
                        [floatLayoutItems addObject:item];
                    }
                }
            }];
            topView = obj;
        }];
        if ([stack.elenments.lastObject isKindOfClass:[OCUISpacer class]]) {
            OCUISpacer *spacer = (OCUISpacer *)stack.elenments.lastObject;
            if (spacer.uiFlxedOffset != NSNotFound) {
                [flxedLayoutItems addObject:OCUICreateLayoutItem(spacer.uiFlxedOffset, stack.allLayoutViews.lastObject, nil, nil)];
            } else {
                [floatLayoutItems addObject:OCUICreateLayoutItem(spacer.uiMinOffset, stack.allLayoutViews.lastObject, nil, nil)];
            }
        }
        OCUILayoutCenter *center = [[OCUILayoutCenter alloc] initWithContentViewLayoutItem:contentView.heightLayoutItem
                                                                          floatLayoutItems:floatLayoutItems
                                                                          flxedLayoutItems:flxedLayoutItems];
        stack.contentView.layoutCenter = center;
    }];
}



@end
