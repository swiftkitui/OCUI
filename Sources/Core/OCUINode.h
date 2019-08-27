//
//  OCUINode.h
//  OCUI
//
//  Created by 张行 on 2019/8/22.
//  Copyright © 2019 张行. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OCUIRenderView.h"
#import "OCUIChained.h"

NS_ASSUME_NONNULL_BEGIN
@class OCUINode;

@interface OCUINode<T:OCUINode *> : NSObject<OCUIRenderView, OCUIChained>

@property (nonatomic, assign, readonly) CGFloat viewPriority;

@end

NS_ASSUME_NONNULL_END
