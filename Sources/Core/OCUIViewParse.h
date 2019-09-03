//
//  OCUIViewParse.h
//  OCUIExample
//
//  Created by 张行 on 2019/9/3.
//  Copyright © 2019 张行. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OCUIView.h"
#import "OCUIStack.h"

NS_ASSUME_NONNULL_BEGIN

@interface OCUIViewParse : NSObject

+ (instancetype)shareParse;

@end

@interface OCUIViewParse (MakeView)

- (void)addMakeViewBlock:(OC_VIEW *(^)(void))block
               className:(Class)className;
- (OC_VIEW *(^)(void))makeViewBlockWithClassName:(Class)className;

@end

@interface OCUIViewParse (ConfigView)

- (void)addConfigViewBlock:(void(^)(OC_VIEW *view, OCUIView *node))block
                 className:(Class)className;
- (void(^)(OC_VIEW *view, OCUIView *node))configViewBlockWithClassName:(Class)className;

@end

@interface OCUIViewParse (Layout)

- (void)addLayoutBlock:(void(^)(OCUIStack *stack))block
             className:(Class)className;
- (void (^)(OCUIStack *))layoutViewBlockWithClassName:(Class)className;
@end

NS_ASSUME_NONNULL_END
