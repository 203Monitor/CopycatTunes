//
//  BaseTableViewController.m
//  CopycatTunes
//
//  Created by 武国斌 on 2017/4/25.
//  Copyright © 2017年 武国斌. All rights reserved.
//

#import "BaseTableViewController.h"

@interface BaseTableViewController ()

@end

@implementation BaseTableViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    @weakify(self);
    if (self.navigationController.viewControllers.count > 1) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        [button setFrame:CGRectMake(0, 0, 50, 30)];
        [button setTitle:@"    " forState:UIControlStateNormal];
        [button setImage:ImageNamed(@"back.png") forState:UIControlStateNormal];
        [[button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            @strongify(self);
            [self.navigationController popViewControllerAnimated:YES];
        }];
        UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:button];
        
        UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                           initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                           target:nil action:nil];
        negativeSpacer.width = -(10); //减小距离,width属性为负值,加大距离,width属性为正值
        self.navigationItem.leftBarButtonItems = @[negativeSpacer,backItem];//无论左边或者右边的item,调整间距的item放在数组的第一个
    }
    
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:15],
       NSForegroundColorAttributeName:MainColor(1)
       }];
}

- (void)dealloc {
    deallocLog(self);
}

@end
