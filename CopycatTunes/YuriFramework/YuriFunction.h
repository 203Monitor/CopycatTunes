//
//  Macro.h
//  Request
//
//  Created by 武国斌 on 2017/4/11.
//  Copyright © 2017年 武国斌. All rights reserved.
//

#import "YuriMacro.h"

#pragma mark - 测试图片
extern NSString *test;
extern NSString *one;
extern NSString *two;
extern NSString *three;

#pragma mark - 简易NSString转换NSURL
extern NSURL *URLWith(NSString *urlString);

#pragma mark - 通过RGB获得一个颜色
extern UIColor * getColor(CGFloat r,CGFloat g,CGFloat b,CGFloat alpha);

#pragma mark - 验证手机号
extern bool predicateIsMobilePhone(NSString * mobilePhone);

#pragma mark - 系统提示框
extern void showSystemAlert(NSString * title,NSString *message);
