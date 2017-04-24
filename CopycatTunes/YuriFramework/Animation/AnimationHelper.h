//
//  AnimationHelper.h
//  CopycatTunes
//
//  Created by 武国斌 on 2017/4/24.
//  Copyright © 2017年 武国斌. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AnimationHelper : DBOperation

@property (nonatomic, assign) float angle;
@property (nonatomic, assign) BOOL animated;
@property (nonatomic, strong) RACDisposable *disposable;
@property (nonatomic, strong) UIView *targetView;

- (void)rotateWithTargetView:(UIView *)targetView;
- (void)stop;
- (void)clearAngle;

@end
