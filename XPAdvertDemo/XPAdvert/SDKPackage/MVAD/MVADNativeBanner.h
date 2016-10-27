//
//  MVADNativeBanner.h
//  MVAD
//
//  Created by 唱宏博 on 15/9/6.
//  Copyright (c) 2015年 MVAD. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MVADNativeBannerDelegate;


@interface MVADNativeBanner : UIView
/**
 * 注：在使用之前，请先初始化ConfigManager，用以传入地理位置等额外信息
 * 初始化MVADNativeBanner实例，传入adspaceiId和frame
 * @param frame CGRect ，用于确定广告大小，传入之后SDK会根据该大小请求广告，切勿再变更，以免影响广告效果
 * @param adspaceiId 广告位id，用于与投放机请求广告
 * @param delegate   NativeBanner的delegate对象，用于获取回调方法
 *
 */
- (instancetype)initWithFrame:(CGRect)frame
                 andAdspaceId:(NSString *)adspaceId
                  andDelegate:(id<MVADNativeBannerDelegate>)delegate;

/**
 * 获取插屏广告
 */
- (void)loadNativeBanner;

#pragma mark - Optional properties
/**
 * 代理对象，请正确设置，用以接受广告SDK返回的回调信息
 */
@property (nonatomic, weak) NSObject<MVADNativeBannerDelegate> *delegate;

/**
 * 广告位id
 */
@property (nonatomic, copy) NSString *adspaceid;

/**
 * animation transition，用以设置刷新时，NativeBanner的切换方式
 */
@property (nonatomic,assign) UIViewAnimationTransition presentAnimation;

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


@protocol MVADNativeBannerDelegate <NSObject>
#pragma mark NativeBanner Request Notifications
/**
 * 当请求完成后，SDK确定收到广告信息，会通过该方法回调
 * 接收到此方法后，可以将广告正常展示出来
 *
 * @param NativeBanner 为MVADNativeBanner的实例，用于展示NativeBanner广告的对象.
 */
- (void)mvadNativeBannerDidReceiveAd:(MVADNativeBanner *)nativeBanner;

/**
 * 当请求失败后，SDK没有收到任何广告信息，会通过该方法回调
 *
 * @param NativeBanner 为MVADNativeBanner的实例，用于展示NativeBanner广告的对象.
 * @param errorDescription 为字符串，用于返回错误提示.
 */
- (void)mvadNativeBanner:(MVADNativeBanner *)nativeBanner didFailToReceiveAdWithErrorDescription:(NSString *)errorDescription;

#pragma mark NativeBanner LandingPage
/**
 * 允许NativeBanner广告自行创建跳转落地页
 * 如果设置为NO，则SDK不会创建跳转地址，请自行打开跳转地址
 * 无论设置与否SDK都会通过以下方法返回跳转链接地址
 *  -(void)mvadNativeBannerDidInteract:(MVADNativeBanner *)NativeBanner withParams:(NSDictionary *)params
 *
 * 请注意，跳转地址紧密与收入相关，请正确设置
 *
 * @param NativeBanner 为MVADNativeBanner的实例，用于展示NativeBanner广告的对象.
 */
- (BOOL)allowMvadNativeBannerShowLandingPage:(MVADNativeBanner *)nativeBanner;
/**
 * 返回NativeBanner广告自行创建的跳转落地页
 * 大小为当前屏幕大小
 *
 * 请注意，跳转地址紧密与收入相关，请正确渲染该View
 *
 * @param NativeBanner 为MVADNativeBanner的实例，用于展示NativeBanner广告的对象.
 * @param landingPageView 为落地展示的UIView，用于展示广告跳转的内容. 
 */
- (void)mvadNativeBanner:(MVADNativeBanner *)nativeBanner withLandingPageView:(UIView *)landingPageView;

#pragma mark NativeBanner Interaction Notifications
/**
 * 当NativeBanner广告有任何动作，会通过该方法返回
 * 注：当未开启广告落地页（跳转页）功能时，落地URL会通过该方法返回，请如实打开
 *
 * @param NativeBanner 为MVADNativeBanner的实例，用于展示NativeBanner广告的对象.
 * @param params 为NSDictionary实例，内部包含当前交互动作信息
 */
-(void)mvadNativeBannerDidInteract:(MVADNativeBanner *)nativeBanner withParams:(NSDictionary *)params;
/**
 * 当NativeBanner广告有跳出App的行为时，会通过该方法回调通知App
 *
 * @param NativeBanner 为MVADNativeBanner的实例，用于展示NativeBanner广告的对象.
 */
- (void)mvadNativeBannerWillLeaveApplication:(MVADNativeBanner *)nativeBanner;

@end
