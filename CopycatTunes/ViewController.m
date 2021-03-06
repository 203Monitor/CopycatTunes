//
//  ViewController.m
//  HalfTunes
//
//  Created by 武国斌 on 2017/4/13.
//  Copyright © 2017年 武国斌. All rights reserved.
//

#import "ViewController.h"
#import "SearchSongViewController.h"
#import "DownloadSongViewController.h"

#import "YuriNetwork7.h"
#import "ITunesSongList.h"

@implementation UIButton (Setting)

- (void)setbuttonWithTitle:(NSString *)title {
    [self setTitle:title forState:UIControlStateNormal];
    [self setTintColor:MainColor(1)];
    [self.layer setCornerRadius:5];
    [self.layer setBorderWidth:3];
    [self.layer setBorderColor:MainColor(0.5).CGColor];
}

@end

@interface ViewController ()

@property (nonatomic, strong) UITextField *textField;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self setTitle:@"CopycatTunes"];
    [self.view setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
    
    UIView *borderVeiw = [[UIView alloc] initWithFrame:CGRectMake(20, 74, kScreenWidth - 40, 40)];
    [borderVeiw.layer setBorderColor:MainColor(0.5).CGColor];
    [borderVeiw.layer setBorderWidth:2];
    [borderVeiw.layer setCornerRadius:3];
    [self.view addSubview:borderVeiw];
    
    UITextField *searchTerm = [[UITextField alloc] initWithFrame:CGRectMake(10, 0, kScreenWidth - 50, 40)];
    [searchTerm setClearButtonMode:UITextFieldViewModeWhileEditing];
    [borderVeiw addSubview:searchTerm];
    _textField = searchTerm;
    [_textField setTextColor:MainColor(1)];
    
    [_textField setText:@"shape of you"];
    [_textField setText:@"玻璃珠"];
    
    UIButton *jump = [UIButton buttonWithType:UIButtonTypeSystem];
    [jump setbuttonWithTitle:@"search song"];
    [jump setFrame:CGRectMake(0, 134, 100, 150)];
    [jump setLeft:borderVeiw.left];
    [self.view addSubview:jump];
    WS(weakSelf);
    [jump addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
        SearchSongViewController *table = [[SearchSongViewController alloc] init];
        [table setEntity:@"song"];
        [table setTerm:weakSelf.textField.text];
        [weakSelf.navigationController pushViewController:table animated:YES];
    }];
    
    UIButton *down = [UIButton buttonWithType:UIButtonTypeSystem];
    [down setbuttonWithTitle:@"download"];
    [down setFrame:CGRectMake(0, 134, 100, 150)];
    [down setRight:borderVeiw.right];
    [self.view addSubview:down];
    [down addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
        DownloadSongViewController *dvc = [[DownloadSongViewController alloc] init];
        [weakSelf.navigationController pushViewController:dvc animated:YES];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
