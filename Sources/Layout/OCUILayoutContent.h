//
//  OCUILayoutContent.h
//  OCUI
//
//  Created by 张行 on 2019/8/22.
//  Copyright © 2019 张行. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Masonry/Masonry.h>

NS_ASSUME_NONNULL_BEGIN

@interface OCUILayoutContent : NSObject

@property (nonatomic, assign, readonly) BOOL isAutolayoutOK;
@property (nonatomic, weak, readonly) UIView *view;

- (instancetype)initWithView:(UIView *)view;

- (void)addLayout:(BOOL (^)(MASConstraintMaker * make))block;

@end

NS_ASSUME_NONNULL_END
