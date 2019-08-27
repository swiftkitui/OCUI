//
//  UICollectionView+ZHCollectionViewDataSource.h
//  DriverList
//
//  Created by 张行 on 2019/8/20.
//  Copyright © 2019 张行. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZHCollectionViewDataSource.h"
#import "DriverDataSource.h"

NS_ASSUME_NONNULL_BEGIN

@interface UICollectionView (ZHCollectionViewDataSource)<DriverDataSource>

@property (nonatomic, strong, readonly) ZHCollectionViewDataSource *collectionDataSource;

@end

NS_ASSUME_NONNULL_END
