//
//  DriverList.h
//  DriverList
//
//  Created by 张行 on 2019/8/19.
//  Copyright © 2019 张行. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DriverGroup.h"

NS_ASSUME_NONNULL_BEGIN
@class DriverList;

#define MakeDriverGroup ^(DriverList *list)
/// 当前正在布局的DriverList
static DriverList *currentDriverList;
/// 当前正在布局的 Group
static DriverGroup *currentDriverGroup;

@interface DriverList : NSObject

@property (nonatomic, strong, readonly) NSMutableArray<DriverGroup *> *groups;

- (DriverGroup *(^)(void(^)(DriverGroup *group)))makeGroup;

@end

FOUNDATION_EXTERN DriverList *ZHDriverList(DriverList *);
FOUNDATION_EXPORT DriverGroup *ZHDriverGroup(void);
FOUNDATION_EXPORT DriverNode *ZHDriverCell(Class className, DriverBlockContent *(^block)(void));
FOUNDATION_EXPORT DriverNode *ZHDriverSpacer(UIColor *backgroundColor,DriverBlockContent *(^block)(void));
FOUNDATION_EXPORT DriverNode *ZHDriverHeader(Class className, DriverBlockContent *(^block)(void));
FOUNDATION_EXPORT DriverNode *ZHDriverFooter(Class className, DriverBlockContent *(^block)(void));


NS_ASSUME_NONNULL_END
