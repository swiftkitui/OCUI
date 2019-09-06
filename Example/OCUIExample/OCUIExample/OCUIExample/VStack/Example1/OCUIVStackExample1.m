//
//  OCUIVStackExample1.m
//  OCUIExample
//
//  Created by 张行 on 2019/9/6.
//  Copyright © 2019 张行. All rights reserved.
//

#import "OCUIVStackExample1.h"

@implementation OCUIVStackExample1

+ (void)exampleWithController:(DetailViewController *)controller {
    [super exampleWithController:controller];
    controller.uiMaker = ^{
        Text(@"Hello");
        Text(@"OCUI!");
    };
}

@end
