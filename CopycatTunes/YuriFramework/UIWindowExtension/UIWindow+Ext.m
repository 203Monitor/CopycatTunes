//
//  UIWindow+Ext.m
//  Request
//
//  Created by 武国斌 on 2017/4/11.
//  Copyright © 2017年 武国斌. All rights reserved.
//

#import "UIWindow+Ext.h"
#import <objc/runtime.h>

@implementation UIWindow (Ext)

static char *Key_Indicator = "Key_Indicator";
static char *Key_TopView = "Key_TopView";

- (void)WindowInit {
    UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    [indicator setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleGray];
    [indicator setCenter:self.center];
    [indicator setHidesWhenStopped:YES];
    [indicator stopAnimating];
    [self addSubview:indicator];
    
    UIView *topView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [topView setBackgroundColor:[[UIColor blackColor] colorWithAlphaComponent:0.3]];
    [topView setHidden:YES];
    [self addSubview:topView];
    
    [self setIndicator:indicator];
    [self setTopView:topView];
}

- (UIActivityIndicatorView *)indicator {
    return objc_getAssociatedObject(self, Key_Indicator);
}

- (void)setIndicator:(UIActivityIndicatorView *)indicator {
    objc_setAssociatedObject(self, Key_Indicator, indicator, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIView *)topView {
    return objc_getAssociatedObject(self, Key_TopView);
}

- (void)setTopView:(UIView *)topView {
    objc_setAssociatedObject(self, Key_TopView, topView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)indicator:(BOOL)show {
    [self bringSubviewToFront:self.topView];
    [self bringSubviewToFront:self.indicator];
    if (show) {
        [self.indicator startAnimating];
        [self.topView setHidden:NO];
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    }else {
        [self.indicator stopAnimating];
        [self.topView setHidden:YES];
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    }
}

@end
