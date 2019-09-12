//
//  OCUINode+OCUINavigationView.h
//  OCUIExample
//
//  Created by 张行 on 2019/9/12.
//  Copyright © 2019 张行. All rights reserved.
//

#import "OCUINode.h"

NS_ASSUME_NONNULL_BEGIN
@class OCUIText;

typedef NS_ENUM(NSUInteger, OCUITitleDisplayMode) {
    OCUITitleDisplayModeAutomatic,
    OCUITitleDisplayModeInline,
    OCUITitleDisplayModeLarge
};

@interface OCUINode (OCUINavigationViewBar)

@property (nonatomic, strong, readonly) OCUIText *uiNavigationBarTitleText;
@property (nonatomic, assign, readonly) OCUITitleDisplayMode uiTitleDisplayMode;

- (OCUINode *(^)(OCUIText *, OCUITitleDisplayMode))navigationBarTitle;

@end

@interface OCUINode (OCUINavigationBarItems)

@property (nonatomic, copy, readonly) NSArray<OCUINode *> *uiLeadingNavigationBarItems;
@property (nonatomic, copy, readonly) NSArray<OCUINode *> *uiTrailingNavigationBarItems;

- (OCUINode *(^)(void(^_Nullable leadingBlock)(OCUICreate *c), void(^_Nullable trailingBlock)(OCUICreate *c)))navigationBarItems;

@end

NS_ASSUME_NONNULL_END
