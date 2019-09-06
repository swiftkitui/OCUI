//
//  OCUIVStackExample4.m
//  OCUIExample
//
//  Created by 张行 on 2019/9/6.
//  Copyright © 2019 张行. All rights reserved.
//

#import "OCUIVStackExample4.h"

@implementation OCUIVStackExample4

+ (void)exampleWithController:(DetailViewController *)controller {
    [super exampleWithController:controller];
    controller.uiMaker = ^{
        View()
        .backgroundColor([UIColor redColor]);
        View()
        .backgroundColor([UIColor blueColor]);
        View()
        .backgroundColor([UIColor grayColor]);
    };
}

@end
