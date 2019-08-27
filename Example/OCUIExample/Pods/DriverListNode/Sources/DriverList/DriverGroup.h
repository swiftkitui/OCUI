//
//  DriverGroup.h
//  ZHTableViewGroup iOS
//
//  Created by 张行 on 2019/8/8.
//  Copyright © 2019 15038777234. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DriverNode.h"

NS_ASSUME_NONNULL_BEGIN

#define MakeDriverNode ^(DriverGroup *group)

@interface DriverGroup : NSObject

@property (nonatomic, copy, readonly) NSMutableArray<DriverNode *> *groupCells;
@property (nonatomic, strong, readonly) DriverNode *groupHeader;
@property (nonatomic, strong, readonly) DriverNode *groupFooter;
@property (nonatomic, assign, readonly) UIEdgeInsets groupSectionEdgeInsets;

- (DriverNode *(^)(DriverNode *))makeHeader;
- (DriverNode *(^)(DriverNode *))makeFooter;
- (DriverNode *(^)(DriverNode *))makeCell;
- (DriverNode *(^)(UIColor *))makeSpeacer;
- (DriverGroup *(^)(UIEdgeInsets))sectionEdgeInsets;

@end

NS_ASSUME_NONNULL_END
