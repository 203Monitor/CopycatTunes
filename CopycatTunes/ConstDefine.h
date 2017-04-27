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

#define SEARCHAPI @"http://tohostinger.tk/request.php"

#define POSTREQUEST @"POST"
#define GETREQUEST @"GET"
#define FOLDER @"/files"
#define IDENTIFIER @"IDENTIFIER"

#define kAUTOLAYOUTSCALE ([UIScreen mainScreen].bounds.size.width / 375.0)
#define SCALE(X) (kAUTOLAYOUTSCALE * X)

typedef void(^CallBack)(id obj);

//NSString * const fileFolder = @"/files";

#endif /* Define_h */
