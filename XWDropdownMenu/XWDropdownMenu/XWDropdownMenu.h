//
//  XWDropdownMenu.h
//  XWReusableCodeLib
//
//  Created by xiao on 15/10/30.
//  Copyright © 2015年 xiao. All rights reserved.
//  下拉菜单

#import <UIKit/UIKit.h>

@class XWDropdownMenu;
#pragma mark 数据源方法
@protocol XWDropdownMenuDataSource <NSObject>
@required
/**
 *  主表格一共有多少行
 */
- (NSInteger)numberOfRowsInMainTable:(XWDropdownMenu *)dropdownMenu;
/**
 *  主表格每一行的标题
 *  @param row          行号
 */
- (NSString *)dropdownMenu:(XWDropdownMenu *)dropdownMenu titleForRowInMainTable:(NSInteger)row;
/**
 *  主表格每一行的子数据 数组
 *  @param row          行号
 */
- (NSArray *)dropdownMenu:(XWDropdownMenu *)dropdownMenu subdataForRowInMainTable:(NSInteger)row;
@optional
/**
 *  主表格每一行 分类数量
 *  @param row          行号
 */
- (NSString *)dropdownMenu:(XWDropdownMenu *)dropdownMenu countForRowInMainTable:(NSInteger)row;
/**
 *  子表格每一行子数据 分类数量
 *  @param row          行号
 */
- (NSArray *)dropdownMenu:(XWDropdownMenu *)dropdownMenu subdataCountForRowInSubTable:(NSInteger)row;
/**
 *  主表格每一行的图标
 *  @param row          行号
 */
- (NSString *)dropdownMenu:(XWDropdownMenu *)dropdownMenu iconForRowInMainTable:(NSInteger)row;
/**
 *  子表格每一行的选中图标
 *  @param row          行号
 */
- (NSString *)dropdownMenu:(XWDropdownMenu *)dropdownMenu selectedIconForRowInMainTable:(NSInteger)row;
@end

#pragma mark 代理方法
@protocol XWDropdownMenuDelegate <NSObject>

@optional
- (void)dropdownMenu:(XWDropdownMenu *)dropdownMenu didSelectRowInMainTable:(NSInteger)row;
- (void)dropdownMenu:(XWDropdownMenu *)dropdownMenu didSelectRowInSubTable:(NSInteger)subrow inMainTable:(NSInteger)mainRow;

@end

#pragma mark 构造方法
@interface XWDropdownMenu : UIView
+ (instancetype)dropdownMenu;
-(void)refreshMenu;

@property (nonatomic, weak) id<XWDropdownMenuDataSource> dataSource;
@property (nonatomic, weak) id<XWDropdownMenuDelegate> delegate;

/**主表被选中的字体颜色，默认是黑色*/
@property (strong, nonatomic) UIColor *selectedRowTextColor;
/**该属性设置成YES，主表比较小*/
@property (nonatomic, assign)BOOL isMainTableSmall;
@end
