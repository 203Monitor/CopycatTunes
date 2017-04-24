//
//  DownloadViewController.m
//  HalfTunes
//
//  Created by 武国斌 on 2017/4/19.
//  Copyright © 2017年 武国斌. All rights reserved.
//

#import "DownloadSongViewController.h"

#import "Track.h"
#import "SongTableViewCell.h"
#import "PlayingViewController.h"

static NSString *const LocalCell = @"LocalCell";

@interface DownloadSongViewController ()

@property (nonatomic, strong) NSMutableArray<Track *> *datas;

@end

@implementation DownloadSongViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.tableView registerClass:[SongTableViewCell class] forCellReuseIdentifier:@"LocalCell"];
    [self.tableView setTableFooterView:[UIView new]];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSURL *folderURL = [NSURL fileURLWithPath:MUSICCACHEROOT];
    NSArray *folderContents = [fileManager
                               contentsOfDirectoryAtURL:folderURL
                               includingPropertiesForKeys:nil
                               options:0
                               error:nil];
    
    [self.datas removeAllObjects];
    
    IS_SHOWHUD(YES);
    WS(weakSelf);
    [DBOperation queryWithTrack:^(NSArray *obj) {
        for (Track *track in obj) {
            for (NSURL *path in folderContents) {
//        NSDictionary *dict = [fileManager attributesOfItemAtPath:[path path] error:nil];
//        NSLog(@"%@",dict);
                NSArray *paths = [[path path] componentsSeparatedByString:@"/"];
                NSString *trackId = [[[paths lastObject] componentsSeparatedByString:@"."] firstObject];
                if ([track.trackId isEqualToString:trackId]) {
                    [track setAudioFileURL:path];
                }
            }
        }
        [weakSelf.datas addObjectsFromArray:obj];
        [weakSelf.tableView reloadData];
        IS_SHOWHUD(NO);
    }];
    
}

- (NSMutableArray *)datas {
    if (!_datas) {
        _datas = [NSMutableArray array];
    }
    return _datas;
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.datas.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [SongTableViewCell cellHeight];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SongTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:LocalCell forIndexPath:indexPath];
    
    Track *track = [self.datas objectAtIndex:indexPath.row];
    [cell updateWithModel:track];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    Track *track = [self.datas objectAtIndex:indexPath.row];
    PlayingViewController *playing = [[PlayingViewController alloc] initWithModel:track];
    [playing setList:self.datas];
    [playing setIndex:indexPath.row];
    
    [self.navigationController pushViewController:playing animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
