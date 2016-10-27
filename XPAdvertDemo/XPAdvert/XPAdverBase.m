//
//  XPAdverBase.m
//  创新版
//
//  Created by XuPeng on 16/10/24.
//  Copyright © 2016年 cxb. All rights reserved.
//

#import "XPAdverBase.h"

@implementation XPAdverBase

- (instancetype)initWithView:(UIView *)view frame:(CGRect)frame superVC:(UIViewController *)superVC {
    self = [super init];
    if (self) {
        self.view    = view;
        self.frame   = frame;
        self.superVC = superVC;
    }
    return self;
}
- (void)loadAdvert {
    NSLog(@"XPAdverBase   loadAdvert  ");
}


@end
