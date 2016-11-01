//
//  XPAdvert.m
//  创新版
//
//  Created by XuPeng on 16/10/24.
//  Copyright © 2016年 cxb. All rights reserved.
//

#import "XPAdvert.h"
#import "BaiDuMobAdBanner.h"
#import "MVBanner.h"
#import "GDTAdBanner.h"
#import "GDTBookType.h"
#import "BaiDuSplash.h"
#import "GDTSplash.h"
#import "BaiDuInsertPage.h"
#import "GDTInsertPage.h"
#import "MVInsertPage.h"

@implementation XPAdvert {
    UIView           *_view;
    CGRect           _frame;
    UIViewController *_superVC;
    AdvertType       _advertType;
    PlatformType     _platformType;
    XPAdverBase      *_advertManager;
}

- (instancetype)initWithView:(UIView *)view frame:(CGRect)frame advertType:(AdvertType)advertType platformType:(PlatformType)platformType superVC:(UIViewController *)superVC {
    self = [super init];
    if (self) {
        _view         = view;
        _frame        = frame;
        _advertType   = advertType;
        _platformType = platformType;
        _superVC      = superVC;
    }
    return self;
}

- (void)loadAdvert {
    if (_advertManager) {
        [_advertManager loadAdvert];
        return;
    }
    switch (_advertType) {
        case BannerAdvertType: {
            _advertManager = [self addBannerAdvert];
            break;
        }
        case InsertPageAdvertType: {
            _advertManager = [self addInsertPageAdvert];
            break;
        }
        case SplashAdvertType: {
            _advertManager = [self addSplashAdvert];
            break;
        }
        case BookAdvertType: {
            _advertManager = [self addBookAdvert];
            break;
        }
        default:
            NSLog(@"该平台类型广告暂缺");
            break;
    }
    if (_advertManager) {
        _advertManager.advertLoadedSuccess = self.advertLoadedSuccess;
        _advertManager.advertLoadedFailure = self.advertLoadedFailure;
        _advertManager.clickAdvertSuccess  = self.clickAdvertSuccess;
        [_advertManager loadAdvert];
    }
}

- (XPAdverBase *)addBannerAdvert {
    XPAdverBase *adverBase;
    switch (_platformType) {
        case BaiDupPlatformType: {
            adverBase = [[BaiDuMobAdBanner alloc] initWithView:_view frame:_frame superVC:_superVC];
            break;
        }
        case JuXiaoPlatformType: {
            adverBase = [[MVBanner alloc] initWithView:_view frame:_frame superVC:_superVC];
            break;
        }
        case GDTPlatformType: {
            adverBase = [[GDTAdBanner alloc] initWithView:_view frame:_frame superVC:_superVC];
            break;
        }
        default:
            NSLog(@"该平台类型广告暂缺");
            break;
    }
    return adverBase;
}

- (XPAdverBase *)addBookAdvert {
    XPAdverBase *adverBase;
    switch (_platformType) {
        case BaiDupPlatformType: {
            NSLog(@"该平台类型广告暂缺");
            break;
        }
        case JuXiaoPlatformType: {
            NSLog(@"该平台类型广告暂缺");
            break;
        }
        case GDTPlatformType: {
            adverBase = [[GDTBookType alloc] initWithView:_view frame:_frame superVC:_superVC];
            break;
        }
        default:
            NSLog(@"该平台类型广告暂缺");
            break;
    }
    return adverBase;
}

- (XPAdverBase *)addSplashAdvert {
    XPAdverBase *adverBase;
    switch (_platformType) {
        case BaiDupPlatformType: {
            adverBase = [[BaiDuSplash alloc] initWithView:_view frame:_frame superVC:_superVC];
            break;
        }
        case JuXiaoPlatformType: {
            NSLog(@"该平台类型广告暂缺");
            break;
        }
        case GDTPlatformType: {
            adverBase = [[GDTSplash alloc] initWithView:_view frame:_frame superVC:_superVC];
            break;
        }
        default:
            NSLog(@"该平台类型广告暂缺");
            break;
    }
    return adverBase;
}

- (XPAdverBase *)addInsertPageAdvert {
    XPAdverBase *adverBase;
    switch (_platformType) {
        case BaiDupPlatformType: {
            adverBase = [[BaiDuInsertPage alloc] initWithView:_view frame:_frame superVC:_superVC];
            break;
        }
        case JuXiaoPlatformType: {
            adverBase = [[MVInsertPage alloc] initWithView:_view frame:_frame superVC:_superVC];
            break;
        }
        case GDTPlatformType: {
            adverBase = [[GDTInsertPage alloc] initWithView:_view frame:_frame superVC:_superVC];
            break;
        }
        default:
            break;
    }
    return adverBase;
}
@end
