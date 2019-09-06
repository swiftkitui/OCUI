//
//  OCUIVStackExample0.m
//  OCUIExample
//
//  Created by 张行 on 2019/9/6.
//  Copyright © 2019 张行. All rights reserved.
//

#import "OCUIVStackExample0.h"

@implementation OCUIVStackExample0

+ (void)exampleWithController:(DetailViewController *)controller {
    [super exampleWithController:controller];
    controller.uiMaker = ^{
        Text(@"Hello OCUI!");
    };
}

@end
