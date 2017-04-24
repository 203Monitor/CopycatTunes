//
//  AnimationHelper.m
//  CopycatTunes
//
//  Created by 武国斌 on 2017/4/24.
//  Copyright © 2017年 武国斌. All rights reserved.
//

#import "AnimationHelper.h"

@implementation AnimationHelper

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.angle = 0;
        self.disposable = nil;
        self.targetView = nil;
        self.animated = NO;
    }
    return self;
}

- (void)rotateWithTargetView:(UIView *)targetView {
    if (!self.animated) {
        WS(weakSelf);
        self.disposable = [[RACSignal interval:0.01 onScheduler:[RACScheduler mainThreadScheduler]] subscribeNext:^(id x) {
            weakSelf.angle = weakSelf.angle + 0.01;//angle角度 double angle;
            if (weakSelf.angle > M_PI * 2) {//大于 M_PI*2(360度) 角度再次从0开始
                weakSelf.angle = 0;
            }
            targetView.transform = CGAffineTransformMakeRotation(weakSelf.angle);
        }];
        [self setAnimated:YES];
        [self setTargetView:targetView];
        NSLog(@"new disposable %@",self.disposable);
    }
}

- (void)stop {
    [self.disposable dispose];
    NSLog(@"delete disposable %@",self.disposable);
    self.targetView.transform = CGAffineTransformMakeRotation(self.angle);
    [self setAnimated:NO];
}

- (void)clearAngle {
    self.angle = 0;
}

@end
