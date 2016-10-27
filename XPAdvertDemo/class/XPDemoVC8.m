//
//  XPDemoVC8.m
//  XPAdvertDemo
//
//  Created by XuPeng on 16/10/26.
//  Copyright © 2016年 XP. All rights reserved.
//

#import "XPDemoVC8.h"

@interface XPDemoVC8 ()

@end

@implementation XPDemoVC8

- (void)viewDidLoad {
    [super viewDidLoad];
    UIWindow *window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    window.rootViewController = self;
    [window makeKeyWindow];
    
    self.advert = [[XPAdvert alloc] initWithView:window frame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) advertType:SplashAdvertType platformType:GDTPlatformType superVC:self];
    [self advertBlock];
    [self.advert loadAdvert];
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
