//
//  Results.h
//
//  Created by   on 2017/4/13
//  Copyright (c) 2017 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Track.h"

@interface ITunesSong : CSJSONModel

@property (nonatomic, copy) NSString *artworkUrl100;
@property (nonatomic, copy) NSString *trackExplicitness;
@property (nonatomic, copy) NSString *trackTimeMillis;
@property (nonatomic, copy) NSString *collectionCensoredName;
@property (nonatomic, copy) NSString *country;
@property (nonatomic, copy) NSString *currency;
@property (nonatomic, copy) NSString *collectionPrice;
@property (nonatomic, copy) NSString *artworkUrl60;
@property (nonatomic, copy) NSString *trackViewUrl;
@property (nonatomic, copy) NSString *artworkUrl30;
@property (nonatomic, copy) NSString *collectionName;
@property (nonatomic, copy) NSString *discCount;
@property (nonatomic, copy) NSString *releaseDate;
@property (nonatomic, copy) NSString *artistViewUrl;
@property (nonatomic, copy) NSString *collectionExplicitness;
@property (nonatomic, copy) NSString *wrapperType;
@property (nonatomic, copy) NSString *trackNumber;
@property (nonatomic, assign) BOOL isStreamable;
@property (nonatomic, copy) NSString *trackId;
@property (nonatomic, copy) NSString *collectionViewUrl;
@property (nonatomic, copy) NSString *trackPrice;
@property (nonatomic, copy) NSString *artistId;
@property (nonatomic, copy) NSString *artistName;
@property (nonatomic, copy) NSString *collectionId;
@property (nonatomic, copy) NSString *previewUrl;
@property (nonatomic, copy) NSString *trackCensoredName;
@property (nonatomic, copy) NSString *discNumber;
@property (nonatomic, copy) NSString *trackName;
@property (nonatomic, copy) NSString *kind;
@property (nonatomic, copy) NSString *contentAdvisoryRating;
@property (nonatomic, copy) NSString *collectionArtistViewUrl;
@property (nonatomic, copy) NSString *collectionArtistId;
@property (nonatomic, copy) NSString *collectionArtistName;
@property (nonatomic, copy) NSString *trackCount;
@property (nonatomic, copy) NSString *primaryGenreName;

@property (nonatomic, strong) NSURL *preview_Url;
@property (nonatomic, strong) NSURL *albumCover_Url;

@property (nonatomic, assign) BOOL isNowPlaying;

- (Track *)getTrack;

@end
