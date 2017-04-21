//
//  Download.h
//  HalfTunes
//
//  Created by 武国斌 on 2017/4/18.
//  Copyright © 2017年 武国斌. All rights reserved.
//

#import "Track.h"

@interface Track (Download)

- (void)downloadFromServer;
- (void)removeLocalDocument;

@end
