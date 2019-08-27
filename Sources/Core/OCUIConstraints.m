//
//  OCUIConstraints.m
//  OCUIExample
//
//  Created by 张行 on 2019/8/26.
//  Copyright © 2019 张行. All rights reserved.
//

#import "OCUIConstraints.h"

@interface OCUIConstraints ()

@property (nonatomic, strong) NSNumber *value;

@end

@implementation OCUIConstraints

- (instancetype)initWithValue:(CGFloat)value {
    if (self = [super init]) {
        _value = @(value);
        _valueBind = CombineBindMaker(_value);
        __weak typeof(self) weakSelf = self;
        _valueBind.contentChanged = ^(NSNumber * content) {
            __strong typeof(weakSelf) strongSelf = weakSelf;
            [strongSelf.bindViewConstraints enumerateObjectsUsingBlock:^(MASConstraint * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if (strongSelf.contraintsValueChanged) {
                    strongSelf.contraintsValueChanged([content floatValue],obj);
                }
            }];
        };
        _bindViewConstraints = [NSMutableArray array];
        _bindViewHashNumbers = [NSMutableArray array];
    }
    return self;
}

- (void)addBindViewHash:(NSUInteger)hashValue {
    __block BOOL isExit = NO;
    [self.bindViewHashNumbers enumerateObjectsUsingBlock:^(NSNumber * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj integerValue] == hashValue) {
            isExit = YES;
            return;
        }
    }];
    if (isExit) {
        return;
    }
    [self.bindViewHashNumbers addObject:@(hashValue)];
}

- (void (^)(MASConstraint * _Nonnull))addBindViewContraints {
    return ^(MASConstraint *contraints) {
        if (contraints) {
            [self.bindViewConstraints addObject:contraints];
        }
    };
}

@end
