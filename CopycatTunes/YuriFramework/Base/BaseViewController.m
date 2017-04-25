//
//  BaseViewController.m
//  CopycatTunes
//
//  Created by 武国斌 on 2017/4/25.
//  Copyright © 2017年 武国斌. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    deallocLog(self);
}

@end
