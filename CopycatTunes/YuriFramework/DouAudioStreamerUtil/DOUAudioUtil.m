//
//  DOUAudioUtil.m
//  HalfTunes
//
//  Created by 武国斌 on 2017/4/14.
//  Copyright © 2017年 武国斌. All rights reserved.
//

#import "DOUAudioUtil.h"
#import "Track.h"
#import "Track+Download.h"

@interface DOUAudioUtil ()

@property (nonatomic, strong) DOUAudioStreamer *streamer;
@property (nonatomic, strong) Track *track;

@property (nonatomic, strong) NSTimer *timer;

@end

@implementation DOUAudioUtil

/*
 DOUAudioStreamerPlaying,
 DOUAudioStreamerPaused,
 DOUAudioStreamerIdle,
 DOUAudioStreamerFinished,
 DOUAudioStreamerBuffering,
 DOUAudioStreamerError
 */

- (instancetype)init {
    self = [super init];
    if (self) {
        [[self rac_valuesAndChangesForKeyPath:@"streamer.status" options:NSKeyValueObservingOptionNew observer:nil] subscribeNext:^(id x) {
            if ([[x first] integerValue] == DOUAudioStreamerFinished) {
                [self setStreamer:nil];
                if (self.finishCallBack) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self.timer invalidate];
                        self.finishCallBack(nil);
                    });
                }
            }
            
            if ([[x first] integerValue] == DOUAudioStreamerPaused) {
                if (self.playingCallBack) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                       [self.timer invalidate];
                    });
                }
            }

            if ([[x first] integerValue] == DOUAudioStreamerPlaying) {
                if (self.playingCallBack) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        _timer = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(timerFired) userInfo:nil repeats:YES];
                        [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSDefaultRunLoopMode];
                    });
                }
            }
        }];
    }
    return self;
}

- (void)timerFired {
    self.playingCallBack(self.streamer);
}

- (DOUAudioStreamer *)streamer {
    if (!_streamer) {
        _streamer = [[DOUAudioStreamer alloc] init];
    }
    return _streamer;
}

- (void)playWithTrack:(id <DOUAudioFile>)track {
    [self setTrack:(Track *)track];
    [self.streamer stop];
    [self setStreamer:nil];
    [[self.streamer initWithAudioFile:track] play];
}

- (void)play {
    [[self.streamer initWithAudioFile:self.track] play];
}

- (void)pause {
    [self.streamer pause];
}

- (void)stop {
    [self.streamer stop];
}

- (void)seek:(NSTimeInterval)timeInterval {
    [self.streamer setCurrentTime:(self.streamer.currentTime + timeInterval)];
}

- (NSString *)duration {
    NSUInteger seconds = (NSUInteger)round(self.streamer.duration);
    NSString *string = [NSString stringWithFormat:@"%02lu:%02lu:%02lu",seconds / 3600, (seconds / 60) % 60, seconds % 60];
    return string;
}

- (NSString *)currentTime {
    NSUInteger seconds = (NSUInteger)round(self.streamer.currentTime);
    NSString *string = [NSString stringWithFormat:@"%02lu:%02lu:%02lu",seconds / 3600, (seconds / 60) % 60, seconds % 60];
    return string;
}

- (NSString *)trackId {
    return [(Track *)self.streamer.audioFile trackId];
}

- (void)download {
    [self.track downloadFromServer];
}

@end
