//
//  Macro.h
//  Request
//
//  Created by 武国斌 on 2017/4/11.
//  Copyright © 2017年 武国斌. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Macro : NSObject

extern NSString *ISOK(BOOL key);
extern NSURL *URLWith(NSString *urlString);

extern NSString *test;
extern NSString *one;
extern NSString *two;
extern NSString *three;

#pragma mark - 通过RGB获得一个颜色
extern UIColor * getBackGoundColor(CGFloat r,CGFloat g,CGFloat b,CGFloat alpha);

#pragma mark - 验证手机号
extern bool predicateIsMobilePhone(NSString * mobilePhone);

#pragma mark - 定义机型
#define is_iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

#define is_iPhone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)

#define is_iPhone6P ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO)


#pragma mark - 定义手机系统型号
#define kOSVersion [[UIDevice currentDevice].systemVersion floatValue]

#define kOS_iOS7 (OSVersion >= 7)

#define kOS_iOS8 (OSVersion >= 8)

#define kOS_iOS9 (OSVersion >= 9)


#pragma mark - 宏定义屏幕宽度和高度
#define KScreenSize    [UIScreen mainScreen].bounds.size

#define KScreenHeight  ([[UIScreen mainScreen] bounds].size.height)

#define KScreenWidth   ([[UIScreen mainScreen] bounds].size.width)

#pragma mark - 定义打印的东西
#define DLog(fmt, ...) NSLog((@"[文件名:%s]\n" "[函数名:%s]\n" "[行号:%d] \n" fmt), __FILE__, __FUNCTION__, __LINE__, ##__VA_ARGS__);


#pragma mark - 比较大小和取绝对值
#define GETMIN(A,B)     ((A) < (B) ? (A) : (B))
#define GET(A,B)        ((A) > (B) ? (A) : (B))
#define GETABS(A)       ((A) < 0 ? (-(A)) : (A))

#define WS(weakSelf)  __weak __typeof(self)weakSelf = self

#define show(string)    if ([string isKindOfClass:[NSString class]]) { \
NSLog(@"show string: %@",string); \
}else { \
NSLog(@"no string"); \
}

#define URL(string)    [string isKindOfClass:[NSString class]] ? \
[NSURL URLWithString:string] : \
nil

@end
