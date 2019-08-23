//
//  CombineView+Category.h
//  CombineObject
//
//  Created by 张行 on 2019/8/2.
//  Copyright © 2019 张行. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CombineView.h"
#import "CombineValue+Category.h"

NS_ASSUME_NONNULL_BEGIN

@interface UIView (CombineView)<CombineView>

- (void)setOtherCombineValue:(id<CombineValue>)value identifier:(NSString *)identifier;

@end

@interface UILabel (CombineView)
@end

@interface UIProgressView (CombineView)
@end

@interface UITextField (CombineView)
@end

@interface UISlider (CombineView)
@end

@interface UISwitch (CombineView)
@end

@interface UITextView (CombineView)
@end

NS_ASSUME_NONNULL_END
