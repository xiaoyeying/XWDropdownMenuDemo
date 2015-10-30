//
//  XWDropdownMenuSubCell.m
//  XWReusableCodeLib
//
//  Created by xiao on 15/10/30.
//  Copyright © 2015年 xiao. All rights reserved.
//  

#import "XWDropdownMenuSubCell.h"

#define XWColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

@implementation XWDropdownMenuSubCell

- (void)awakeFromNib {
    // Initialization code
}

#pragma mark - 初始化
+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"sub";
    XWDropdownMenuSubCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[XWDropdownMenuSubCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //分割线
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 43, self.frame.size.width, 0.5)];
        lineView.backgroundColor = XWColor(235, 235, 235);
        [self.contentView addSubview:lineView];
        self.backgroundColor = XWColor(242, 242, 242);
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}


@end
