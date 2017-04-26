//
//  YuriMacro.h
//  CopycatTunes
//
//  Created by 武国斌 on 2017/4/26.
//  Copyright © 2017年 武国斌. All rights reserved.
//

#ifndef YuriMacro_h
#define YuriMacro_h

#define kAppDelegate ((AppDelegate *)[UIApplication sharedApplication].delegate)
#define kWindow kAppDelegate.window

#define HUD_SHOW [kWindow indicator:YES]
#define HUD_HIDE [kWindow indicator:NO]

#define IS_SHOWHUD(X) if(X) { \
HUD_SHOW; \
} else { \
HUD_HIDE; \
}

#pragma mark - 定义机型
#define is_iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

#define is_iPhone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)

#define is_iPhone6P ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO)


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

#define deallocLog(obj) do {\
NSString *className = [[obj class] description];\
NSInteger counts = ([className length] % 2 == 0) ? ([className length] / 2) : (([className length] + 1) / 2);\
NSString *minusStar = @"-*";\
for (NSInteger count = 0; count < counts + 4; count++) {\
minusStar = [minusStar stringByAppendingString:@"-*"];\
}\
minusStar = [minusStar stringByAppendingString:@"-"];\
fprintf(stderr, "%s\n\n", [minusStar UTF8String]);\
fprintf(stderr, "%s\n\n", [[className stringByAppendingString:@" dealloc"] UTF8String]);\
fprintf(stderr, "%s\n", [minusStar UTF8String]);\
fprintf(stderr, "-------\n");\
} while (0)

#else

#define NSLog(...) {}
#define deallocLog(class) {}

#endif

#define NSLogRect(rect) NSLog(@"%s x:%.4f, y:%.4f, w:%.4f, h:%.4f", #rect, rect.origin.x, rect.origin.y, rect.size.width, rect.size.height)
#define NSLogSize(size) NSLog(@"%s w:%.4f, h:%.4f", #size, size.width, size.height)
#define NSLogPoint(point) NSLog(@"%s x:%.4f, y:%.4f", #point, point.x, point.y)


#pragma mark - 比较大小和取绝对值
#define GETMIN(A,B)     ((A) < (B) ? (A) : (B))
#define GET(A,B)        ((A) > (B) ? (A) : (B))
#define GETABS(A)       ((A) < 0 ? (-(A)) : (A))

#define WS(weakSelf)  __weak __typeof(self)weakSelf = self

#define ImageNamed(name) [[UIImage imageNamed:name] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]

#define URL(string)    [string isKindOfClass:[NSString class]] ? \
[NSURL URLWithString:string] : \
nil

#endif /* YuriMacro_h */
