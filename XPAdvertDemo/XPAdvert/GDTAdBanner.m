//
//  GDTAdBanner.m
//  创新版
//
//  Created by XuPeng on 16/8/18.
//  Copyright © 2016年 cxb. All rights reserved.
//

#import "GDTAdBanner.h"

@implementation GDTAdBanner  {
    GDTMobBannerView *sharedAdView;
}
- (void)dealloc {
    [sharedAdView removeFromSuperview];
    sharedAdView.delegate = nil;
    sharedAdView          = nil;
}
- (void)loadAdvert {
    if (sharedAdView.superview) {
        return;
    }
    sharedAdView                       = [[GDTMobBannerView alloc] initWithFrame:self.frame appkey:kGDTAppId placementId:kGDTBannerId];
    sharedAdView.delegate              = self;
    sharedAdView.currentViewController = self.superVC;
    sharedAdView.interval              = 10;
    sharedAdView.showCloseBtn          = NO;
    sharedAdView.isAnimationOn         = YES;
    [sharedAdView loadAdAndShow];
}
- (void)bannerViewDidReceived {
    [self.view addSubview:sharedAdView];
    if (self.advertLoadedSuccess) {
        self.advertLoadedSuccess();
    }
}
- (void)bannerViewFailToReceived:(NSError *)error {
    [sharedAdView removeFromSuperview];
    if (self.advertLoadedFailure) {
        self.advertLoadedFailure();
    }
}
- (void)bannerViewClicked {
    if (self.clickAdvertSuccess) {
        self.clickAdvertSuccess();
    }
}

@end
