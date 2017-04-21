//
//  SongTableViewCell.h
//  HalfTunes
//
//  Created by 武国斌 on 2017/4/13.
//  Copyright © 2017年 武国斌. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SongTableViewCell : UITableViewCell

@property (nonatomic, strong) DOUAudioStreamer *streamer;

- (void)updateWithModel:(id)model;
+ (NSInteger)cellHeight;

@end
