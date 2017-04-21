//
//  SongTableViewCell.m
//  HalfTunes
//
//  Created by 武国斌 on 2017/4/13.
//  Copyright © 2017年 武国斌. All rights reserved.
//

#import "SongTableViewCell.h"
#import "Track.h"

@interface SongTableViewCell ()

@property (nonatomic, strong) UILabel *trackNameLabel;
@property (nonatomic, strong) UILabel *artistLabel;
@property (nonatomic, strong) UIImageView *avator;

@end

@implementation SongTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)updateWithModel:(id)model {
    [self.trackNameLabel setText:[model title]];
    [self.trackNameLabel sizeToFit];
    [self.trackNameLabel setWidth:KScreenWidth - 60];
    [self.trackNameLabel setTop:self.avator.top];
    
    [self.artistLabel setText:[model artist]];
    [self.artistLabel sizeToFit];
    [self.artistLabel setWidth:KScreenWidth - 60];
    [self.artistLabel setTop:self.trackNameLabel.bottom + 10];
    
    [self.avator sd_setImageWithURL:[model preCover]];
}

- (UILabel *)trackNameLabel {
    if (!_trackNameLabel) {
        _trackNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(60, 15, KScreenWidth - 60, 30)];
        [_trackNameLabel setFont:[UIFont boldSystemFontOfSize:15]];
        [self.contentView addSubview:_trackNameLabel];
    }
    return _trackNameLabel;
}

- (UILabel *)artistLabel {
    if (!_artistLabel) {
        _artistLabel = [[UILabel alloc] initWithFrame:CGRectMake(60, 45, KScreenWidth - 60, 20)];
        [_artistLabel setFont:[UIFont systemFontOfSize:11]];
        [self.contentView addSubview:_artistLabel];
    }
    return _artistLabel;
}

- (UIImageView *)avator {
    if (!_avator) {
        _avator = [[UIImageView alloc] initWithFrame:CGRectMake(5, 15, 50, 50)];
        [self.contentView addSubview:_avator];
    }
    return _avator;
}

+ (NSInteger)cellHeight {
    return 80;
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    CGFloat height = self.bounds.size.height;
    //创建贝塞尔曲线
    UIBezierPath *mPath = [UIBezierPath bezierPath];
    [mPath moveToPoint:CGPointMake(0, height)]; //创建一个点
    [mPath addLineToPoint:CGPointMake(KScreenWidth, height)]; // 加条线,从点移动到另一个点
    [mPath closePath]; // 关闭贝塞尔线
    UIColor *stroke = [UIColor blackColor];               //设置红色画笔线
    [stroke set];                                       //填充颜色
    [mPath stroke];
}

//- (void)setSelected:(BOOL)selected animated:(BOOL)animated {}
//- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated {}

@end
