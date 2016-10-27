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
- (void)loadAdvert {
    if (sharedAdView) {
        [sharedAdView removeFromSuperview];
        sharedAdView = nil;
    }
    sharedAdView                       = [[GDTMobBannerView alloc] initWithFrame:self.frame
                                                                          appkey:kGDTAppId
                                                                     placementId:kGDTBannerId];
    sharedAdView.delegate              = self;
    sharedAdView.currentViewController = self.superVC;
    sharedAdView.interval              = 10;
    sharedAdView.showCloseBtn          = NO;
    sharedAdView.isAnimationOn         = YES;
    [self.view addSubview:sharedAdView];
    [sharedAdView loadAdAndShow];
}
- (void)bannerViewDidReceived {
    if (self.advertLoadedSuccess) {
        self.advertLoadedSuccess();
    }
}
- (void)bannerViewFailToReceived:(NSError *)error {
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
