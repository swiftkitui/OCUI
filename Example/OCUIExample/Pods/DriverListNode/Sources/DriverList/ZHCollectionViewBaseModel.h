//
//  ZHCollectionViewBaseModel.h
//  Pods
//
//  Created by 张行 on 2018/2/6.
//
//

#import <UIKit/UIKit.h>
@class ZHCollectionViewBaseModel;

typedef CGFloat (^ZHCollectionViewBaseModelCustomHeightCompletionHandle)(UICollectionView *collectionView, NSIndexPath *indexPath, ZHCollectionViewBaseModel *model);

/**
 配置 Cell Header Footer 的数据 Model
 */
@interface ZHCollectionViewBaseModel : NSObject

/**
 标识符
 */
@property (nonatomic, copy) NSString *identifier;
/**
 自定义类 Class
 */
@property (nonatomic, strong) Class anyClass;
/**
 高度 默认为 NSNotFound
 height 属性废弃 用size
 */
//@property (nonatomic, assign) CGFloat height;


/**
 * 设置 UICollectionCell UICollectionReusableView 的大小
 * 默认 CGSizeZero
 */
@property (nonatomic, assign) CGSize size;

/**
 * 自定义高度
 */
@property (nonatomic, copy) ZHCollectionViewBaseModelCustomHeightCompletionHandle customHeightCompletionHandle;

@end

