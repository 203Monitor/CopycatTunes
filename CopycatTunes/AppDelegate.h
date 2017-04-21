//
//  AppDelegate.h
//  HalfTunes
//
//  Created by 武国斌 on 2017/4/13.
//  Copyright © 2017年 武国斌. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DOUAudioUtil.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, strong) DOUAudioUtil *audioUtil;

@end

