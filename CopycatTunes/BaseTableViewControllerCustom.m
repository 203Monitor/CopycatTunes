//
//  BaseTableViewControllerCustom.m
//  CopycatTunes
//
//  Created by 武国斌 on 2017/4/27.
//  Copyright © 2017年 武国斌. All rights reserved.
//

#import "BaseTableViewControllerCustom.h"

@interface BaseTableViewControllerCustom ()

@end

@implementation BaseTableViewControllerCustom

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:15],
       NSForegroundColorAttributeName:MainColor(1)
       }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
