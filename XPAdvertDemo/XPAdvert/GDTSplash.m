//
//  GDTSplash.m
//  创新版
//
//  Created by XuPeng on 16/8/24.
//  Copyright © 2016年 cxb. All rights reserved.
//

#import "GDTSplash.h"

@implementation GDTSplash {
    GDTSplashAd     *_splash;
    UIView          *_bottomView;
}
- (void)loadAdvert {
    _splash                     = [[GDTSplashAd alloc] initWithAppkey:kGDTAppId placementId:kGDTSplashId];
    _splash.delegate            = self;
    _splash.backgroundColor     = [UIColor whiteColor];
    _splash.fetchDelay          = 5;
    UIImageView *logo           = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"GDT开屏"]];
    _bottomView                 = [[UIView alloc] initWithFrame:CGRectMake(self.frame.origin.x, self.frame.size.height - logo.image.size.height, logo.image.size.width,logo.image.size.height)];
    [_bottomView addSubview:logo];
    _bottomView.backgroundColor = [UIColor whiteColor];
    [_splash loadAdAndShowInWindow:(UIWindow *)self.view withBottomView:_bottomView];
}
-(void)splashAdSuccessPresentScreen:(GDTSplashAd *)splashAd {
    if (self.advertLoadedSuccess) {
        self.advertLoadedSuccess();
    }
}
-(void)splashAdFailToPresent:(GDTSplashAd *)splashAd withError:(NSError *)error {
    if (self.advertLoadedFailure) {
        self.advertLoadedFailure();
    }
}
-(void)splashAdClicked:(GDTSplashAd *)splashAd {
    if (self.clickAdvertSuccess) {
        self.clickAdvertSuccess();
    }
}
@end
