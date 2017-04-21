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
        [weakSelf request2];
    }];
    
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [weakSelf request2];
    }];
    
//    [self request1];
    
    _page = [NSString stringWithFormat:@"%i",1];
    [self.datas removeAllObjects];
    [self request2];
}

- (void)request1 {
    WS(weakSelf);
    IS_SHOWHUD(YES);
    YuriNetwork7 *request = [[YuriNetwork7 alloc] init];
    NSDictionary *params = @{@"media":@"music",@"entity":self.entity,@"term":self.term};
    [request requestWithURL:API andMethod:@"POST" andParams:params andSucceed:^(NSDictionary *dictionary) {
        ITunesSongList *songList = [ITunesSongList objectFromJSON:dictionary];
        
        [weakSelf.datas addObjectsFromArray:[songList tracks]];
        [weakSelf.tableView reloadData];
        IS_SHOWHUD(NO);
        
    } andFailure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

- (void)request2 {
    NSString *api = @"http://s.music.qq.com/fcgi-bin/music_search_new_platform";
    NSDictionary *params2 = @{@"t":@"0",
                              @"n":@"20",//数量
                              @"p":self.page,//分页
                              @"aggr":@"1",
                              @"cr":@"1",
                              @"loginUin":@"0",
                              @"format":@"json",
                              @"inCharset":@"GB2312",
                              @"outCharset":@"utf-8",
                              @"notice":@"0",
                              @"platform":@"jqminiframe.json",
                              @"needNewCode":@"0",
                              @"catZhida":@"0",
                              @"remoteplace":@"sizer.newclient.next_song",
                              @"w":self.term};
    //创建请求管理者
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    //内容类型
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json",@"text/javascript",@"text/html",@"application/x-javascript",@"charset=utf-8", nil];
    //post请求
    IS_SHOWHUD(YES);
    
    WS(weakSelf);
    [manager GET:api parameters:params2 progress:^(NSProgress * _Nonnull uploadProgress) {
        ;
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        QQBaseClass *model = [QQBaseClass objectFromData:responseObject];
        
        [weakSelf.datas addObjectsFromArray:[model tracks]];
        [weakSelf.tableView reloadData];
        IS_SHOWHUD(NO);
        weakSelf.page = [NSString stringWithFormat:@"%li",[weakSelf.page integerValue] + 1];
        
        [weakSelf.tableView.mj_header endRefreshing];
        [weakSelf.tableView.mj_footer endRefreshing];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
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
