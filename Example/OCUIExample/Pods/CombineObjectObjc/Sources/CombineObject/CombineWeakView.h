//
//  CombineWeakView.h
//  CombineObjectObjc
//
//  Created by 张行 on 2019/8/6.
//

#import <Foundation/Foundation.h>
#import "CombineView.h"

NS_ASSUME_NONNULL_BEGIN

@interface CombineWeakView : NSObject

@property (nonatomic, weak) id<CombineView> view;
@property (nonatomic, copy) NSString *identifier;

@end

NS_ASSUME_NONNULL_END
