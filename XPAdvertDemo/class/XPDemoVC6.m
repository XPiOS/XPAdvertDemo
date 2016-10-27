//
//  XPDemoVC6.m
//  XPAdvertDemo
//
//  Created by XuPeng on 16/10/26.
//  Copyright © 2016年 XP. All rights reserved.
//

#import "XPDemoVC6.h"

@interface XPDemoVC6 ()

@end

@implementation XPDemoVC6

- (void)viewDidLoad {
    [super viewDidLoad];
    self.advert = [[XPAdvert alloc] initWithView:self.view frame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height / 2) advertType:InsertPageAdvertType platformType:JuXiaoPlatformType superVC:self];
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
