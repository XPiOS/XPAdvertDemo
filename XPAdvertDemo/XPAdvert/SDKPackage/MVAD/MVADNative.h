//
//  MVADNative.h
//  MVAD
//
//  Created by 唱宏博 on 15/3/6.
//  Copyright (c) 2015年 MVAD. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MVADNativeDelegate;

@interface MVADNative : NSObject
/**
 * 代理对象，请正确设置，用以接受广告SDK返回的回调信息
 */
@property (nonatomic, weak) id<MVADNativeDelegate> delegate;

/**
 * 注：SDK通过结果生成native实例的方法，外部无须调用
 */
- (instancetype)initWithNativeJsonResult:(id)result
                       andLocalAdspaceid:(NSString *)localAdspaceid;

/**
 * 原生广告内容
 */
@property (nonatomic, strong) NSString *content;
/**
 * 广告位id
 */
@property (nonatomic, copy) NSString *adspaceid;
/**
 * 可传入非SDK的特定参数
 */
@property (nonatomic,strong) NSDictionary *additionalParameters;
/**
 * 关键词组
 */
@property (nonatomic,copy) NSArray *keywords;
/**
 * Native广告通过该方法来进行展示曝光
 *
 * 请注意，展示曝光与收入紧密相关，请正确调用
 *
 */
-(void)handleADOnShow;
/**
 * Native广告通过该方法来进行点击曝光
 *
 * 请注意，点击曝光与收入紧密相关，请正确调用
 *
 * @param params 传给SDK的参数.
 * @param point  当前点击发生的位置.
 */
-(void)handleADOnClick:(NSDictionary*)params andPoint:(CGPoint)point;
@end


@protocol MVADNativeDelegate <NSObject>
#pragma mark Native Interaction Notifications
/**
 * 当native广告有任何动作，会通过该方法返回
 * 注：当未开启广告落地页（跳转页）功能时，落地URL会通过该方法返回，请如实打开
 *
 * @param native 为MVADNative的实例，用于展示native广告的对象.
 * @param params 为NSDictionary实例，内部包含当前交互动作信息
 */
-(void)mvadNativeDidInteract:(MVADNative *)native withParams:(NSDictionary *)params;

/**
 * 当native广告有跳出App的行为时，会通过该方法回调通知App
 *
 * @param native 为MVADNative的实例，用于展示native广告的对象.
 */
- (void)mvadNativeWillLeaveApplication:(MVADNative *)native;

#pragma mark Native LandingPage
/**
 * 允许Native广告自行创建跳转落地页
 * 如果设置为NO，则SDK不会创建跳转地址容器，请自行打开跳转地址容器
 * 无论设置与否SDK都会通过以下方法返回跳转链接地址
 *  -(void)mvadNativeDidInteract:(MVADNative *)Native withParams:(NSDictionary *)params
 *
 * 请注意，跳转地址紧密与收入相关，请正确设置
 *
 * @param Native 当前MVADNative实例.
 */
- (BOOL)allowMvadNativeShowLandingPage:(MVADNative *)native;
/**
 * 返回Native广告自行创建的跳转落地页
 * 大小为当前屏幕大小
 *
 * 请注意，跳转地址紧密与收入相关，请正确渲染该View
 *
 * @param Native 当前MVADNative实例.
 * @param landingPageView 为落地展示的UIView，用于展示广告跳转的内容. 
 */
- (void)mvadNative:(MVADNative *)native withLandingPageView:(UIView *)landingPageView;

@end
