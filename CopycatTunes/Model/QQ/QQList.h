//
//  List.h
//
//  Created by   on 2017/4/15
//  Copyright (c) 2017 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Track.h"

@interface QQList : CSJSONModel

@property (nonatomic, copy) NSString *lyric;
@property (nonatomic, copy) NSString *mv;
@property (nonatomic, strong) NSArray *grp;
@property (nonatomic, copy) NSString *singerid;
@property (nonatomic, copy) NSString *fiurl;
@property (nonatomic, copy) NSString *fsinger;
@property (nonatomic, copy) NSString *nt;
@property (nonatomic, copy) NSString *only;
@property (nonatomic, copy) NSString *f;
@property (nonatomic, copy) NSString *fsong;
@property (nonatomic, copy) NSString *singerName2Hilight;
@property (nonatomic, copy) NSString *chinesesinger;
@property (nonatomic, copy) NSString *singerNameHilight;
@property (nonatomic, copy) NSString *fsinger2;
@property (nonatomic, copy) NSString *fnote;
@property (nonatomic, copy) NSString *pubTime;
@property (nonatomic, copy) NSString *singerMID;
@property (nonatomic, copy) NSString *docid;
@property (nonatomic, copy) NSString *isweiyun;
@property (nonatomic, copy) NSString *pure;
@property (nonatomic, copy) NSString *singerid2;
@property (nonatomic, copy) NSString *t;
@property (nonatomic, copy) NSString *tag;
@property (nonatomic, copy) NSString *singerMID2;
@property (nonatomic, copy) NSString *isupload;
@property (nonatomic, copy) NSString *songNameHilight;
@property (nonatomic, copy) NSString *ver;
@property (nonatomic, copy) NSString *lyricHilight;
@property (nonatomic, copy) NSString *albumNameHilight;

@property (nonatomic, strong) NSArray *fToArray;
@property (nonatomic, strong) NSURL *audioURL;
@property (nonatomic, copy) NSString *artist;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *trackId;
@property (nonatomic, copy) NSURL *albumCoverURL;
@property (nonatomic, copy) NSURL *mid_albumCoverURL;

- (Track *)getTrack;

@end
