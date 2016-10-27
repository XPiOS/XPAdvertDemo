//
//  MVADBanner.h
//  MVAD
//
//  Created by 唱宏博 on 15/3/2.
//  Copyright (c) 2015年 MVAD. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MVADBannerDelegate;

@interface MVADBanner : UIView

/**
 * 注：在使用之前，请先初始化ConfigManager，用以传入地理位置等额外信息
 * 初始化MVADBanner实例，传入adspaceiId和frame
 * @param frame CGRect ，用于确定广告大小，传入之后SDK会根据该大小请求广告，切勿再变更，以免影响广告效果
 * @param adspaceiId 广告位id，用于与投放机请求广告
 * @param delegate   banner的delegate对象，用于获取回调方法
 *
 */
- (instancetype)initWithFrame:(CGRect)frame
                    adspaceId:(NSString *)adspaceId
                  andDelegate:(id<MVADBannerDelegate>)delegate;

/**
 * 获取横幅广告
 */
- (void)loadBanner;

#pragma mark - Optional properties
/**
 * 代理对象，请正确设置，用以接受广告SDK返回的回调信息
 */
@property (nonatomic, weak) NSObject<MVADBannerDelegate> *delegate;

/**
 * 广告位id
 */
@property (nonatomic, copy) NSString *adspaceid;

/**
 * 刷新速度
 */
@property (nonatomic, readonly) NSInteger refreshInterval;
@property (nonatomic, readonly) NSInteger refreshCount;

/**
 * animation transition，用以设置刷新时，banner的切换方式
 */
@property (nonatomic,assign) UIViewAnimationTransition refreshAnimation;

/**
 * 可传入非SDK的特定参数
 * 注：SDK会有部分保留字段，如参数冲突，SDK会优先保留字段
 （保留字段列表请参考文档 或 MVADConfigManager 的getSDKReservedFields 方法）
 */
@property (nonatomic,strong) NSDictionary *additionalParameters;

/**
 * 关键词组
 */
@property (nonatomic,copy) NSArray *keywords;

@end


@protocol MVADBannerDelegate <NSObject>
@optional
#pragma mark Banner Request Notifications
/**
 * 当请求完成后，SDK确定收到广告信息，会通过该方法回调
 * 接收到此方法后，可以将广告正常展示出来
 *
 * @param banner 为MVADBanner的实例，用于展示banner广告的对象.
 */
- (void)mvadBannerDidReceiveAd:(MVADBanner *)banner;
/**
 * 当请求失败后，SDK没有收到任何广告信息，会通过该方法回调
 *
 * @param banner 为MVADBanner的实例，用于展示banner广告的对象.
 * @param errorDescription 为字符串，用于返回错误提示.
 */
- (void)mvadBanner:(MVADBanner *)banner didFailToReceiveAdWithErrorDescription:(NSString *)errorDescription;

#pragma mark Banner LandingPage
/**
 * 允许banner广告自行创建跳转落地页
 * 如果设置为NO，则SDK不会创建跳转地址，请自行打开跳转地址
 * 无论设置与否SDK都会通过以下方法返回跳转链接地址
 *  -(void)mvadBannerDidInteract:(MVADBanner *)banner withParams:(NSDictionary *)params
 *
 * 请注意，跳转地址紧密与收入相关，请正确设置
 *
 * @param banner 为MVADBanner的实例，用于展示banner广告的对象.
 */
- (BOOL)allowMvadBannerShowLandingPage:(MVADBanner *)banner;
/**
 * 返回banner广告自行创建的跳转落地页
 * 大小为当前屏幕大小
 *
 * 请注意，跳转地址紧密与收入相关，请正确渲染该View
 *
 * @param banner 为MVADBanner的实例，用于展示banner广告的对象.
 * @param landingPageView 为落地展示的UIView，用于展示广告跳转的内容.
 *
 */
- (void)mvadBanner:(MVADBanner *)banner withLandingPageView:(UIView *)landingPageView;

#pragma mark Banner Interaction Notifications
/**
 * 当banner广告有任何动作，会通过该方法返回
 * 注：当未开启广告落地页（跳转页）功能时，落地URL会通过该方法返回，请如实打开
 *
 * @param banner 为MVADBanner的实例，用于展示banner广告的对象.
 * @param params 为NSDictionary实例，内部包含当前交互动作信息
 */
-(void)mvadBannerDidInteract:(MVADBanner *)banner withParams:(NSDictionary *)params;
/**
 * 当banner广告有跳出App的行为时，会通过该方法回调通知App
 *
 * @param banner 为MVADBanner的实例，用于展示banner广告的对象.
 */
- (void)mvadBannerWillLeaveApplication:(MVADBanner *)banner;

@end
