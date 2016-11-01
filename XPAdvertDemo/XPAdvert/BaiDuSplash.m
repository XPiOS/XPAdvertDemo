//
//  BaiDuSplash.m
//  创新版
//
//  Created by XuPeng on 16/8/24.
//  Copyright © 2016年 cxb. All rights reserved.
//

#import "BaiDuSplash.h"

@implementation BaiDuSplash {
    BaiduMobAdSplash    *_splash;
    UIView              *_splashBackgroundView;
    UIView              *_splashView;
    UIButton            *_skipButton;
    NSTimer             *_timer;
}
- (void)loadAdvert {
    _splashBackgroundView                 = [[UIView alloc] initWithFrame:self.frame];
    _splashBackgroundView.backgroundColor = [UIColor whiteColor];
    UIImage *image                        = [UIImage imageNamed:@"GDT开屏"];
    UIImageView *imageView                = [[UIImageView alloc] initWithImage:image];
    imageView.frame                       = CGRectMake(0, self.frame.size.height - image.size.height, image.size.width, image.size.height);
    [_splashBackgroundView addSubview:imageView];
    [self.view addSubview:_splashBackgroundView];
    
    _splash                               = [[BaiduMobAdSplash alloc] init];
    _splash.delegate                      = self;
    _splash.AdUnitTag                     = kBaiDuSplashId;
    _splash.canSplashClick                = YES;
    _splashView                           = [[UIView alloc] initWithFrame:CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, self.frame.size.height - image.size.height)];
    [_splash loadAndDisplayUsingContainerView:_splashView];
    [_splashBackgroundView addSubview:_splashView];
    _skipButton                           = [UIButton buttonWithType:0];
    _skipButton.frame                     = CGRectMake(self.frame.size.width - 80.0f, 20, 60, 32);
    _skipButton.backgroundColor           = [UIColor colorWithWhite:0.000 alpha:0.5];
    [_skipButton setTitle:@"跳过" forState:UIControlStateNormal];
    [_skipButton setTitleColor:[UIColor colorWithWhite:1.000 alpha:0.500] forState:UIControlStateNormal];
    [_skipButton addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    _skipButton.layer.cornerRadius        = 5.0f;
    _skipButton.layer.masksToBounds       = YES;
    [_splashView addSubview:_skipButton];
    _timer                                = [NSTimer scheduledTimerWithTimeInterval:4.0f target:self selector:@selector(buttonClick) userInfo:nil repeats:NO];
}
- (void)buttonClick {
    [_timer invalidate];
    [UIView animateWithDuration:0.7 animations:^{
        _splashBackgroundView.transform = CGAffineTransformScale(_splashBackgroundView.transform, 2.0f, 2.0f);
        _splashBackgroundView.alpha     = 0.0f;
    } completion:^(BOOL finished) {
        [_splashBackgroundView removeFromSuperview];
    }];
}
- (NSString *)publisherId {
    return kBaiDuAppId;
}
- (void)splashDidClicked:(BaiduMobAdSplash *)splash {
    if (self.clickAdvertSuccess) {
        self.clickAdvertSuccess();
    }
}
- (void)splashDidDismissScreen:(BaiduMobAdSplash *)splash {
    [self buttonClick];
}
- (void)splashSuccessPresentScreen:(BaiduMobAdSplash *)splash {
    if (self.advertLoadedSuccess) {
        self.advertLoadedSuccess();
    }
}
- (void)splashlFailPresentScreen:(BaiduMobAdSplash *)splash withError:(BaiduMobFailReason)reason {
    [self buttonClick];
    if (self.advertLoadedFailure) {
        self.advertLoadedFailure();
    }
}
@end
