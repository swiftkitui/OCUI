//
//  DemoCollectionController.h
//  DriverListExample
//
//  Created by 张行 on 2019/8/20.
//  Copyright © 2019 张行. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DemoCollectionController : UIViewController

@property (nonatomic, copy) void(^configCollectionViewDriver)(UICollectionView *collectionView);

@end

NS_ASSUME_NONNULL_END
