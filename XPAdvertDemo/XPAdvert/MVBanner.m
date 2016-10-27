//
//  MVBanner.m
//  创新版
//
//  Created by XuPeng on 16/8/17.
//  Copyright © 2016年 cxb. All rights reserved.
//

#import "MVBanner.h"

@implementation MVBanner {
    MVADBanner *sharedAdView;
}
- (void)loadAdvert {
    if (sharedAdView) {
        [sharedAdView removeFromSuperview];
        sharedAdView                  = nil;
    }
    sharedAdView                  = [[MVADBanner alloc] initWithFrame:self.frame adspaceId:kJuXiaoBannerId andDelegate:self];
    sharedAdView.refreshAnimation = UIViewAnimationTransitionFlipFromRight;
    [self.view addSubview:sharedAdView];
    [sharedAdView loadBanner];
}
- (void)mvadBannerDidReceiveAd:(MVADBanner *)banner {
    if (self.advertLoadedSuccess) {
        self.advertLoadedSuccess();
    }
}
- (void)mvadBanner:(MVADBanner *)banner didFailToReceiveAdWithErrorDescription:(NSString *)errorDescription {
    if (self.advertLoadedFailure) {
        self.advertLoadedFailure();
    }
}
-(void)mvadBannerDidInteract:(MVADBanner *)banner withParams:(NSDictionary *)params {
    if (self.clickAdvertSuccess) {
        self.clickAdvertSuccess();
    }
}
@end
