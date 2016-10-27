//
//  XPAdvert.h
//  创新版
//
//  Created by XuPeng on 16/10/24.
//  Copyright © 2016年 cxb. All rights reserved.
//

/**
 *  支持类库：CoreMotionFramework、MessageUI.framework、StoreKit.framework、libc++.tbd、libz.tbd
 *  Xcode6以上，请开启http功能
 *  获取广告请从新配置广告id
 */

#import <UIKit/UIKit.h>
#import "XPAdverBase.h"

@interface XPAdvert : NSObject

/**
 *  广告加载成功
 */
@property (nonatomic, copy) void (^advertLoadedSuccess)();
/**
 *   广告加载失败
 */
@property (nonatomic, copy) void (^advertLoadedFailure)();
/**
 *  广告点击成功
 */
@property (nonatomic, copy) void (^clickAdvertSuccess)();

/**
 *  初始化一个广告对象
 *
 *  @param view         目标视图
 *  @param frame        广告位置
 *  @param advertType   广告类型
 *  @param platformType 平台类型
 *
 *  @return 广告对象
 */
- (instancetype)initWithView:(UIView *)view frame:(CGRect)frame advertType:(AdvertType)advertType platformType:(PlatformType)platformType superVC:(UIViewController *)superVC;

/**
 *  加载广告
 */
- (void)loadAdvert;

@end
