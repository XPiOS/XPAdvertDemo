//
//  BaiDuMobAdBanner.m
//  创新版
//
//  Created by XuPeng on 16/8/17.
//  Copyright © 2016年 cxb. All rights reserved.
//

#import "BaiDuMobAdBanner.h"
#import "BaiduMobAdSDK/BaiduMobAdView.h"
#import "BaiduMobAdSDK/BaiduMobAdSetting.h"

@implementation BaiDuMobAdBanner

- (void)loadAdvert {
    if (sharedAdView) {
        [sharedAdView removeFromSuperview];
        sharedAdView = nil;
    }
    sharedAdView           = [[BaiduMobAdView alloc] init];
    sharedAdView.AdUnitTag = kBaiDuBannerId;
    sharedAdView.AdType    = BaiduMobAdViewTypeBanner;
    sharedAdView.frame     = self.frame;
    sharedAdView.delegate  = self;
    [sharedAdView start];
}
- (NSString *)publisherId {
    return  kBaiDuAppId;
}
-(void)willDisplayAd:(BaiduMobAdView*) adview {
    [self.view addSubview:sharedAdView];
    if (self.advertLoadedSuccess) {
        self.advertLoadedSuccess();
    }
}
-(void)failedDisplayAd:(BaiduMobFailReason) reason {
    if (self.advertLoadedFailure) {
        self.advertLoadedFailure();
    }
}
- (void)didAdClicked {
    if (self.clickAdvertSuccess) {
        self.clickAdvertSuccess();
    }
}

@end
