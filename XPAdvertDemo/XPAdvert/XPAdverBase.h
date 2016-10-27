//
//  XPAdverBase.h
//  创新版
//
//  Created by XuPeng on 16/10/24.
//  Copyright © 2016年 cxb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XPAdvertConfig.h"

/**
 *  广告类型
 */
typedef NS_ENUM(int, AdvertType) {
    /**
     *  横幅
     */
    BannerAdvertType = 1,
    /**
     *  插屏
     */
    InsertPageAdvertType = 2,
    /**
     *  开屏
     */
    SplashAdvertType = 3,
    /**
     *  书型
     */
    BookAdvertType = 4
};

/**
 *  平台类型
 */
typedef NS_ENUM(int, PlatformType) {
    /**
     *  百度
     */
    BaiDupPlatformType = 1,
    /**
     *  聚效
     */
    JuXiaoPlatformType = 2,
    /**
     *  广点通
     */
    GDTPlatformType = 3
};

@interface XPAdverBase : NSObject

@property (nonatomic, weak  ) UIView           *view;
@property (nonatomic, assign) CGRect           frame;
@property (nonatomic, weak  ) UIViewController *superVC;

@property (nonatomic, copy  ) void (^advertLoadedSuccess)();
@property (nonatomic, copy  ) void (^advertLoadedFailure)();
@property (nonatomic, copy  ) void (^clickAdvertSuccess )();

- (instancetype)initWithView:(UIView *)view frame:(CGRect)frame superVC:(UIViewController *)superVC;

- (void)loadAdvert;

@end
