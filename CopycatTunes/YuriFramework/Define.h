//
//  Define.h
//  Request
//
//  Created by 武国斌 on 2017/4/9.
//  Copyright © 2017年 武国斌. All rights reserved.
//

#ifndef Define_h
#define Define_h

#pragma mark - self

#define POSTREQUEST @"POST"
#define GETREQUEST @"GET"
#define FOLDER @"/files"
#define IDENTIFIER @"IDENTIFIER"

#define kAUTOLAYOUTSCALE ([UIScreen mainScreen].bounds.size.width / 375.0)
#define SCALE(X) (kAUTOLAYOUTSCALE * X)

#define kAppDelegate ((AppDelegate *)[UIApplication sharedApplication].delegate)
#define kWindow kAppDelegate.window

#define HUD_SHOW [kWindow indicator:YES]
#define HUD_HIDE [kWindow indicator:NO]

#define IS_SHOWHUD(X) if(X) { \
HUD_SHOW; \
} else { \
HUD_HIDE; \
}

#define MUSICCACHEROOT [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject]

typedef void(^CallBack)(id obj);

//NSString * const fileFolder = @"/files";

#endif /* Define_h */
