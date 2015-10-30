//
//  ViewController.m
//  XWDropdownMenu
//
//  Created by xiao on 15/10/30.
//  Copyright © 2015年 xiao. All rights reserved.
//

#import "ViewController.h"
#import "XWDropdownMenu.h"

#define XWScreenSize [UIScreen mainScreen].bounds.size

@interface ViewController ()<XWDropdownMenuDataSource,XWDropdownMenuDelegate>
@property (nonatomic, strong)NSMutableArray *mainArray;
@property (nonatomic, strong)NSMutableArray *subArray;
@property (weak, nonatomic) XWDropdownMenu *dropdownMenu;
- (IBAction)showBtnClick:(UIButton *)sender;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self testMenu];
}

//主表数据
-(NSMutableArray *)mainArray
{
    if (!_mainArray) {
        self.mainArray = [NSMutableArray array];
        self.mainArray = [NSMutableArray arrayWithObjects:@"左边测试数据1",@"左边测试数据2",@"左边测试数据3",@"左边测试数据4",@"左边测试数据5",@"左边测试数据6",@"左边测试数据7",nil];
    }
    return _mainArray;
}

//从表数据
-(NSMutableArray *)subArray
{
    if (!_subArray) {
        self.subArray = [NSMutableArray array];
        self.subArray = [NSMutableArray arrayWithObjects:@[@"右测1",@"右侧2"],@[@"右测3",@"右侧4"],@[@"右测5",@"右侧6",@"右侧7"],@[@"右测4"],@[@"右测5"],@[@"右测6"],@[@"右测7"],nil];
    }
    return _subArray;
}

- (IBAction)showBtnClick:(UIButton *)sender {
    self.dropdownMenu.hidden = sender.selected;
    
    sender.selected = !sender.selected;
}

-(void)testMenu
{
    XWDropdownMenu *menu = [XWDropdownMenu dropdownMenu];
    self.dropdownMenu = menu;
//    menu.backgroundColor = [UIColor redColor];
    menu.hidden = YES;
    menu.frame = CGRectMake(0, 120,XWScreenSize.width, 250);
    menu.dataSource = self;
    menu.delegate = self;
    menu.selectedRowTextColor = [UIColor redColor];
    [self.view addSubview:menu];
}

//主表行数
-(NSInteger)numberOfRowsInMainTable:(XWDropdownMenu *)dropdownMenu
{
    return self.mainArray.count;
}

//主表标题
-(NSString *)dropdownMenu:(XWDropdownMenu *)dropdownMenu titleForRowInMainTable:(NSInteger)row
{
    return self.mainArray[row];
}

//子表的数据返回的是一个数组，主表每行都对应一个从表数据数组
-(NSArray *)dropdownMenu:(XWDropdownMenu *)dropdownMenu subdataForRowInMainTable:(NSInteger)row
{
    return self.subArray[row];
}

//主表行未选中图标
-(NSString *)dropdownMenu:(XWDropdownMenu *)dropdownMenu iconForRowInMainTable:(NSInteger)row
{
    return @"collect_icon";
}

//主表行选中图标
-(NSString *)dropdownMenu:(XWDropdownMenu *)dropdownMenu selectedIconForRowInMainTable:(NSInteger)row
{
    return @"collect_icon_selected";
}

//主表行的圆点提示个数
-(NSString *)dropdownMenu:(XWDropdownMenu *)dropdownMenu countForRowInMainTable:(NSInteger)row
{
    return @"10";
}

//从表行的圆点提示个数
-(NSArray *)dropdownMenu:(XWDropdownMenu *)dropdownMenu subdataCountForRowInSubTable:(NSInteger)row
{
    return [NSArray arrayWithObjects:@"1",@"2",@"3",@"4",@"5",@"6",@"7",nil];
}

//主表选中行
-(void)dropdownMenu:(XWDropdownMenu *)dropdownMenu didSelectRowInMainTable:(NSInteger)row
{
    NSLog(@"%@",self.mainArray[row]);
}

//从表选中行
-(void)dropdownMenu:(XWDropdownMenu *)dropdownMenu didSelectRowInSubTable:(NSInteger)subrow inMainTable:(NSInteger)mainRow
{
//    self.dropdownMenu.hidden = YES;
    NSLog(@"%@",self.subArray[mainRow][subrow]);
}



@end
