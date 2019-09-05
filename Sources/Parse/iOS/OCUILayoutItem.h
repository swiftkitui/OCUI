//
//  OCUILayoutItem.h
//  OCUIExample
//
//  Created by 张行 on 2019/9/5.
//  Copyright © 2019 张行. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CombineObjectObjc/NSObject+CombineBind.h>

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

@interface UIView (OCUILayoutItem)

@property (nonatomic, strong) OCUILayoutItem *layoutItem;

@end

FOUNDATION_EXPORT OCUILayoutItem *OCUICreateLayoutItem(CGFloat value, UIView *bindView,void(^addConstraintsBlock)(OCUILayoutItem *item),void(^updateConstraintsBlock)(OCUILayoutItem *item));

NS_ASSUME_NONNULL_END
