//
//  ZHAutoConfigurationCollectionViewDelegate.h
//  Pods
//
//  Created by 张行 on 2017/4/20.
//
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, ZHCollectionViewCustomHeightType) {
    ZHCollectionViewCustomHeightTypeCell,
    ZHCollectionViewCustomHeightTypeHeader,
    ZHCollectionViewCustomHeightTypeFooter
};

@class ZHCollectionViewDataSource;

/**
 自动配置 UICollectionView 的数据源和代理
 默认实现 UICollectionView 的数据源方法和代理方法如下
 */
@interface ZHAutoConfigurationCollectionViewDelegate : NSObject <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

/**
 初始化自动配置ZHAutoConfigurationCollectionViewDelegate对象
 
 @param dataSource ZHCollectionViewDataSource
 @return ZHAutoConfigurationCollectionViewDelegate
 */
- (instancetype)initWithDataSource:(ZHCollectionViewDataSource *)dataSource;

@end

