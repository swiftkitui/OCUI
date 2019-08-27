//
//  ZHCollectionVieweaderFooter.h
//  Pods
//
//  Created by 张行 on 2018/2/6.
//
//

#import <UIKit/UIKit.h>
#import "ZHCollectionViewBaseModel.h"

/**
 * 配置UICollectionVieweaderFooterView的回调
 
 @param headerFooterView 需要设置配置的UICollectionVieweaderFooterView
 @param section 需要配置的组
 */
typedef void(^ZHCollectionViewHeaderFooterCompletionHandle)(UICollectionReusableView *headerFooterView, NSUInteger section);

typedef NS_ENUM(NSUInteger, ZHCollectionViewHeaderFooterStyle) {
    ZHCollectionViewHeaderFooterStyleHeader,
    ZHCollectionViewHeaderFooterStyleFooter
};

@interface ZHCollectionViewHeaderFooter<HeaderFooter:UICollectionReusableView *> : ZHCollectionViewBaseModel

@property (nonatomic, assign) ZHCollectionViewHeaderFooterStyle style;
@property (nonatomic, copy) CGSize(^customSizeBlock)(HeaderFooter view, NSUInteger section);

/**
 * 根据样式进行初始化ZHCollectionVieweaderFooter
 
 @param style 样式
 @return ZHCollectionVieweaderFooter
 */
- (instancetype)initWithStyle:(ZHCollectionViewHeaderFooterStyle)style;

/**
 * 执行配置UICollectionVieweaderFooterView
 
 @param headerFooter UICollectionVieweaderFooterView的泛型
 @param section 配置所在的Section
 */
- (void)setHeaderFooter:(HeaderFooter)headerFooter section:(NSUInteger)section;

/**
 * 配置Header的回调
 
 @param block 配置的Block
 */
- (void)configurationHeader:(void(^)(HeaderFooter header, NSUInteger section))block;
/**
 * 配置Footer的回调
 
 @param block 配置的Block
 */
- (void)configurationFooter:(void(^)(HeaderFooter footer, NSUInteger section))block;

@end

