//
//  ZHCollectionViewDataSource.h
//  Pods
//
//  Created by 张行 on 2018/2/6.
//
//

#import <UIKit/UIKit.h>
#import "ZHCollectionViewGroup.h"
#import "ZHAutoConfigurationCollectionViewDelegate.h"

/**
 添加分组的回调
 
 @param group 创建的分组对象
 */
typedef void(^ZHCollectionViewDataSourceAddGroupCompletionHandle)(ZHCollectionViewGroup *group);

/**
 自定义高度的回调
 
 @return 自定义算法返回的高度
 */
typedef CGFloat (^ZHCollectionViewDataSourceCustomHeightCompletionHandle)(ZHCollectionViewBaseModel *model);

/**
 进行 UICollectionView 进行数据托管的数据源
 */
@interface ZHCollectionViewDataSource : NSObject

/**
 自动配置 UICollectionView 的 DataSource 和 Delegate 默认为 YES
 */
@property (nonatomic, assign, getter=isAutoConfigurationCollectionViewDelegate) BOOL autoConfigurationCollectionViewDelegate;

@property (nonatomic, strong, readonly) NSMutableArray<ZHCollectionViewGroup *> *groups;

/**
 唯一的初始化ZHCollectionViewDataSource
 
 @param CollectionView 托管的 UICollectionView 的对象 必须存在
 @return ZHCollectionViewDataSource的对象
 */
- (instancetype)initWithCollectionView:(UICollectionView *)CollectionView;

/**
 添加一个分组
 
 @param completionHandle 返回新注册的分组对象 可以进行配置
 */
- (void)addGroupWithCompletionHandle:(ZHCollectionViewDataSourceAddGroupCompletionHandle)completionHandle;

/**
 进行刷新 UICollectionView
 */
- (void)reloadCollectionViewData;

/**
 获取分组Cell的个数 如果autoConfigurationCollectionViewDelegate = YES 此方法不用调用
 
 @param dataSource ZHCollectionViewDataSource数据源
 @param section 所在组索引
 @return 分组 Cell 的个数
 */
+ (NSInteger)numberOfRowsInSectionWithDataSource:(ZHCollectionViewDataSource *)dataSource section:(NSInteger)section;

/**
 获取对应索引的UICollectionViewCell 如果autoConfigurationCollectionViewDelegate = YES 此方法不用调用
 
 @param dataSource ZHCollectionViewDataSource数据源
 @param indexPath 所在的索引
 @return UICollectionViewCell
 */
+ (UICollectionViewCell *)cellForRowAtWithDataSource:(ZHCollectionViewDataSource *)dataSource indexPath:(NSIndexPath *)indexPath;

/**
 获取分组的个数 如果autoConfigurationCollectionViewDelegate = YES 此方法不用调用
 
 @param dataSource ZHCollectionViewDataSource的数据源
 @return 分组的个数
 */
+ (NSInteger)numberOfSectionsWithDataSource:(ZHCollectionViewDataSource *)dataSource;

/**
 点击 Cell 的回调
 
 @param dataSource ZHCollectionViewDataSource数据源
 @param indexPath 点击的索引
 */
+ (void)didSelectRowAtWithDataSource:(ZHCollectionViewDataSource *)dataSource indexPath:(NSIndexPath *)indexPath;

/**
 获取Header
 
 @param dataSource ZHCollectionViewDataSource数据源
 @param section 分组的索引
 @return 分组 Header 试图
 */
+ (UICollectionReusableView *)viewForHeaderInSectionWithDataSource:(ZHCollectionViewDataSource *)dataSource section:(NSInteger)section;
/**
 获取Footer
 
 @param dataSource ZHCollectionViewDataSource数据源
 @param section 分组的索引
 @return 分组 Footer 试图
 */
+ (UICollectionReusableView *)viewForFooterInSectionWithDataSource:(ZHCollectionViewDataSource *)dataSource section:(NSInteger)section;

/**
 清空之前数据
 */
- (void)clearData;

+ (NSIndexPath *)indexPathWithDataSource:(ZHCollectionViewDataSource *)dataSource indexPath:(NSIndexPath *)indexPath;

+ (CGSize)sizeForItemWithDataSource:(ZHCollectionViewDataSource *)dataSource indexPath:(NSIndexPath *)indexPath;

+ (CGSize)referenceSizeForHeaderFooterWithDataSource:(ZHCollectionViewDataSource *)dataSource style:(ZHCollectionViewHeaderFooterStyle)style section:(NSUInteger)section;

@property (nonatomic, copy) void (^scrollViewDidEndDraggingWillDecelerate)(UIScrollView *scrollView, BOOL willDecelerate);
@property (nonatomic, copy) void (^scrollViewDidEndDecelerating)(UIScrollView *scrollView);
@property (nonatomic, copy) void (^scrollViewDidEndScrollingAnimation)(UIScrollView *scrollView);

@end

