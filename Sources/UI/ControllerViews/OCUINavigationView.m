//
//  OCUINavigationView.m
//  OCUIExample
//
//  Created by 张行 on 2019/9/9.
//  Copyright © 2019 张行. All rights reserved.
//

#import "OCUINavigationView.h"
#import "OCUICreate.h"

@implementation OCUINavigationView

@end

@implementation OCUINode (NavigationBar)

- (OCUIText *)uiNavigationBarTitleText {
    return self.propertyGet(@selector(uiNavigationBarTitleText));
}

- (OCUITitleDisplayMode *)uiTitleDisplayMode {
    return (OCUITitleDisplayMode *)[self.propertyGet(@selector(uiTitleDisplayMode)) integerValue];
}

- (OCUINode *(^)(OCUIText *, OCUITitleDisplayMode))navigationBarTitle {
    return ^OCUINode *(OCUIText *text, OCUITitleDisplayMode titleDisplayMode) {
        self.propertySet(text,@selector(uiNavigationBarTitleText));
        self.propertySet(@(titleDisplayMode),@selector(uiTitleDisplayMode));
        return self;
    };
}

@end

@implementation OCUINode (NavigationBarItems)

- (NSArray<OCUINode *> *)uiLeadingNavigationBarItems {
    return self.propertyGet(@selector(uiLeadingNavigationBarItems));
}

- (NSArray<OCUINode *> *)uiTrailingNavigationBarItems {
    return self.propertyGet(@selector(uiTrailingNavigationBarItems));
}

- (OCUINode *(^)(void(^leadingBlock)(void), void(^trailingBlock)(void)))navigationBarItems {
    return ^OCUINode *(void(^leadingBlock)(void), void(^trailingBlock)(void)) {
        if (leadingBlock) {
//            NSArray<OCUINode *> *nodes = CreateUINodes(leadingBlock);
//            self.propertySet(nodes,@selector(uiLeadingNavigationBarItems));
        }
        if (trailingBlock) {
//            NSArray<OCUINode *> *nodes = CreateUINodes(trailingBlock);
//            self.propertySet(nodes,@selector(uiTrailingNavigationBarItems));
        }
        return self;
    };
}

@end

FOUNDATION_EXPORT OCUINavigationView *NavigationView(OCUICreateElenmentBlock) {
    if (!block) {
        return nil;
    }
    OCUINavigationView *view = [[OCUINavigationView alloc] initWithElenmentsBlock:block];
    return view;
}

@implementation OCUICreate (OCUINavigationView)

- (OCUINavigationView *(^)(OCUICreateElenmentBlock))NavigationView {
    return ^OCUINavigationView *(OCUICreateElenmentBlock) {
        OCUINavigationView *view = NavigationView(block);
        [self addElenment:view];
        return view;
    };
}

@end
