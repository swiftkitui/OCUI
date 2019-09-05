//
//  OCUIiOSLayout.m
//  OCUIExample
//
//  Created by 张行 on 2019/9/3.
//  Copyright © 2019 张行. All rights reserved.
//

#import "OCUIiOSLayout.h"
#import "OCUIMaker.h"
#import <Masonry/Masonry.h>
#import "OCUILayoutCenter.h"

@implementation OCUIiOSLayout

+ (void)loadLayout {
    [self loadHStackLayout];
}

+ (void)loadHStackLayout {
    [OCUIStack<OCUIHStack *> loadLayoutWithClassName:OCUIHStack.self layoutBlock:^(OCUIHStack * _Nonnull stack) {
        
    }];
}

+ (void)loadVStackLayout {
    [OCUIStack<OCUIVStack *> loadLayoutWithClassName:OCUIVStack.self layoutBlock:^(OCUIVStack * _Nonnull stack) {
        __block UIView *topView;
        NSMutableArray<OCUILayoutItem *> *flxedLayoutItems = [NSMutableArray array];
        NSMutableArray<OCUILayoutItem *> *floatLayoutItems = [NSMutableArray array];
        [stack.allLayoutViews enumerateObjectsUsingBlock:^(UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [obj mas_makeConstraints:^(MASConstraintMaker *make) {
                
                if (stack.uiAlignment == OCUIHorizontalAlignmentLeading) {
                    make.leading.equalTo(stack.contentView);
                } else if (stack.uiAlignment == OCUIHorizontalAlignmentCenter) {
                    make.centerX.equalTo(stack.contentView);
                } else {
                    make.trailing.equalTo(stack.contentView);
                }
                
                CGSize intrinsicContentSize = [obj intrinsicContentSize];
                if (intrinsicContentSize.width > 0) {
                    make.width.mas_equalTo(intrinsicContentSize.width);
                } else {
                    make.width.equalTo(stack.contentView);
                }
                
                if (intrinsicContentSize.height > 0) {
                    OCUILayoutItem *item = OCUICreateLayoutItem(intrinsicContentSize.height, obj, ^(OCUILayoutItem * _Nonnull item) {
                        make.height.mas_equalTo(intrinsicContentSize.height);
                    }, ^(OCUILayoutItem * _Nonnull item) {
                        [item.bindView mas_updateConstraints:^(MASConstraintMaker *make) {
                            make.height.mas_equalTo(intrinsicContentSize.height);
                        }];
                    });
                    [flxedLayoutItems addObject:item];
                } else {
                    OCUILayoutItem *item = OCUICreateLayoutItem(0, obj, ^(OCUILayoutItem * _Nonnull item) {
                        make.height.mas_equalTo(intrinsicContentSize.height);
                    }, ^(OCUILayoutItem * _Nonnull item) {
                        [item.bindView mas_updateConstraints:^(MASConstraintMaker *make) {
                            make.height.mas_equalTo(intrinsicContentSize.height);
                        }];
                    });
                    [floatLayoutItems addObject:item];
                }
                
                OCUISpacer *spacer = [stack layoutSpacerWithView:obj];
                if (!spacer || spacer.uiFlxedOffset != NSNotFound) {
                    if (!topView) {
                        make.top.equalTo(stack.contentView);
                    } else {
                        make.top.equalTo(stack.contentView.mas_bottom);
                    }
                } else {
                    if (!topView) {
                        OCUILayoutItem *item = OCUICreateLayoutItem(spacer.uiMinOffset, obj, ^(OCUILayoutItem * _Nonnull item) {
                            make.top.equalTo(stack.contentView).offset(item.value);
                        }, ^(OCUILayoutItem * _Nonnull item) {
                            [item.bindView mas_updateConstraints:^(MASConstraintMaker *make) {
                                make.top.equalTo(stack.contentView).offset(item.value);
                            }];
                        });
                        [floatLayoutItems addObject:item];
                    } else {
                        OCUILayoutItem *item = OCUICreateLayoutItem(spacer.uiMinOffset, obj, ^(OCUILayoutItem * _Nonnull item) {
                            make.top.equalTo(stack.contentView.mas_bottom).offset(item.value);
                        }, ^(OCUILayoutItem * _Nonnull item) {
                            [item.bindView mas_updateConstraints:^(MASConstraintMaker *make) {
                                make.top.equalTo(stack.contentView.mas_bottom).offset(item.value);
                            }];
                        });
                        [floatLayoutItems addObject:item];
                    }
                }
            }];
            topView = obj;
        }];
        OCUILayoutCenter *center = [[OCUILayoutCenter alloc] initWithContentViewLayoutItem:stack.contentView.layoutItem
                                                                          floatLayoutItems:floatLayoutItems
                                                                          flxedLayoutItems:flxedLayoutItems];
        stack.contentView.layoutCenter = center;
    }];
}



@end
