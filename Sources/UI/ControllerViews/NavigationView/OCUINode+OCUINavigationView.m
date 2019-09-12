//
//  OCUINode+OCUINavigationView.m
//  OCUIExample
//
//  Created by 张行 on 2019/9/12.
//  Copyright © 2019 张行. All rights reserved.
//

#import "OCUINode+OCUINavigationView.h"
#import "OCUICreate.h"

@implementation OCUINode (OCUINavigationViewBar)

- (OCUIText *)uiNavigationBarTitleText {
    return self.propertyGet(@selector(uiNavigationBarTitleText));
}

- (OCUITitleDisplayMode )uiTitleDisplayMode {
    return (OCUITitleDisplayMode)[self.propertyGet(@selector(uiTitleDisplayMode)) integerValue];
}

- (OCUINode *(^)(OCUIText *, OCUITitleDisplayMode))navigationBarTitle {
    return ^OCUINode *(OCUIText *text, OCUITitleDisplayMode titleDisplayMode) {
        self.propertySet(text,@selector(uiNavigationBarTitleText));
        self.propertySet(@(titleDisplayMode),@selector(uiTitleDisplayMode));
        return self;
    };
}

@end

@implementation OCUINode (OCUINavigationBarItems)

- (NSArray<OCUINode *> *)uiLeadingNavigationBarItems {
    return self.propertyGet(@selector(uiLeadingNavigationBarItems));
}

- (NSArray<OCUINode *> *)uiTrailingNavigationBarItems {
    return self.propertyGet(@selector(uiTrailingNavigationBarItems));
}

- (OCUINode *(^)(void(^leadingBlock)(OCUICreate *c), void(^trailingBlock)(OCUICreate *c)))navigationBarItems {
    return ^OCUINode *(void(^leadingBlock)(OCUICreate *c), void(^trailingBlock)(OCUICreate *c)) {
        if (leadingBlock) {
            OCUICreate *create = [[OCUICreate alloc] init];
            leadingBlock(create);
            self.propertySet(create.elenments,@selector(uiLeadingNavigationBarItems));
        }
        if (trailingBlock) {
            OCUICreate *create = [[OCUICreate alloc] init];
            trailingBlock(create);
            self.propertySet(create.elenments,@selector(uiLeadingNavigationBarItems));
        }
        return self;
    };
}

@end
