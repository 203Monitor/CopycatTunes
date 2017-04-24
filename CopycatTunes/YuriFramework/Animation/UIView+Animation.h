//
//  UIControl+Animation.h
//  CopycatTunes
//
//  Created by 武国斌 on 2017/4/24.
//  Copyright © 2017年 武国斌. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AnimationHelper;

@interface UIView (Animation)

@property (nonatomic, strong) AnimationHelper *animationHelper;

- (void)doRotate;
- (void)stopRotate;

@end
