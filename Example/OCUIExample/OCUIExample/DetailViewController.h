//
//  DetailViewController.h
//  OCUIExample
//
//  Created by 张行 on 2019/9/6.
//  Copyright © 2019 张行. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OCUI.h"

NS_ASSUME_NONNULL_BEGIN

@interface DetailViewController : UIViewController

@property (nonatomic, copy) void(^uiMaker)(void);
@property (nonatomic, copy) NSString *sourceCode;

@end

NS_ASSUME_NONNULL_END
