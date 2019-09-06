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
    MASConstraint *_topConstraints;
    MASConstraint *_leadingConstraints;
    MASConstraint *_widthConstraints;
    MASConstraint *_heightConstraints;
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
    if (_value == value) {
        return;
    }
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

@implementation OCUILayoutItem (MASConstrints)

- (MASConstraint *)topConstraints {
    return _topConstraints;
}

- (MASConstraint *)leadingConstraints {
    return _leadingConstraints;
}

- (MASConstraint *)widthConstraints {
    return _widthConstraints;
}

- (MASConstraint *)heightConstraints {
    return _heightConstraints;
}

- (instancetype  _Nonnull (^)(MASConstraint * _Nonnull))top {
    return ^OCUILayoutItem *(MASConstraint *top) {
        self->_topConstraints = top;
        return self;
    };
}

- (instancetype  _Nonnull (^)(MASConstraint * _Nonnull))leading {
    return ^OCUILayoutItem *(MASConstraint *leading) {
        self->_leadingConstraints = leading;
        return self;
    };
}

- (instancetype  _Nonnull (^)(MASConstraint * _Nonnull))width {
    return ^OCUILayoutItem *(MASConstraint *width) {
        self->_widthConstraints = width;
        return self;
    };
}

- (instancetype  _Nonnull (^)(MASConstraint * _Nonnull))height {
    return ^OCUILayoutItem *(MASConstraint *height) {
        self->_heightConstraints = height;
        return self;
    };
}

@end

@implementation UIView (OCUILayoutItem)

- (void)setWidthLayoutItem:(OCUILayoutItem *)widthLayoutItem {
    objc_setAssociatedObject(self, @selector(widthLayoutItem), widthLayoutItem, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setHeightLayoutItem:(OCUILayoutItem *)heightLayoutItem {
    objc_setAssociatedObject(self, @selector(heightLayoutItem), heightLayoutItem, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (OCUILayoutItem *)widthLayoutItem {
    return objc_getAssociatedObject(self, @selector(widthLayoutItem));
}

- (OCUILayoutItem *)heightLayoutItem {
    return objc_getAssociatedObject(self, @selector(heightLayoutItem));
}

@end

FOUNDATION_EXPORT OCUILayoutItem *OCUICreateLayoutItem(CGFloat value, UIView *bindView,void(^addConstraintsBlock)(OCUILayoutItem *item),void(^updateConstraintsBlock)(OCUILayoutItem *item)) {
    return [[OCUILayoutItem alloc] initWithValue:value
                                        bindView:bindView
                             addConstraintsBlock:addConstraintsBlock
                          updateConstraintsBlock:updateConstraintsBlock];
}
