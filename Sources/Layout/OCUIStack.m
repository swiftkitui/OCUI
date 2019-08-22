//
//  OCUIStack.m
//  OCUI
//
//  Created by 张行 on 2019/8/22.
//  Copyright © 2019 张行. All rights reserved.
//

#import "OCUIStack.h"
#import "OCUIRenderView.h"

@interface OCUIStack ()

@property (nonatomic, copy) NSMutableArray<id<OCUIRenderView>> *nodes;

@end

@implementation OCUIStack

- (instancetype)init {
    if (self = [super init]) {
        _nodes = [NSMutableArray array];
    }
    return self;
}

- (OCUIText * _Nonnull (^)(NSString * _Nonnull))Text {
    return ^OCUIText *(NSString *content) {
        OCUIText *text = [[OCUIText alloc] initWithText:content];
        [self.nodes addObject:text];
        return text;
    };
}

- (OCUISpacer * _Nonnull (^)(void))spacer {
    return ^OCUISpacer *{
        OCUISpacer *spacer = [[OCUISpacer alloc] init];
        [self.nodes addObject:spacer];
        return spacer;
    };
}

- (void)loadAndLayoutViewsInView:(UIView *)view {}

@end
