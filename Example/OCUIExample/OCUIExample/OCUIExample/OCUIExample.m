//
//  OCUIExample.m
//  OCUIExample
//
//  Created by 张行 on 2019/9/6.
//  Copyright © 2019 张行. All rights reserved.
//

#import "OCUIExample.h"
#import "OCUIVStackExample0.h"
#import "OCUIVStackExample1.h"
#import "OCUIVStackExample2.h"
#import "OCUIVStackExample3.h"
#import "OCUIVStackExample4.h"
#import "OCUIVStackExample5.h"

@implementation OCUIExample

+ (void)exampleWithController:(DetailViewController *)controller
                    indexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            [OCUIVStackExample0 exampleWithController:controller];
        } else if (indexPath.row == 1) {
            [OCUIVStackExample1 exampleWithController:controller];
        } else if (indexPath.row == 2) {
            [OCUIVStackExample2 exampleWithController:controller];
        } else if (indexPath.row == 3) {
            [OCUIVStackExample3 exampleWithController:controller];
        } else if (indexPath.row == 4) {
            [OCUIVStackExample4 exampleWithController:controller];
        } else if (indexPath.row == 5) {
            [OCUIVStackExample5 exampleWithController:controller];
        }
    }
}

+ (void)exampleWithController:(DetailViewController *)controller {
    NSString *name = NSStringFromClass(self);
    NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:nil];
    NSString *content = [[NSString alloc] initWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    controller.sourceCode = content;
}

@end
