//
//  List.m
//
//  Created by   on 2017/4/15
//  Copyright (c) 2017 __MyCompanyName__. All rights reserved.
//

#import "QQList.h"
#import "QQGrp.h"

NSString *const songId = @"songId";
NSString *const songBaseURL = @"http://ws.stream.qqmusic.qq.com/songId.m4a?fromtag=46";

NSString *const albumid100 = @"albumid%100";
NSString *const albumid0 = @"albumid";
NSString *const albumCoverBaseURL = @"http://imgcache.qq.com/music/photo/album_300/albumid%100/300_albumpic_albumid_0.jpg";

NSString *const lastOne = @"lastOne";
NSString *const lastTwo = @"lastTwo";
NSString *const wholeTag = @"wholeTag";
NSString *const mid_albumCoverBaseURL = @"http://imgcache.qq.com/music/photo/mid_album_90/lastTwo/lastOne/wholeTag.jpg";

@implementation QQList

- (NSArray *)fToArray {
    if (!_fToArray) {
        _fToArray = [[self f] componentsSeparatedByString:@"|"];
    }
    return _fToArray;
}

- (NSURL *)audioURL {
    if (!_audioURL) {
        NSString *songURL = [songBaseURL stringByReplacingOccurrencesOfString:songId withString:[self.fToArray firstObject]];
        _audioURL = [NSURL URLWithString:songURL];
    }
    return _audioURL;
}

- (NSString *)artist {
    return [self fsinger];
}

- (NSString *)title {
    return [self fsong];
}

- (NSString *)trackId {
    return [self.fToArray firstObject];
}

- (NSURL *)albumCoverURL {
    if (!_albumCoverURL) {
        if (self.fToArray.count > 2) {
            NSString *albumId = [self.fToArray objectAtIndex:4];
            
            NSString *albumCoverTempURL = [albumCoverBaseURL stringByReplacingOccurrencesOfString:albumid100 withString:[NSString stringWithFormat:@"%li",([albumId integerValue] % 100)]];
            NSString *albumCoverURL = [albumCoverTempURL stringByReplacingOccurrencesOfString:albumid0 withString:albumId];
            
            _albumCoverURL = [NSURL URLWithString:albumCoverURL];
        }else {
            return nil;
        }
    }
    return _albumCoverURL;
}

- (NSURL *)mid_albumCoverURL {
    if (!_mid_albumCoverURL) {
        if (self.fToArray.count > 2) {
            NSString *mid_albumId = [self.fToArray objectAtIndex:(self.fToArray.count - 3)];
            
            NSString *mid_albumIdTemp1 = [mid_albumCoverBaseURL stringByReplacingOccurrencesOfString:lastOne withString:[mid_albumId substringFromIndex:mid_albumId.length - 1]];
            
            NSString *mid_albumIdTemp2 = [mid_albumIdTemp1 stringByReplacingOccurrencesOfString:lastTwo withString:[mid_albumId substringWithRange:NSMakeRange(mid_albumId.length - 2, 1)]];
            
            NSString *mid_albumIdTemp = [mid_albumIdTemp2 stringByReplacingOccurrencesOfString:wholeTag withString:mid_albumId];
            
            _mid_albumCoverURL = [NSURL URLWithString:mid_albumIdTemp];
        }else {
            return nil;
        }
    }
    return _mid_albumCoverURL;
}

- (Track *)getTrack {
    Track *track = [[Track alloc] init];
    
    [track setArtist:[self artist]];
    [track setTitle:[self title]];
    [track setTrackId:[self trackId]];
    [track setPreCover:[self mid_albumCoverURL]];
    [track setCover:[self albumCoverURL]];
    [track setAudioFileURL:[self audioURL]];
    
    return track;
}

@end
