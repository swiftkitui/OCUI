//
//  OCUILayoutItem.m
//  OCUIExample
//
//  Created by 张行 on 2019/9/5.
//  Copyright © 2019 张行. All rights reserved.
//

#import "OCUILayoutItem.h"
#import <objc/runtime.h>

@implementation OCUILayoutItem {
    void(^_addConstraintsBlock)(OCUILayoutItem *);
    void(^_updateConstraintsBlock)(OCUILayoutItem *);
}

@synthesize value = _value;

- (instancetype)initWithValue:(CGFloat)value
                     bindView:(UIView *)bindView
          addConstraintsBlock:(void (^)(OCUILayoutItem * _Nonnull))addConstraintsBlock
       updateConstraintsBlock:(void (^)(OCUILayoutItem * _Nonnull))updateConstraintsBlock {
    if (self = [super init]) {
        _value = value;
        _bindView = bindView;
        _addConstraintsBlock = addConstraintsBlock;
        _updateConstraintsBlock = updateConstraintsBlock;
        _valueBind = [[CombineBind alloc] initWithContent:@(value)];
        if (_addConstraintsBlock) {
            _addConstraintsBlock(self);
        }
    }
    return self;
}

- (CGFloat)value {
    return MAX(_minValue, _value);
}

- (void)updateValue:(CGFloat)value {
    _value = value;
    _valueBind.wrappedContent = @(value);
    if (_updateConstraintsBlock) {
        _updateConstraintsBlock(self);
    }
}

- (instancetype  _Nonnull (^)(CGFloat))min {
    return ^OCUILayoutItem *(CGFloat min) {
        self->_minValue = min;
        return self;
    };
}

- (instancetype  _Nonnull (^)(NSUInteger))priority {
    return ^OCUILayoutItem *(NSUInteger priority) {
        self->_minValuePriority = priority;
        return self;
    };
}

@end

@implementation UIView (OCUILayoutItem)

- (void)setLayoutItem:(OCUILayoutItem *)layoutItem {
    objc_setAssociatedObject(self, @selector(layoutItem), layoutItem, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (OCUILayoutItem *)layoutItem {
    return objc_getAssociatedObject(self, @selector(layoutItem));
}

@end

FOUNDATION_EXPORT OCUILayoutItem *OCUICreateLayoutItem(CGFloat value, UIView *bindView,void(^addConstraintsBlock)(OCUILayoutItem *item),void(^updateConstraintsBlock)(OCUILayoutItem *item)) {
    return [[OCUILayoutItem alloc] initWithValue:value
                                        bindView:bindView
                             addConstraintsBlock:addConstraintsBlock
                          updateConstraintsBlock:updateConstraintsBlock];
}
