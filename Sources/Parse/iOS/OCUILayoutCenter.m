//
//  OCUILayoutCenter.m
//  OCUIExample
//
//  Created by 张行 on 2019/9/5.
//  Copyright © 2019 张行. All rights reserved.
//

#import "OCUILayoutCenter.h"
#import <objc/runtime.h>

@implementation OCUILayoutCenter {
    OCUILayoutItem *_contentViewLayoutItem;
    NSArray<OCUILayoutItem *> *_floatLayoutItems;
    NSArray<OCUILayoutItem *> *_flxedLayoutItems;
}

- (instancetype)initWithContentViewLayoutItem:(OCUILayoutItem *)contentViewLayoutItem
                             floatLayoutItems:(NSArray<OCUILayoutItem *> *)floatLayoutItems
                             flxedLayoutItems:(NSArray<OCUILayoutItem *> *)flxedLayoutItems {
    if (self = [super init]) {
        _contentViewLayoutItem = contentViewLayoutItem;
        _floatLayoutItems = floatLayoutItems;
        _flxedLayoutItems = flxedLayoutItems;
        [self updateFloatLayoutItem];
        if (contentViewLayoutItem) {
            [self listenLayoutItems:@[contentViewLayoutItem]];
        }
        [self listenLayoutItems:flxedLayoutItems];
    }
    return self;
}

- (void)listenLayoutItems:(NSArray<OCUILayoutItem *> *)items {
    [items enumerateObjectsUsingBlock:^(OCUILayoutItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self listenLayoutItem:obj];
    }];
}

- (void)listenLayoutItem:(OCUILayoutItem *)item {
    [item.valueBind setContentChanged:^(NSNumber * _Nonnull content) {
        [self updateFloatLayoutItem];
    }];
}

- (void)updateFloatLayoutItem {
    CGFloat countFlxedLayoutValue = [self countFlxedLayoutValue];
    CGFloat currentFloatLayoutValue = _contentViewLayoutItem.value - countFlxedLayoutValue;
    CGFloat minFloatLayoutValue = [self minFloatLayoutValue];
    CGFloat maxFloatLayoutValue = [self maxFloatLayoutValue];
    if (currentFloatLayoutValue <= minFloatLayoutValue) {
        [_floatLayoutItems enumerateObjectsUsingBlock:^(OCUILayoutItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [obj updateValue:obj.minValue];
        }];
    } else if (currentFloatLayoutValue < maxFloatLayoutValue) {
        [self updateFloatLayoutWithRemainFloatLayoutItems:_floatLayoutItems remainFloatLayoutValue:currentFloatLayoutValue];
    } else {
        CGFloat averageFloatValue = maxFloatLayoutValue * 1.0 / _floatLayoutItems.count;
        [_floatLayoutItems enumerateObjectsUsingBlock:^(OCUILayoutItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [obj updateValue:averageFloatValue];
        }];
    }
}

- (void)updateFloatLayoutWithRemainFloatLayoutItems:(NSArray<OCUILayoutItem *> *)remainFloatLayoutItems
                             remainFloatLayoutValue:(CGFloat)remainFloatLayoutValue {
    if (remainFloatLayoutValue == 0 || remainFloatLayoutItems.count == 0) {
        return;
    }
    NSMutableArray<OCUILayoutItem *> *tempRemainFloatLayoutItems = [NSMutableArray arrayWithArray:remainFloatLayoutItems];
    OCUILayoutItem *lowPriorityLayoutItem = [self lowPriorityLayoutItemWithFloatLayoutItems:tempRemainFloatLayoutItems];
    [lowPriorityLayoutItem updateValue:lowPriorityLayoutItem.minValue];
    [tempRemainFloatLayoutItems removeObject:lowPriorityLayoutItem];
    remainFloatLayoutValue -= lowPriorityLayoutItem.minValue;
    [self updateFloatLayoutWithRemainFloatLayoutItems:tempRemainFloatLayoutItems remainFloatLayoutValue:remainFloatLayoutValue];
}

- (OCUILayoutItem *)lowPriorityLayoutItemWithFloatLayoutItems:(NSArray<OCUILayoutItem *> *)floatLayoutItems {
    __block OCUILayoutItem *lowPriorityLayoutItem;
    [floatLayoutItems enumerateObjectsUsingBlock:^(OCUILayoutItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (!lowPriorityLayoutItem || lowPriorityLayoutItem.minValuePriority < obj.minValuePriority) {
            lowPriorityLayoutItem = obj;
        }
    }];
    return lowPriorityLayoutItem;
}

- (CGFloat)countFlxedLayoutValue {
    __block CGFloat countFlxedLayoutValue = 0;
    [_flxedLayoutItems enumerateObjectsUsingBlock:^(OCUILayoutItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        countFlxedLayoutValue += obj.value;
    }];
    return countFlxedLayoutValue;
}

- (CGFloat)minFloatLayoutValue {
    __block CGFloat minFloatLayoutValue = 0;
    [_floatLayoutItems enumerateObjectsUsingBlock:^(OCUILayoutItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        minFloatLayoutValue += obj.minValue;
    }];
    return minFloatLayoutValue;
}

- (CGFloat)maxFloatLayoutValue {
    __block CGFloat maxMinFloatLayoutValue = 0;
    [_floatLayoutItems enumerateObjectsUsingBlock:^(OCUILayoutItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.minValue > maxMinFloatLayoutValue) {
            maxMinFloatLayoutValue = obj.minValue;
        }
    }];
    return (maxMinFloatLayoutValue * _floatLayoutItems.count);
}

@end

@implementation UIView (OCUILayoutCenter)

- (void)setLayoutCenter:(OCUILayoutCenter *)layoutCenter {
    objc_setAssociatedObject(self, @selector(layoutCenter), layoutCenter, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (OCUILayoutCenter *)layoutCenter {
    return objc_getAssociatedObject(self, @selector(layoutCenter));
}

@end
