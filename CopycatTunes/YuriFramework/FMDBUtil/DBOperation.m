//
//  DBOperation.m
//  Database
//
//  Created by 武国斌 on 2017/4/20.
//  Copyright © 2017年 武国斌. All rights reserved.
//

#import "DBOperation.h"
#import "FMDB.h"
#import "Track.h"

#define TABLENAME   @"SONGS"
#define ARTIST      @"ARTIST"
#define TITLE       @"TITLE"
#define TRACKID     @"TRACKID"
#define PRECOVER    @"PRECOVER"
#define COVER       @"COVER"
#define AUDIOFILEURL @"AUDIOFILEURL"

#define DB [[DBOperation sharedDBOperation]db]

NSString *const createSQL = @"CREATE TABLE IF NOT EXISTS SONGS (ID INTEGER PRIMARY KEY AUTOINCREMENT, ARTIST TEXT, TITLE TEXT, TRACKID TEXT, PRECOVER TEXT, COVER TEXT, AUDIOFILEURL TEXT)";

NSString *const insertSQL = @"INSERT INTO SONGS (ARTIST, TITLE, TRACKID, PRECOVER, COVER, AUDIOFILEURL) VALUES ( ?, ?, ?, ?, ?, ?)";

@interface DBOperation ()

@property (nonatomic, strong) FMDatabase *db;

@end

@implementation DBOperation

+ (DBOperation *)sharedDBOperation {
    static DBOperation *sharedDBOperationInstance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedDBOperationInstance = [[self alloc] init];
    });
    return sharedDBOperationInstance;
}

+ (void)DBInit {
    if ([DB open]) {
        BOOL res = [DB executeUpdate:createSQL];
        if (!res) {
            NSLog(@"error when creating table");
        } else {
            NSLog(@"success to creating table");
        }
        [DB close];
    }
}

- (FMDatabase *)db {
    if (!_db) {
        /*
         1、当数据库文件不存在时，fmdb会自己创建一个。
         2、 如果你传入的参数是空串：@"" ，则fmdb会在临时文件目录下创建这个数据库，数据库断开连接时，数据库文件被删除。
         3、如果你传入的参数是 NULL，则它会建立一个在内存中的数据库，数据库断开连接时，数据库文件被删除。
         */
        NSString *path = [NSTemporaryDirectory() stringByAppendingPathComponent:@"songs.db"];
        _db = [FMDatabase databaseWithPath:path];
    }
    return _db;
}

+ (void)insertWithTrack:(Track *)track {
    if ([DB open]) {
        BOOL res = [DB executeUpdate:insertSQL, track.artist, track.title, track.trackId, track.preCover.description, track.cover.description, track.audioFileURL.description];
        if (!res) {
            NSLog(@"error when insert into table");
        } else {
            NSLog(@"success to insert into table");
        }
        [DB close];
    }
}

+ (void)queryTracks:(void(^)(NSArray *obj))callback {
    if ([DB open]) {
        NSMutableArray *array = [NSMutableArray array];
        
        NSString * sql = [NSString stringWithFormat:
                          @"SELECT * FROM %@",TABLENAME];
        FMResultSet * rs = [DB executeQuery:sql];
        while ([rs next]) {
            Track *track = [[Track alloc] init];
            [track setArtist:[rs stringForColumn:ARTIST]];
            [track setTitle:[rs stringForColumn:TITLE]];
            [track setTrackId:[rs stringForColumn:TRACKID]];
            [track setPreCover:[NSURL URLWithString:[rs stringForColumn:PRECOVER]]];
            [track setCover:[NSURL URLWithString:[rs stringForColumn:COVER]]];
            [track setAudioFileURL:[NSURL URLWithString:[rs stringForColumn:AUDIOFILEURL]]];
            [array addObject:track];
            
            NSLog(@"%@",[rs stringForColumn:TITLE]);
        }
        callback(array);
        [DB close];
    }
}

+ (void)queryTrackWithtrackId:(NSString *)trackId andCallback:(void(^)(BOOL isDownload))callback {
    if ([DB open]) {
        NSString * sql = [NSString stringWithFormat:
                          @"SELECT * FROM %@ where %@=%@",TABLENAME,TRACKID,trackId];
        FMResultSet * rs = [DB executeQuery:sql];
        if ([rs next]) {
            NSLog(@"%@",[rs stringForColumn:TITLE]);
            callback(YES);
        }else {
            callback(NO);
        }
        
        [DB close];
    }
}

- (void)clear {
    if ([DB open]) {
        BOOL res = [DB executeUpdate:[NSString stringWithFormat:@"DROP TABLE '%@'",TABLENAME]];
        if (!res) {
            NSLog(@"error drop db table");
        } else {
            NSLog(@"success to drop db table");
        }
        [DB close];
    }
}

@end
