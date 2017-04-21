//
//  Macro.m
//  Request
//
//  Created by 武国斌 on 2017/4/11.
//  Copyright © 2017年 武国斌. All rights reserved.
//

#import "Macro.h"

inline NSString *ISOK(BOOL key) {
    if (key) {
        return @"OK";
    }
    return @"NOT";
}

inline NSURL *URLWith(NSString *urlString) {
    if ([urlString isKindOfClass:[NSString class]]) {
        return [NSURL URLWithString:urlString];
    }else {
        return nil;
    }
}

inline UIColor * getBackGoundColor(CGFloat r,CGFloat g,CGFloat b,CGFloat alpha) {
    return [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:alpha];
}

inline bool predicateIsMobilePhone(NSString * mobilePhone) {
    NSString * validateContent = @"1[3|5|7|8|4|][0-9]{9}";
    NSPredicate *validateTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", validateContent];
    return [validateTest evaluateWithObject:mobilePhone];
}

//NSString *const test = @"http://s3.sinaimg.cn/mw690/001IkOa7gy6Jcn918EG22&690";

NSString *test = @"http://s3.sinaimg.cn/mw690/001IkOa7gy6Jcn918EG22&690";

NSString *one = @"https://ss2.baidu.com/6ONYsjip0QIZ8tyhnq/it/u=1896490631,3490114893&fm=58";
NSString *two = @"https://ss2.baidu.com/6ONYsjip0QIZ8tyhnq/it/u=1918496855,3585400881&fm=58";
NSString *three = @"https://ss2.baidu.com/6ONYsjip0QIZ8tyhnq/it/u=2034371867,3642617881&fm=58";


