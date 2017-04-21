//
//  TableViewController.m
//  HalfTunes
//
//  Created by 武国斌 on 2017/4/13.
//  Copyright © 2017年 武国斌. All rights reserved.
//

#import "SearchSongViewController.h"
#import "YuriNetwork7.h"

#import "ITunesSongList.h"

#import "SongTableViewCell.h"
#import "Track.h"
#import "PlayingViewController.h"

#import "QQModels.h"

static NSString *const SearchCell = @"SearchCell";

@interface SearchSongViewController ()

@property (nonatomic, strong) NSMutableArray *datas;
@property (nonatomic, copy) NSString *page;

@end

@implementation SearchSongViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    [self.tableView registerClass:[SongTableViewCell class] forCellReuseIdentifier:SearchCell];
    [self.tableView setTableFooterView:[UIView new]];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    WS(weakSelf);
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        weakSelf.page = [NSString stringWithFormat:@"%i",1];
        [weakSelf.datas removeAllObjects];
        [weakSelf request];
    }];
    
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [weakSelf request];
    }];
    
    _page = [NSString stringWithFormat:@"%i",1];
    [self.datas removeAllObjects];
    [self request];
}

- (void)request {
    WS(weakSelf);
    IS_SHOWHUD(YES);
    YuriNetwork7 *request = [[YuriNetwork7 alloc] init];
    NSDictionary *params = @{@"media":@"music",@"entity":self.entity,@"term":self.term};
    [request requestWithURL:API andMethod:@"POST" andParams:params andSucceed:^(NSDictionary *dictionary) {
        ITunesSongList *model = [ITunesSongList objectFromJSON:dictionary];
        [weakSelf suffexWithDatas:[model tracks]];
        
    } andFailure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

- (void)suffexWithDatas:(NSArray *)datas {
    [self.datas addObjectsFromArray:datas];
    [self.tableView reloadData];
    IS_SHOWHUD(NO);
    self.page = [NSString stringWithFormat:@"%li",[self.page integerValue] + 1];
    
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
}

- (NSMutableArray *)datas {
    if (!_datas) {
        _datas = [NSMutableArray array];
    }
    return _datas;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.datas.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [SongTableViewCell cellHeight];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SongTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SearchCell forIndexPath:indexPath];
    
    Track *track = [self.datas objectAtIndex:indexPath.row];
    [cell updateWithModel:track];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    Track *track = [self.datas objectAtIndex:indexPath.row];
    PlayingViewController *playing = [[PlayingViewController alloc] initWithModel:track];
    [self.navigationController pushViewController:playing animated:YES];
}

@end
