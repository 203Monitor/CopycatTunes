//
//  PlayingViewController.m
//  HalfTunes
//
//  Created by 武国斌 on 2017/4/14.
//  Copyright © 2017年 武国斌. All rights reserved.
//

#import "PlayingViewController.h"
#import "Track.h"

@interface PlayingViewController ()

@property (nonatomic, strong) Track *track;

@property (nonatomic, strong) UIImageView *albumCover;
@property (nonatomic, strong) UIButton *playprev;
@property (nonatomic, strong) UIButton *play;
@property (nonatomic, strong) UIButton *playnext;

@property (nonatomic, strong) UIProgressView *progress;
@property (nonatomic, strong) UILabel *duration;
@property (nonatomic, strong) UILabel *currentTime;

@end

@implementation PlayingViewController

- (instancetype)initWithModel:(Track *)model {
    self = [super init];
    if (self) {
        [self setTrack:model];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setTitle:[self.track title]];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    UIView *topperView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [topperView setBackgroundColor:[[UIColor grayColor] colorWithAlphaComponent:0.3]];
    [self.view addSubview:topperView];
    
    [self initUI];
    
    [self.albumCover sd_setImageWithURL:[self.track cover] placeholderImage:[UIImage imageNamed:@"default_cover_play.jpg"]];
    
    if (![self.track isNowPlaying]) {
        [kAppDelegate.audioUtil playWithTrack:self.track];
        [self.play setSelected:YES];
    }else {
        [self.play setSelected:NO];
    }
    
    WS(weakSelf);
    [kAppDelegate.audioUtil setPlayingCallBack:^(DOUAudioStreamer *obj){
        NSLog(@"%f",obj.currentTime/obj.duration);
        [weakSelf.progress setProgress:obj.currentTime/obj.duration];
        [weakSelf.duration setText:kAppDelegate.audioUtil.duration];
        [weakSelf.currentTime setText:kAppDelegate.audioUtil.currentTime];
    }];
    
    [kAppDelegate.audioUtil setFinishCallBack:^(id obj){
//        [weakSelf.play setSelected:NO];
        
        if (weakSelf.list.count) {
            if (weakSelf.index + 1 == weakSelf.list.count) {
                [weakSelf setIndex:-1];
            }
            Track *track = [weakSelf.list objectAtIndex:++weakSelf.index];
            [kAppDelegate.audioUtil playWithTrack:track];
            [weakSelf setTitle:track.title];
        }else {
            [kAppDelegate.audioUtil play];
        }
    }];
}

- (void)initUI {
    [self albumCover];
    [self play];
    [self playprev];
    [self playnext];
    [self progress];
}

- (UIImageView *)albumCover {
    if (!_albumCover) {
        _albumCover = [[UIImageView alloc] initWithFrame:CGRectMake(0, 100, kScreenWidth * 0.6, kScreenWidth * 0.6)];
        [_albumCover setCenterX:self.view.centerX];
        [self.view addSubview:_albumCover];
        
        [_albumCover setUserInteractionEnabled:YES];
        [_albumCover addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithActionBlock:^(id  _Nonnull sender) {
            [kAppDelegate.audioUtil download];
        }]];
    }
    return _albumCover;
}

- (UIButton *)play {
    if (!_play) {
        _play = [UIButton buttonWithType:UIButtonTypeSystem];
        [_play setFrame:CGRectMake(0, 0, 100, 100)];
        [_play setCenterX:self.view.centerX];
        [_play setCenterY:kScreenHeight * 0.8];
        [_play setImage:[[[UIImage imageNamed:@"btn_play"] imageByResizeToSize:CGSizeMake(100, 100)] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
        [_play setImage:[[[UIImage imageNamed:@"btn_pause"] imageByResizeToSize:CGSizeMake(100, 100)] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateSelected];
        
//        UIImage *image = [UIImage imageWithSize:CGSizeMake(100, 100) drawBlock:^(CGContextRef  _Nonnull context) {
//            CGContextSetLineWidth(context, 2);
//            CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor);
//            CGContextMoveToPoint(context, 0, 0);
//            CGContextAddLineToPoint(context, 100, 100);
//            CGContextStrokePath(context);
//        }];
//        [_play setImage:[image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateSelected];
        
        [_play setTintColor:[UIColor clearColor]];
        
        [self.view addSubview:_play];
        WS(weakSelf);
        [_play addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
            [weakSelf.play setSelected:!weakSelf.play.isSelected];
            if (weakSelf.play.isSelected) {
                [kAppDelegate.audioUtil play];
            }else {
                [kAppDelegate.audioUtil pause];
            }
        }];
    }
    return _play;
}

- (UIButton *)playprev {
    if (!_playprev) {
        _playprev = [UIButton buttonWithType:UIButtonTypeSystem];
        [_playprev setFrame:CGRectMake(0, 0, 50, 50)];
        [_playprev setCenterX:kScreenWidth / 4];
        [_playprev setCenterY:kScreenHeight * 0.8];
        [_playprev setImage:[[UIImage imageNamed:@"btn_play_prev"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
        [self.view addSubview:_playprev];
        [_playprev addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
            [kAppDelegate.audioUtil seek:(-10)];
        }];
    }
    return _playprev;
}

- (UIButton *)playnext {
    if (!_playnext) {
        _playnext = [UIButton buttonWithType:UIButtonTypeSystem];
        [_playnext setFrame:CGRectMake(0, 0, 50, 50)];
        [_playnext setCenterX:kScreenWidth / 4 * 3];
        [_playnext setCenterY:kScreenHeight * 0.8];
        [_playnext setImage:[[UIImage imageNamed:@"btn_play_next"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
        [self.view addSubview:_playnext];
        [_playnext addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
            [kAppDelegate.audioUtil seek:(10)];
        }];
    }
    return _playnext;
}

- (UIProgressView *)progress {
    if (!_progress) {
        _progress = [[UIProgressView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth / 4 * 3, 5)];
        [_progress setCenterY:self.play.centerY - 80];
        [_progress setCenterX:self.view.centerX];
        [self.view addSubview:_progress];
    }
    return _progress;
}

- (UILabel *)duration {
    if (!_duration) {
        _duration = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth / 4, 20)];
        [_duration setCenterX:kScreenWidth / 4 * 3];
        [_duration setCenterY:self.play.centerY - 50];
        [_duration setTextAlignment:NSTextAlignmentRight];
        [_duration setFont:[UIFont systemFontOfSize:10]];
        [self.view addSubview:_duration];
    }
    return _duration;
}

- (UILabel *)currentTime {
    if (!_currentTime) {
        _currentTime = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth / 4, 20)];
        [_currentTime setCenterX:kScreenWidth / 4];
        [_currentTime setCenterY:self.play.centerY - 50];
        [_currentTime setTextAlignment:NSTextAlignmentLeft];
        [_currentTime setFont:[UIFont systemFontOfSize:10]];
        [self.view addSubview:_currentTime];
    }
    return _currentTime;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
