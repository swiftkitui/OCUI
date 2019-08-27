//
//  ZHAutoConfigurationTableViewDelegate.h
//  Pods
//
//  Created by 张行 on 2017/4/20.
//
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, ZHTableViewCustomHeightType) {
    ZHTableViewCustomHeightTypeCell,
    ZHTableViewCustomHeightTypeHeader,
    ZHTableViewCustomHeightTypeFooter
};

@class ZHTableViewDataSource;

/**
 自动配置 UITableView 的数据源和代理
 默认实现 UITableView 的数据源方法和代理方法如下
 - (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
 - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
 - (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
 - (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
 - (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section;
 - (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
 - (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
 - (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
 - (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
 */
@interface ZHAutoConfigurationTableViewDelegate : NSObject <UITableViewDataSource, UITableViewDelegate>

/**
 初始化自动配置ZHAutoConfigurationTableViewDelegate对象

 @param dataSource ZHTableViewDataSource
 @return ZHAutoConfigurationTableViewDelegate
 */
- (instancetype)initWithDataSource:(ZHTableViewDataSource *)dataSource;

@end
