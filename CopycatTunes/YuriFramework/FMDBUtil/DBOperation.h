//
//  DBOperation.h
//  Database
//
//  Created by 武国斌 on 2017/4/20.
//  Copyright © 2017年 武国斌. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Track;

@interface DBOperation : NSObject

+ (void)DBInit;
+ (void)insertWithTrack:(Track *)track;
+ (void)queryTracks:(void(^)(NSArray *obj))callback;
+ (void)queryTrackWithtrackId:(NSString *)trackId andCallback:(void(^)(BOOL isDownload))callback;

@end
