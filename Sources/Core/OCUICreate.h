//
//  OCUICreate.h
//  OCUIExample
//
//  Created by 张行 on 2019/9/9.
//  Copyright © 2019 张行. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OCUINode.h"

NS_ASSUME_NONNULL_BEGIN

#define OCUICreateElenment ^(OCUICreate *c)
#define OCUICreateElenmentBlock void(^block)(OCUICreate *c)

@interface OCUICreate : NSObject

@property (nonatomic, copy, readonly) NSArray<OCUINode *> *elenments;

- (__kindof OCUINode *)addElenment:(OCUINode *)elenment;
@end

NS_ASSUME_NONNULL_END
