//
//  PlayingViewController.m
//  HalfTunes
//
//  Created by 武国斌 on 2017/4/14.
//  Copyright © 2017年 武国斌. All rights reserved.
//

#import "PlayingViewController.h"
#import "Track.h"

#import "UIView+Animation.h"

#import "ModifyAudioVisualizer.h"

#import "Track+isPlaying.h"

@interface PlayingViewController ()

@property (nonatomic, strong) Track *track;

@property (nonatomic, strong) UIView *albumCoverView;
@property (nonatomic, strong) UIImageView *albumCover;
@property (nonatomic, strong) UIView *albumCoverCover;

@property (nonatomic, strong) UIButton *playprev;
@property (nonatomic, strong) UIButton *play;
@property (nonatomic, strong) UIButton *playnext;

@property (nonatomic, strong) UIProgressView *progress;
@property (nonatomic, strong) UILabel *duration;
@property (nonatomic, strong) UILabel *currentTime;

@property (nonatomic, strong) NSTimer *timer;

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
    
    [self timer];
    
    [self setTitle:[self.track title]];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    UIView *topperView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [topperView setBackgroundColor:[[UIColor grayColor] colorWithAlphaComponent:0.3]];
    [self.view addSubview:topperView];
    
    [self initUI];
    
    [self.albumCover sd_setImageWithURL:[self.track cover] placeholderImage:[UIImage imageNamed:@"default_cover_play.jpg"]];
    
    if (![self.track isPlaying]) {
        [kAppDelegate.audioUtil playWithTrack:self.track];
        [self.play setSelected:YES];
    }else {
        [self.play setSelected:NO];
    }
    
    if ([kAppDelegate.audioUtil isPlaying]) {
        [self.albumCover doRotate];
    }
    
    WS(weakSelf);
    [kAppDelegate.audioUtil setPlayingCallBack:^(DOUAudioStreamer *obj){
        [weakSelf.albumCover doRotate];
    }];
    
    [kAppDelegate.audioUtil setPauseCallBack:^(id obj) {
        [weakSelf.albumCover stopRotate];
    }];
    
    [kAppDelegate.audioUtil setFinishCallBack:^(id obj){
//        [weakSelf.play setSelected:NO];
        [weakSelf.albumCover stopRotate];
        if (weakSelf.list.count) {
            if (weakSelf.index + 1 == weakSelf.list.count) {
                [weakSelf setIndex:-1];
            }
            Track *track = [weakSelf.list objectAtIndex:++weakSelf.index];
            [kAppDelegate.audioUtil playWithTrack:track];
            [weakSelf setTitle:track.title];
            [weakSelf.albumCover sd_setImageWithURL:[track cover] placeholderImage:[UIImage imageNamed:@"default_cover_play.jpg"]];
        }else {
            [kAppDelegate.audioUtil play];
        }
    }];
    
    [kAppDelegate.audioUtil setDownloadingCallBack:^(float downloadPrecent) {
        float height = (1 - downloadPrecent) * self.albumCoverView.height;
        NSLog(@"%f",height);
        [weakSelf.albumCoverCover setHeight:height];
    }];
    
    [self.track hadDownloadWithBlock:^(BOOL hadDownload) {
        if (!hadDownload) {
            [weakSelf albumCoverCover];
        }
    }];
}

- (NSTimer *)timer {
    if (!_timer) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(_timerAction:) userInfo:nil repeats:YES];
    }
    return _timer;
}

- (void)initUI {
    [self albumCover];
    [self play];
    [self playprev];
    [self playnext];
    [self progress];
    
    ModifyAudioVisualizer *modifyaudioVisualizer = [[ModifyAudioVisualizer alloc] initWithFrame:CGRectMake(0.0, self.albumCover.bottom, kScreenWidth, self.progress.top - self.albumCover.bottom - 30)];
    [modifyaudioVisualizer setBackgroundColor:[UIColor clearColor]];
    
    [self.view addSubview:modifyaudioVisualizer];
}

- (UIView *)albumCoverView {
    if (!_albumCoverView) {
        _albumCoverView = [[UIView alloc] initWithFrame:CGRectMake(0, 84, kScreenWidth * 0.6, kScreenWidth * 0.6)];
        [_albumCoverView setCenterX:self.view.centerX];
        
        [_albumCoverView.layer setCornerRadius:kScreenWidth * 0.3];
        [_albumCoverView.layer setMasksToBounds:YES];
        
        [self.view addSubview:_albumCoverView];
    }
    return _albumCoverView;
}

- (UIView *)albumCoverCover {
    if (!_albumCoverCover) {
        _albumCoverCover = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.albumCoverView.width, self.albumCoverView.height)];
        [_albumCoverCover setBackgroundColor:[[UIColor blackColor] colorWithAlphaComponent:0.6]];
        [_albumCoverCover setUserInteractionEnabled:NO];
        [self.albumCoverView addSubview:_albumCoverCover];
    }
    return _albumCoverCover;
}

- (UIImageView *)albumCover {
    if (!_albumCover) {
        _albumCover = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.albumCoverView.width, self.albumCoverView.height)];
        [self.albumCoverView addSubview:_albumCover];
        
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
        [_play setCenterY:kScreenHeight - 50 - 30];
        [_play setImage:[[[UIImage imageNamed:@"btn_play.png"] imageByResizeToSize:CGSizeMake(100, 100)] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
        [_play setImage:[[[UIImage imageNamed:@"btn_pause.png"] imageByResizeToSize:CGSizeMake(100, 100)] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateSelected];
        
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
        [_playprev setCenterY:kScreenHeight - 50 - 30];
        [_playprev setImage:[[UIImage imageNamed:@"play_prev_.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
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
        [_playnext setCenterY:kScreenHeight - 50 - 30];
        [_playnext setImage:[[UIImage imageNamed:@"play_next_.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
        [self.view addSubview:_playnext];
        [_playnext addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
            [kAppDelegate.audioUtil seek:(10)];
        }];
    }
    return _playnext;
}

- (UIProgressView *)progress {
    if (!_progress) {
        _progress = [[UIProgressView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth / 4 * 3, 5)];
        [_progress setProgressTintColor:MainColor(1)];
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
        [_duration setTextColor:[UIColor brownColor]];
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
        [_currentTime setTextColor:[UIColor brownColor]];
        [self.view addSubview:_currentTime];
    }
    return _currentTime;
}

- (void)_timerAction:(id)timer {
    if (kAppDelegate.audioUtil.progress == 0.0) {
        [self.progress setProgress:0.0f];
    }else {
        [self.progress setProgress:kAppDelegate.audioUtil.progress];
        [self.duration setText:kAppDelegate.audioUtil.duration];
        [self.currentTime setText:kAppDelegate.audioUtil.currentTime];
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.timer invalidate];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
