//
//  XPDemoBaseVC.h
//  XPAdvertDemo
//
//  Created by XuPeng on 16/10/26.
//  Copyright © 2016年 XP. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XPAdvert.h"

@interface XPDemoBaseVC : UIViewController

@property (nonatomic, strong) XPAdvert *advert;

- (void)advertBlock;

@end
