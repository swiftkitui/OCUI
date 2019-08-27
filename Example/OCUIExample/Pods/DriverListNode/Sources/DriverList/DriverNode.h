//
//  DriverNode.h
//  ZHTableViewGroup iOS
//
//  Created by 张行 on 2019/8/16.
//  Copyright © 2019 15038777234. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DriverBlockContent.h"

NS_ASSUME_NONNULL_BEGIN

#define MakeDriverBlock(ClassName) [ClassName class], ^(DriverBlockContent<ClassName *> * content)

/// 驱动
@interface DriverNode : NSObject

@property (nonatomic, strong, readonly) Class anyClass;
@property (nonatomic, strong, readonly) NSString *identifier;
@property (nonatomic, assign, readonly) CGFloat cellHeight;
@property (nonatomic, assign, readonly) CGSize cellSize;
@property (nonatomic, assign, readonly) NSUInteger cellNumber;
@property (nonatomic, assign, readonly) BOOL enableCell;
@property (nonatomic, strong, readonly) DriverBlockContent *blockContent;

+ (instancetype)makeDriverAnyClass:(Class)anyClass
                             block:(void(^)(DriverBlockContent *content))block;


- (DriverNode *(^)(CGFloat))height;
- (DriverNode *(^)(NSUInteger))number;
- (DriverNode *(^)(BOOL))enable;
- (DriverNode *(^)(CGSize))size;

@end

FOUNDATION_EXPORT DriverNode *ZHDriverNode(Class anyclass, void(^block)(DriverBlockContent *content));

NS_ASSUME_NONNULL_END
