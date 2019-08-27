//
//  CombineBind.h
//  CombineObject
//
//  Created by 张行 on 2019/8/2.
//  Copyright © 2019 张行. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CombineWeakValue.h"
#import "CombineWeakView.h"

NS_ASSUME_NONNULL_BEGIN

@class CombineBindBlockContent;

@interface CombineBindBlockContent<T:id<CombineValue>> : NSObject

@property (nonatomic, strong) CombineWeakValue * value;
@property (nonatomic, strong) CombineWeakView * view;

- (void)registerCombineViewClass:(Class)viewClass
                      identifier:(NSString *)identifier
                           block:(void(^)(T value, id<CombineView> view))block;

@end

@interface CombineBind<T:id<CombineValue>> : NSObject

@property (nonatomic) T wrappedContent;
@property (nonatomic, copy) void(^contentChanged)(T content);
@property (nonatomic, copy) void(^customSetWrappedValueBlock)(CombineBindBlockContent<T> *content);
@property (nonatomic, copy) NSMutableArray<CombineWeakView *> *views;

- (instancetype)initWithContent:(id<CombineValue>)content;

@end

FOUNDATION_EXPORT CombineBind *CombineBindMaker(id<CombineValue> value);

NS_ASSUME_NONNULL_END
