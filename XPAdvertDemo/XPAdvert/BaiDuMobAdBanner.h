//
//  BaiDuMobAdBanner.h
//  创新版
//
//  Created by XuPeng on 16/8/17.
//  Copyright © 2016年 cxb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaiduMobAdSDK/BaiduMobAdDelegateProtocol.h"
#import "XPAdverBase.h"

@interface BaiDuMobAdBanner : XPAdverBase<BaiduMobAdViewDelegate> {
    BaiduMobAdView* sharedAdView;
}


@end