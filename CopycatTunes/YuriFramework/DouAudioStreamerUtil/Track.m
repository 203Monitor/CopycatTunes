//
//  Track.m
//  HalfTunes
//
//  Created by 武国斌 on 2017/4/13.
//  Copyright © 2017年 武国斌. All rights reserved.
//

#import "Track.h"

#import "ITunesSong.h"

@implementation NSString (KOREA)

- (BOOL)isKorea {
    if ([self hasPrefix:@"&#"]) {
        return YES;
    }
    return NO;
}

- (NSArray *)seprateKorea {
    return [self componentsSeparatedByString:@"&#"];
}

- (NSString *)getReal {
    if ([self isKorea]) {
        
        NSString *koreaString = @"";
        
        for (NSString *korea in [self seprateKorea]) {
            if (korea.length) {
                NSString *hexString = [NSString stringWithFormat:@"%@",[[NSString alloc] initWithFormat:@"%1x",[korea intValue]]];
                
                NSString *unicode = [NSString stringWithFormat:@"\\u%@",hexString];
                
                NSString *tempStr1 = [unicode stringByReplacingOccurrencesOfString:@"\\u" withString:@"\\U"];
                NSString *tempStr2 = [tempStr1 stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""];
                NSString *tempStr3 = [[@"\"" stringByAppendingString:tempStr2] stringByAppendingString:@"\""];
                NSData *tempData = [tempStr3 dataUsingEncoding:NSUTF8StringEncoding];
                
                NSString *returnStr = [NSPropertyListSerialization propertyListWithData:tempData options:NSPropertyListImmutable format:NULL error:NULL];

                koreaString = [koreaString stringByAppendingString:returnStr];
            }else {
                continue;
            }
        }
        return koreaString;
    }else {
        return self;
    }
}

@end

@implementation Track

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setArtist:@""];
        [self setTitle:@""];
        [self setTrackId:@""];
        [self setPreCover:nil];
        [self setCover:nil];
        [self setAudioFileURL:nil];
    }
    return self;
}

- (BOOL)isNowPlaying {
    return [[kAppDelegate.audioUtil trackId] isEqualToString:self.trackId];
}

- (NSString *)title {
    return [_title getReal];
}

- (NSString *)artist {
    return [_artist getReal];
}

@end
