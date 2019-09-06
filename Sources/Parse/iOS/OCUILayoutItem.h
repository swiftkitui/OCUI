//
//  OCUILayoutItem.h
//  OCUIExample
//
//  Created by 张行 on 2019/9/5.
//  Copyright © 2019 张行. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CombineObjectObjc/NSObject+CombineBind.h>
#import <Masonry/Masonry.h>

NS_ASSUME_NONNULL_BEGIN
@class OCUILayoutItem;

@interface OCUILayoutItem : NSObject

@property (nonatomic, assign, readonly) CGFloat value;
@property (nonatomic, assign, readonly) CGFloat minValue;
@property (nonatomic, assign, readonly) NSUInteger minValuePriority;
@property (nonatomic, weak, readonly) UIView *bindView;
@property (nonatomic, strong, readonly) CombineBind<NSNumber *> *valueBind;

- (instancetype)initWithValue:(CGFloat)value
                     bindView:(UIView *)bindView
          addConstraintsBlock:(void(^)(OCUILayoutItem *item))addConstraintsBlock
       updateConstraintsBlock:(void(^)(OCUILayoutItem *item))updateConstraintsBlock;

- (void)updateValue:(CGFloat)value;
- (instancetype(^)(CGFloat))min;
- (instancetype(^)(NSUInteger))priority;

@end

@interface OCUILayoutItem (MASConstrints)

@property (nonatomic, strong, readonly) MASConstraint *topConstraints;
@property (nonatomic, strong, readonly) MASConstraint *leadingConstraints;
@property (nonatomic, strong, readonly) MASConstraint *widthConstraints;
@property (nonatomic, strong, readonly) MASConstraint *heightConstraints;

- (instancetype(^)(MASConstraint *))top;
- (instancetype(^)(MASConstraint *))leading;
- (instancetype(^)(MASConstraint *))width;
- (instancetype(^)(MASConstraint *))height;

@end

@interface UIView (OCUILayoutItem)

@property (nonatomic, strong) OCUILayoutItem *widthLayoutItem;
@property (nonatomic, strong) OCUILayoutItem *heightLayoutItem;

@end

FOUNDATION_EXPORT OCUILayoutItem *OCUICreateLayoutItem(CGFloat value, UIView *bindView,void(^_Nullable addConstraintsBlock)(OCUILayoutItem *item),void(^_Nullable updateConstraintsBlock)(OCUILayoutItem *item));

NS_ASSUME_NONNULL_END
