//
//  OCUINavigationView.h
//  OCUIExample
//
//  Created by 张行 on 2019/9/9.
//  Copyright © 2019 张行. All rights reserved.
//

#import "OCUINode.h"
#import "OCUINavigationLink.h"
#import "OCUIText.h"
#import "OCUICreate.h"

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSUInteger, OCUITitleDisplayMode) {
    OCUITitleDisplayModeAutomatic,
    OCUITitleDisplayModeInline,
    OCUITitleDisplayModeLarge
};

@interface OCUINavigationView : OCUINode

- (void)addNavigationControllerInView:(UIViewController *)view;

@end

@interface OCUINode (NavigationBar)

@property (nonatomic, strong, readonly) OCUIText *uiNavigationBarTitleText;
@property (nonatomic, assign, readonly) OCUITitleDisplayMode *uiTitleDisplayMode;

- (OCUINode *(^)(OCUIText *, OCUITitleDisplayMode))navigationBarTitle;

@end

@interface OCUINode (NavigationBarItems)

@property (nonatomic, strong, readonly) NSArray<OCUINode *> *uiLeadingNavigationBarItems;
@property (nonatomic, strong, readonly) NSArray<OCUINode *> *uiTrailingNavigationBarItems;

- (OCUINode *(^)(void(^leadingBlock)(void), void(^trailingBlock)(void)))navigationBarItems;

@end

FOUNDATION_EXPORT OCUINavigationView *NavigationView(OCUICreateElenmentBlock);

@interface OCUICreate (OCUINavigationView)

- (OCUINavigationView *(^)(OCUICreateElenmentBlock))NavigationView;

@end


NS_ASSUME_NONNULL_END
