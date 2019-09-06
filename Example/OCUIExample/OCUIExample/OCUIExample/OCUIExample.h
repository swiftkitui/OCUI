//
//  OCUIExample.h
//  OCUIExample
//
//  Created by 张行 on 2019/9/6.
//  Copyright © 2019 张行. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DetailViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface OCUIExample : NSObject

+ (void)exampleWithController:(DetailViewController *)controller
                    indexPath:(NSIndexPath *)indexPath;

+ (void)exampleWithController:(DetailViewController *)controller;

@end

NS_ASSUME_NONNULL_END
