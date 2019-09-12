//
//  OCUINode.h
//  OCUI
//
//  Created by 张行 on 2019/8/22.
//  Copyright © 2019 张行. All rights reserved.
//

#import "OCUIHeader.h"

NS_ASSUME_NONNULL_BEGIN
@class OCUINode;
@class OCUICreate;

FOUNDATION_EXPORT id OCUINodeGetProperty(OCUINode *node, SEL sel);
FOUNDATION_EXPORT void OCUINodeSetProperty(OCUINode *node, SEL sel, id property);
FOUNDATION_EXPORT UIViewController *OCUIControllerWithView(UIView *view);

@interface OCUINode : NSObject

@property (nonatomic, copy, readonly) NSArray<OCUINode *> *elenments;
- (void)updateElenments:(NSArray<OCUINode *> *)elenments;

@end

//####################(Init)####################
@interface OCUINode (Init)

- (instancetype)initWithElenmentsBlock:(void(^)(OCUICreate *c))block;


@end

//####################(Property)####################
@interface OCUINode (Property)

- (id(^)(SEL))propertyGet;
- (void(^)(id,SEL))propertySet;

@end

//####################(Load)####################
@interface OCUINode (Load)

- (void)loadElenmentInContentView:(UIView *)contentView;

@end

//####################(Frame)####################
@interface OCUINode (Frame)

@property (nonatomic, assign, readonly) CGSize uiSize;
- (OCUINode *(^)(CGSize))size;

@end

NS_ASSUME_NONNULL_END
