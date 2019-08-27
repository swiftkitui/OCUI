//
//  ZHTableViewHeaderFooter.h
//  Pods
//
//  Created by 张行 on 2017/3/18.
//
//

#import "ZHTableViewBaseModel.h"

/**
 * 配置UITableViewHeaderFooterView的回调

 @param headerFooterView 需要设置配置的UITableViewHeaderFooterView
 @param section 需要配置的组
 */
typedef void(^ZHTableViewHeaderFooterCompletionHandle)(UITableViewHeaderFooterView *headerFooterView, NSUInteger section);

typedef NS_ENUM(NSUInteger, ZHTableViewHeaderFooterStyle) {
    ZHTableViewHeaderFooterStyleHeader,
    ZHTableViewHeaderFooterStyleFooter
};

@interface ZHTableViewHeaderFooter<HeaderFooter:UITableViewHeaderFooterView *> : ZHTableViewBaseModel

@property (nonatomic, assign) ZHTableViewHeaderFooterStyle style;

@property (nonatomic, copy) CGFloat(^customHeightBlock)(HeaderFooter view, NSUInteger section);

/**
 * 根据样式进行初始化ZHTableViewHeaderFooter

 @param style 样式
 @return ZHTableViewHeaderFooter
 */
- (instancetype)initWithStyle:(ZHTableViewHeaderFooterStyle)style;

/**
 * 执行配置UITableViewHeaderFooterView

 @param headerFooter UITableViewHeaderFooterView的泛型
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
