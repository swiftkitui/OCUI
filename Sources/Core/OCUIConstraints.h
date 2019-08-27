//
//  OCUIConstraints.h
//  OCUIExample
//
//  Created by 张行 on 2019/8/26.
//  Copyright © 2019 张行. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CombineObjectObjc/NSObject+CombineBind.h>
#import <Masonry/Masonry.h>

NS_ASSUME_NONNULL_BEGIN

@interface OCUIConstraints : NSObject

@property (nonatomic, strong, readonly) CombineBind<NSNumber *> *valueBind;
/// 绑定的试图唯一的 Hash 值
@property (nonatomic, copy, readonly) NSMutableArray<NSNumber *> *bindViewHashNumbers;
@property (nonatomic, copy, readonly) NSMutableArray<MASConstraint *> *bindViewConstraints;
@property (nonatomic, copy) void(^contraintsValueChanged)(CGFloat value, MASConstraint *contraints);

- (instancetype)initWithValue:(CGFloat)value;
- (void)addBindViewHash:(NSUInteger)hashValue;

- (void(^)(MASConstraint *))addBindViewContraints;

@end

NS_ASSUME_NONNULL_END