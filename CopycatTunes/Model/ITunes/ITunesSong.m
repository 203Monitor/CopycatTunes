//
//  Results.m
//
//  Created by   on 2017/4/13
//  Copyright (c) 2017 __MyCompanyName__. All rights reserved.
//

#import "ITunesSong.h"

@interface ITunesSong ()

@end

@implementation ITunesSong

- (NSURL *)preview_Url {
    if (!_preview_Url) {
        if (self.previewUrl.length) {
            _preview_Url = [NSURL URLWithString:self.previewUrl];
        }else {
            return nil;
        }
    }
    return _preview_Url;
}

- (NSURL *)albumCover_Url {
    if (!_albumCover_Url) {
        if (self.artworkUrl100.length) {
            if ([self.artworkUrl100 containsString:@"100x100"]) {
                NSString *temp = self.artworkUrl100;
                
                NSString *newRate = @"500x500";
                NSString *urlString = [temp stringByReplacingOccurrencesOfString:@"100x100" withString:newRate];
                
                _albumCover_Url = [NSURL URLWithString:urlString];
            }else {
                return nil;
            }
        }else {
            return nil;
        }
    }
    return _albumCover_Url;
}

- (Track *)getTrack {
    Track *track = [[Track alloc] init];
    
    [track setArtist:[self artistName]];
    [track setTitle:[self trackName]];
    [track setTrackId:[self trackId]];
    [track setPreCover:[NSURL URLWithString:[self artworkUrl60]]];
    [track setCover:[self albumCover_Url]];
    [track setAudioFileURL:[self preview_Url]];
    
    return track;
}

@end
