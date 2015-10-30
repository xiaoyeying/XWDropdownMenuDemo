//
//  XWBadgeView.m
//  XWReusableCodeLib
//
//  Created by xiao on 15/10/30.
//  Copyright © 2015年 xiao. All rights reserved.
//

#import "XWBadgeView.h"

@implementation XWBadgeView

- (void)setBadgeValue:(NSString *)badgeValue
{
    _badgeValue = [badgeValue copy];
    
    // 设置文字
    self.text = badgeValue;
    
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = self.font;
    
    // 1.计算文字的尺寸
    CGSize titleSize = [badgeValue sizeWithAttributes:attrs];
    
    // 2.计算按钮的宽度
    CGRect frame = self.frame;
    frame.size.width = titleSize.width + 5;
    self.frame = frame;
    self.textAlignment = NSTextAlignmentCenter;
    
    self.layer.cornerRadius = frame.size.width * 0.3;
    self.layer.masksToBounds = YES;
}

@end
