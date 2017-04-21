//
//  PlayingViewController.h
//  HalfTunes
//
//  Created by 武国斌 on 2017/4/14.
//  Copyright © 2017年 武国斌. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Track;

@interface PlayingViewController : UIViewController

- (instancetype)initWithModel:(Track *)model;

@property (nonatomic, strong) NSArray *list;
@property (nonatomic, assign) NSInteger index;

@end
