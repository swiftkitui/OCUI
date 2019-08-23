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

@class CombineBindBlockContent;

@interface CombineBindBlockContent : NSObject

@property (nonatomic, strong) CombineWeakValue * _Nullable value;
@property (nonatomic, strong) CombineWeakView * _Nullable view;
@property (nonatomic, copy) NSString * _Nullable identifier;

- (void)registerWrappedValue:(Class _Nullable )valueClass
                   viewClass:(Class _Nullable )viewClass
                  identifier:(NSString *_Nullable)identifier
                       block:(void(^_Nullable)(id<CombineValue> _Nullable value, id<CombineView> _Nullable view))block;

@end


NS_ASSUME_NONNULL_BEGIN

@interface CombineBind : NSObject

@property (nonatomic, weak) id<CombineValue> content;
@property (nonatomic, copy) void(^contentChanged)(id<CombineValue> content);
@property (nonatomic, copy) void(^customSetWrappedValueBlock)(CombineBindBlockContent *content);
@property (nonatomic, copy) NSMutableArray<CombineWeakView *> *views;

@end

NS_ASSUME_NONNULL_END
