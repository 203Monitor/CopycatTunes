//
//  UIControl+Animation.m
//  CopycatTunes
//
//  Created by 武国斌 on 2017/4/24.
//  Copyright © 2017年 武国斌. All rights reserved.
//

#import "UIView+Animation.h"
#import <objc/runtime.h>
#import "AnimationHelper.h"

static char *Animation_Helper = "Animation_Helper";

@implementation UIView (Animation)

- (AnimationHelper *)animationHelper {
    AnimationHelper *animationHelper = objc_getAssociatedObject(self, Animation_Helper);
    if (!animationHelper) {
        animationHelper = [AnimationHelper new];
        [self setAnimationHelper:animationHelper];
    }
    return animationHelper;
}

- (void)setAnimationHelper:(AnimationHelper *)animationHelper {
    objc_setAssociatedObject(self, Animation_Helper, animationHelper, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)doRotate {
    [self.animationHelper rotateWithTargetView:self];
}

- (void)stopRotate {
    [self.animationHelper stop];
}

@end
