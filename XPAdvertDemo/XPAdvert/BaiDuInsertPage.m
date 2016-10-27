//
//  BaiDuInsertPage.m
//  创新版
//
//  Created by XuPeng on 16/8/23.
//  Copyright © 2016年 cxb. All rights reserved.
//

#import "BaiDuInsertPage.h"
#import "BaiduMobAdSDK/BaiduMobAdNativeAdView.h"
#import "BaiduMobAdSDK/BaiduMobAdNative.h"
#import "BaiduMobAdSDK/BaiduMobAdNativeAdObject.h"
#import "BaiduMobAdSDK/BaiduMobAdNativeVideoView.h"
#import "BaiduMobAdSDK/BaiduMobAdNativeWebView.h"

@implementation BaiDuInsertPage {
    NSMutableArray   *_impResultArr;
    NSMutableArray   *_adViewArray;
    BaiduMobAdNative *_native;
}

- (void)loadAdvert {
    if (!_impResultArr) {
        _impResultArr = [NSMutableArray array];
    }
    for (int i = 0; i < _impResultArr.count; i++) {
        for (int i = 0; i < _impResultArr.count; i++) {
            NSString *trackStatus = _impResultArr[i];
            if ([trackStatus isEqualToString:@"NO"]) {
                [self createAdView:i];
                return;
            }
        }
    }
    if (!_native) {
        _native          = [[BaiduMobAdNative alloc] init];
        _native.delegate = self;
    }
    [_native requestNativeAds];
}
- (void)createAdView:(NSInteger)index {
    BaiduMobAdNativeAdView *view = _adViewArray[index];
    [self.view addSubview:view];
    [view trackImpression];
    _impResultArr[index]         = @"YES";
}

-(NSString*)publisherId {
    return kBaiDuAppId;
}
-(NSString*)apId {
    return kBaiDuInsertId;
}
- (BaiduMobAdNativeAdView *)createNativeAdViewWithframe:(CGRect)frame object:(BaiduMobAdNativeAdObject *)object {
    UILabel *titleLabel                  = [[UILabel alloc]initWithFrame:CGRectMake(kTitleLabelX, kTitleLabelY, kTitleLabelWidth, kTitleLabelHeight)];
    titleLabel.font                      = [UIFont systemFontOfSize:14.0f];
    UILabel *textLabel                   = [[UILabel alloc]initWithFrame:CGRectMake(kTextLabelX, kTextLabelY, kTextLabelWidth, kTextLabelHeight)];
    textLabel.font                       = [UIFont systemFontOfSize:14.0f];
    UIImageView *iconImageView           = [[UIImageView alloc]initWithFrame:CGRectMake(kLogoImageViewX, kLogoImageViewY, kLogoImageViewWidth, kLogoImageViewHeight)];
    UIImageView *mainImageView           = [[UIImageView alloc]initWithFrame:CGRectMake(kContentImageViewX, kContentImageViewY, kContentImageViewWidth, kContentImageViewHeight)];
    BaiduMobAdNativeAdView *nativeAdView = nil;
    nativeAdView                         = [[BaiduMobAdNativeAdView alloc] initWithFrame:frame
                                                                               brandName:nil
                                                                                   title:titleLabel
                                                                                    text:textLabel
                                                                                    icon:iconImageView
                                                                               mainImage:mainImageView
                                                                               videoView:nil];
    nativeAdView.backgroundColor         = [UIColor whiteColor];
    return nativeAdView;
}
- (void)nativeAdObjectsSuccessLoad:(NSArray*)nativeAds{
    _adViewArray = [NSMutableArray array];
    [_impResultArr removeAllObjects];
    for(int i = 0; i < [nativeAds count]; i++){
        BaiduMobAdNativeAdObject *object = [nativeAds objectAtIndex:i];
        if ([object isExpired]) {
            continue;
        }
        BaiduMobAdNativeAdView *view = [self createNativeAdViewWithframe:self.frame object:object];
        [view loadAndDisplayNativeAdWithObject:object completion:^(NSArray *errors) {
        }];
        [_adViewArray addObject:view];
        NSString *trackStatus        = @"NO";
        [_impResultArr addObject:trackStatus];
    }
    [self createAdView:0];
    if (self.advertLoadedSuccess) {
        self.advertLoadedSuccess();
    }
}
-(void)nativeAdsFailLoad:(BaiduMobFailReason)reason {
    if (self.advertLoadedFailure) {
        self.advertLoadedFailure();
    }
}
- (void)nativeAdClicked:(BaiduMobAdNativeAdView *)nativeAdView {
    if (self.clickAdvertSuccess) {
        self.clickAdvertSuccess();
    }
}

@end
