//
//  RootViewController.m
//  XPAdvertDemo
//
//  Created by XuPeng on 16/10/26.
//  Copyright © 2016年 XP. All rights reserved.
//

#import "RootViewController.h"

NSString *const demo1Description = @"banner百度广告    XPDemoVC1";
NSString *const demo2Description = @"banner广点通广告  XPDemoVC2";
NSString *const demo3Description = @"banner聚效广告    XPDemoVC3";
NSString *const demo4Description = @"insert百度广告     XPDemoVC4";
NSString *const demo5Description = @"insert广点通广告   XPDemoVC5";
NSString *const demo6Description = @"insert聚效广告     XPDemoVC6";
NSString *const demo7Description = @"splash百度广告     XPDemoVC7";
NSString *const demo8Description = @"splash广点通广告   XPDemoVC8";
NSString *const demo9Description = @"book广点通广告     XPDemoVC9";

@interface RootViewController ()

@property (nonatomic, strong) NSArray *dataArray;

@end

@implementation RootViewController

- (NSArray *)dataArray {
    if (!_dataArray) {
        _dataArray = @[demo1Description, demo2Description, demo3Description, demo4Description, demo5Description,demo6Description,demo7Description,demo8Description,demo9Description];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navigationController.navigationBar setTranslucent:NO];//设置navigationbar的半透明
    self.title = @"XPAdverDemo";//设置navigationbar上显示的标题
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"test";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.textLabel.text = self.dataArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *demoClassString = [NSString stringWithFormat:@"XPDemoVC%ld", indexPath.row + 1];
    UIViewController *vc = [NSClassFromString(demoClassString) new];
    vc.title = demoClassString;
    [self.navigationController pushViewController:vc animated:YES];
}



@end
