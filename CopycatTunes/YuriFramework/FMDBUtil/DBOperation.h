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
+ (Track *)queryWithTrackId:(NSString *)trackId;
+ (void)queryWithTrack:(void(^)(NSArray *obj))callback;

@end
