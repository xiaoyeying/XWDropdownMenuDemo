//
//  XWDropdownMenu.m
//  XWReusableCodeLib
//
//  Created by xiao on 15/10/30.
//  Copyright © 2015年 xiao. All rights reserved.
//

#import "XWDropdownMenu.h"
#import "XWDropdownMenuMainCell.h"
#import "XWDropdownMenuSubCell.h"
#import "XWBadgeView.h"

#define XWColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#define XWUserDefaults [NSUserDefaults standardUserDefaults]
#define kXWLastSelectedMainRow @"XWLastSelectedMainRow"

/** 值越大，主表越小 */
#define kXWTableScale 0.15

@interface XWDropdownMenu()
@property (weak, nonatomic) IBOutlet UITableView *mainTableView;
@property (weak, nonatomic) IBOutlet UITableView *subTableView;
/** 左边主表选中的行号 */
@property (nonatomic, assign) NSInteger selectedMainRow;
/** 表格比例 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableScale;
@end

@implementation XWDropdownMenu

+ (instancetype)dropdownMenu
{
    return [[[NSBundle mainBundle] loadNibNamed:@"XWDropdownMenu" owner:nil options:nil] firstObject];
}

- (void)awakeFromNib
{
    self.subTableView.backgroundColor = XWColor(245, 245, 245);
    self.selectedMainRow = [[XWUserDefaults objectForKey:kXWLastSelectedMainRow] integerValue];
    self.selectedRowTextColor  = [UIColor blackColor];
}

#pragma mark - 数据源方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.mainTableView) {
        if ([self.dataSource respondsToSelector:@selector(numberOfRowsInMainTable:)]) {
            return [self.dataSource numberOfRowsInMainTable:self];
        }
    } else {
        if ([self.dataSource respondsToSelector:@selector(dropdownMenu:subdataForRowInMainTable:)]) {
            return [self.dataSource dropdownMenu:self subdataForRowInMainTable:self.selectedMainRow].count;
        }
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;
    //主表
    if (tableView == self.mainTableView) {
        cell = [XWDropdownMenuMainCell cellWithTableView:tableView];

        // 取出数据
        if ([self.dataSource respondsToSelector:@selector(dropdownMenu:titleForRowInMainTable:)]) {
            cell.textLabel.text = [self.dataSource dropdownMenu:self titleForRowInMainTable:indexPath.row];
            cell.textLabel.font = [UIFont systemFontOfSize:14];
            
            if (self.selectedMainRow == indexPath.row) {
                [tableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionNone];
                cell.textLabel.textColor = self.selectedRowTextColor;
            }else{
                cell.textLabel.textColor = [UIColor blackColor];
            }
        }
        
        if ([self.dataSource respondsToSelector:@selector(dropdownMenu:iconForRowInMainTable:)]) {
            cell.imageView.image = [UIImage imageNamed:[self.dataSource dropdownMenu:self iconForRowInMainTable:indexPath.row]];
        }
        
        if ([self.dataSource respondsToSelector:@selector(dropdownMenu:selectedIconForRowInMainTable:)]) {
            cell.imageView.highlightedImage = [UIImage imageNamed:[self.dataSource dropdownMenu:self selectedIconForRowInMainTable:indexPath.row]];
        }
        
        if ([self.dataSource respondsToSelector:@selector(dropdownMenu:countForRowInMainTable:)]) {
            XWBadgeView *badgeView = [[XWBadgeView alloc] initWithFrame:CGRectMake(0, 0, 0, 13)];
            badgeView.backgroundColor  = XWColor(205, 205, 205);
            badgeView.textColor = [UIColor whiteColor];
            badgeView.font = [UIFont systemFontOfSize:12];
            badgeView.badgeValue = [self.dataSource dropdownMenu:self countForRowInMainTable:indexPath.row];
            cell.accessoryView = badgeView;
        }
    } else {
        // 从表
        cell = [XWDropdownMenuSubCell cellWithTableView:tableView];
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        if ([self.dataSource respondsToSelector:@selector(dropdownMenu:subdataForRowInMainTable:)]) {
            NSArray *subdata = [self.dataSource dropdownMenu:self subdataForRowInMainTable:self.selectedMainRow];
            cell.textLabel.text = subdata[indexPath.row];
        }
        
        if ([self.dataSource respondsToSelector:@selector(dropdownMenu:subdataCountForRowInMainTable:)]) {
            XWBadgeView *badgeView = [[XWBadgeView alloc] initWithFrame:CGRectMake(0, 0, 0, 13)];
            badgeView.backgroundColor  = XWColor(205, 205, 205);
            badgeView.textColor =  [UIColor whiteColor];
            NSArray *subCount = [self.dataSource dropdownMenu:self subdataCountForRowInMainTable:self.selectedMainRow];
            badgeView.font = [UIFont systemFontOfSize:12];
            badgeView.badgeValue = subCount[indexPath.row];
            cell.accessoryView = badgeView;
        }
    }
    
    return cell;
}

#pragma mark - 代理方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.mainTableView) {
        //在这里记录一下上一次选中主表的哪一行
        [XWUserDefaults setObject:[NSString stringWithFormat:@"%ld",indexPath.row] forKey:kXWLastSelectedMainRow];
        
        self.selectedMainRow = indexPath.row;
        [self.mainTableView reloadData];
        [self.subTableView reloadData];
        
        // 通知代理
        if ([self.delegate respondsToSelector:@selector(dropdownMenu:didSelectRowInMainTable:)]) {
            [self.delegate dropdownMenu:self didSelectRowInMainTable:indexPath.row];
        }
    } else {
        // 通知代理
        if ([self.delegate respondsToSelector:@selector(dropdownMenu:didSelectRowInSubTable:inMainTable:)]) {
            [self.delegate dropdownMenu:self didSelectRowInSubTable:indexPath.row inMainTable:self.selectedMainRow];
        }
    }
}

#pragma mark 刷新整个视图 当一个控制器中有多个XWDropdownMenu
-(void)refreshMenu
{
    [self.mainTableView reloadData];
    [self.subTableView reloadData];
}

-(void)setIsMainTableSmall:(BOOL)isMainTableSmall
{
    _isMainTableSmall = isMainTableSmall;
    self.tableScale.constant = !isMainTableSmall ? : self.frame.size.width * kXWTableScale;
}
@end
