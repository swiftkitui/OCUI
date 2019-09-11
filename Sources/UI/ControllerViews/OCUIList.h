//
//  OCUIList.h
//  OCUIExample
//
//  Created by 张行 on 2019/8/27.
//  Copyright © 2019 张行. All rights reserved.
//

#import "OCUIView.h"
#import "OCUICreate.h"

NS_ASSUME_NONNULL_BEGIN
@class OCUISection;
@class OCUIListStyle;
@class OCUIGroupedListStyle;

@interface OCUIList : OCUIView

@end

FOUNDATION_EXPORT OCUIList *List(OCUICreateElenmentBlock);

@interface OCUICreate (OCUIList)

- (OCUIList *(^)(OCUICreateElenmentBlock))List;

@end

@interface OCUIList (ListStyle)

@property (nonatomic, strong, readonly) OCUIListStyle *uiListStyle;

- (OCUINode *(^)(OCUIListStyle *))listStyle;

@end

@interface OCUISection : OCUINode

- (instancetype)initWithBlock:(void(^)(void))block;

@end

@interface OCUINode (OCUISectionHeader)

@property (nonatomic, strong, readonly) NSArray<OCUINode *> *headerNodes;

- (OCUINode *(^)(void(^HeaderBlock)(void)))header;

@end

FOUNDATION_EXPORT OCUISection *Section(OCUICreateElenmentBlock);

@interface OCUIListStyle : OCUINode

@end

@interface OCUIGroupedListStyle : OCUIListStyle

@end

FOUNDATION_EXPORT OCUIGroupedListStyle *GroupedListStyle(void);

NS_ASSUME_NONNULL_END
