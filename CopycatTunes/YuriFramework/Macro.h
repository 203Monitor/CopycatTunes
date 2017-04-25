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

#pragma mark - 系统提示框
extern void showSystemAlert(NSString * title,NSString *message);

#pragma mark - 定义机型
#define is_iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

#define is_iPhone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)

#define is_iPhone6P ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO)


#pragma mark - 定义手机系统型号
#define OSVersion [[UIDevice currentDevice].systemVersion floatValue]

#define kOS_iOS7 (OSVersion >= 7)

#define kOS_iOS8 (OSVersion >= 8)

#define kOS_iOS9 (OSVersion >= 9)

#pragma mark - 宏定义屏幕宽度和高度
#define KScreenSize    [UIScreen mainScreen].bounds.size

#define KScreenHeight  ([[UIScreen mainScreen] bounds].size.height)

#define KScreenWidth   ([[UIScreen mainScreen] bounds].size.width)


#pragma mark - A better version of NSLog

#define DLog(fmt, ...) NSLog((@"\n[文件名:%s]\n" "[函数名:%s]\n" "[行号:%d] \n" fmt), __FILE__, __FUNCTION__, __LINE__, ##__VA_ARGS__);

#ifndef __OPTIMIZE__//release 判断

#define NSLog(format, ...) do {                                             \
fprintf(stderr, "<%s : %d> %s\n",                                           \
[[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String],  \
__LINE__, __func__);                                                        \
(NSLog)((format), ##__VA_ARGS__);                                           \
fprintf(stderr, "-------\n");                                               \
} while (0)

#else

# define NSLog(...) {}

#endif

#define NSLogRect(rect) NSLog(@"%s x:%.4f, y:%.4f, w:%.4f, h:%.4f", #rect, rect.origin.x, rect.origin.y, rect.size.width, rect.size.height)
#define NSLogSize(size) NSLog(@"%s w:%.4f, h:%.4f", #size, size.width, size.height)
#define NSLogPoint(point) NSLog(@"%s x:%.4f, y:%.4f", #point, point.x, point.y)

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
