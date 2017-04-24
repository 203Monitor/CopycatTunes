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
    
    WS(weakSelf);
    if (self) {
        [[self rac_valuesAndChangesForKeyPath:@"streamer.status" options:NSKeyValueObservingOptionNew observer:nil] subscribeNext:^(id x) {
            NSInteger status = [[x first] integerValue];
            switch (status) {
                case DOUAudioStreamerPlaying:
                    NSLog(@"player stated : playing");
//                    [_buttonPlayPause setTitle:@"Pause" forState:UIControlStateNormal];
                    if (weakSelf.playingCallBack) {
                        dispatch_async(dispatch_get_main_queue(), ^{
                            self.playingCallBack(self.streamer);
                        });
                    }
                    
                    break;
                    
                case DOUAudioStreamerPaused:
                    NSLog(@"player stated : paused");
//                    [_buttonPlayPause setTitle:@"Play" forState:UIControlStateNormal];
                    if (self.pauseCallBack) {
                        dispatch_async(dispatch_get_main_queue(), ^{
                            self.pauseCallBack(nil);
                        });
                    }
                    
                    break;
                    
                case DOUAudioStreamerIdle:
                    NSLog(@"player stated : idle");
//                    [_buttonPlayPause setTitle:@"Play" forState:UIControlStateNormal];
                    
                    break;
                    
                case DOUAudioStreamerFinished:
                    NSLog(@"player stated : finished");
//                    [self _actionNext:nil];
                    if (weakSelf.finishCallBack) {
                        dispatch_async(dispatch_get_main_queue(), ^{
                            self.finishCallBack(self.streamer);
                        });
                    }
                    
                    break;
                    
                case DOUAudioStreamerBuffering:
                    NSLog(@"player stated : buffering");
                    
                    break;
                    
                case DOUAudioStreamerError:
                    NSLog(@"player stated : error");
                    
                    break;
            }
        }];
    }
    return self;
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

- (BOOL)isPlaying {
    return self.streamer.status == DOUAudioStreamerPlaying;
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

- (double)progress {
    if (self.streamer.duration) {
        return self.streamer.currentTime/self.streamer.duration;
    }else {
        return 0.0f;
    }
}

- (NSString *)trackId {
    return [(Track *)self.streamer.audioFile trackId];
}

- (void)download {
    [self.track downloadFromServer];
}

@end
