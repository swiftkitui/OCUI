//
//  OCUIAlignment.h
//  OCUIExample
//
//  Created by 张行 on 2019/9/3.
//  Copyright © 2019 张行. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, OCUIVerticalAlignment) {
    OCUIVerticalAlignmentTop,
    OCUIVerticalAlignmentCenter,
    OCUIVerticalAlignmentBottom,
    OCUIVerticalAlignmentFirstTextBaseline,
    OCUIVerticalAlignmentLastTextBaseline
};

typedef NS_ENUM(NSUInteger,OCUIHorizontalAlignment) {
    OCUIHorizontalAlignmentLeading,
    OCUIHorizontalAlignmentCenter,
    OCUIHorizontalAlignmentTrailing
};

@interface OCUIAlignment : NSObject

@property (nonatomic, assign, readonly) OCUIVerticalAlignment uiVerticalAlignment;
@property (nonatomic, assign, readonly) OCUIHorizontalAlignment uiHorizontalAlignment;

- (instancetype)initWithVerticalAlignment:(OCUIVerticalAlignment)verticalAlignment
                      horizontalAlignment:(OCUIHorizontalAlignment)horizontalAlignment;

@end

@interface OCUIAlignment (ClassAlignment)

@property (nonatomic, strong, readonly, class) OCUIAlignment *bottom;
@property (nonatomic, strong, readonly, class) OCUIAlignment *bottomLeading;
@property (nonatomic, strong, readonly, class) OCUIAlignment *bottomTrailing;
@property (nonatomic, strong, readonly, class) OCUIAlignment *center;
@property (nonatomic, strong, readonly, class) OCUIAlignment *leading;
@property (nonatomic, strong, readonly, class) OCUIAlignment *top;
@property (nonatomic, strong, readonly, class) OCUIAlignment *topLeading;
@property (nonatomic, strong, readonly, class) OCUIAlignment *topTrailing;
@property (nonatomic, strong, readonly, class) OCUIAlignment *trailing;

@end

NS_ASSUME_NONNULL_END
