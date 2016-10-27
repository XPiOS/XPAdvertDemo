//
//  XPDemoBaseVC.m
//  XPAdvertDemo
//
//  Created by XuPeng on 16/10/26.
//  Copyright © 2016年 XP. All rights reserved.
//

#import "XPDemoBaseVC.h"

@interface XPDemoBaseVC ()

@end

@implementation XPDemoBaseVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
}

- (void)advertBlock {
    self.advert.clickAdvertSuccess = ^() {
        NSLog(@"点击了广告");
    };
    self.advert.advertLoadedSuccess = ^() {
        NSLog(@"获取广告成功");
    };
    self.advert.advertLoadedFailure = ^() {
        NSLog(@"获取广告失败");
    };
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
