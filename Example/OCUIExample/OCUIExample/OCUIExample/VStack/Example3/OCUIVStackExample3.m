//
//  OCUIVStackExample3.m
//  OCUIExample
//
//  Created by 张行 on 2019/9/6.
//  Copyright © 2019 张行. All rights reserved.
//

#import "OCUIVStackExample3.h"

@implementation OCUIVStackExample3

+ (void)exampleWithController:(DetailViewController *)controller {
    [super exampleWithController:controller];
    controller.uiMaker = ^{
        View()
        .backgroundColor([UIColor redColor]);
    };
}

@end
