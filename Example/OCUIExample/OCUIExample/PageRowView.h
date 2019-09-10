//
//  PageRowView.h
//  OCUIExample
//
//  Created by 张行 on 2019/9/10.
//  Copyright © 2019 张行. All rights reserved.
//

#import "OCUI.h"

NS_ASSUME_NONNULL_BEGIN

@interface PageRowView : OCUINode

@property (nonatomic, copy, readonly) NSString *title;
@property (nonatomic, copy, readonly) NSString *subTitle;

- (instancetype)initWithTitle:(NSString *)title
                     subTitle:(NSString *)subTitle;

@end

FOUNDATION_EXPORT PageRowView *PageRow(NSString *title, NSString *subTitle);

NS_ASSUME_NONNULL_END
