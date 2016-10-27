//
//  MVADNativeLoader.h
//  MVAD
//
//  Created by 唱宏博 on 15/3/9.
//  Copyright (c) 2015年 MVAD. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol MVADNativeLoaderDelegate;

@interface MVADNativeLoader : NSObject


@property (atomic, strong) NSString* adspaceid;
/**
 * 代理对象，请正确设置，用以接受广告SDK返回的回调信息
 */
@property (nonatomic, weak) id<MVADNativeLoaderDelegate> delegate;

/**
 * 注：在使用之前，请先初始化ConfigManager，用以传入地理位置等额外信息
 * 初始化MVADNativeLoader实例，传入adspaceiId和delegate
 * @param adspaceiId 广告位id，用于与投放机请求广告
 * @param delegate   MVADNativeLoader的delegate对象，用于获取回调方法
 *
 */
-(instancetype)initWithadspaceId:(NSString*)adspaceId
                     andDelegate:(id<MVADNativeLoaderDelegate>)delegate;
/**
 * NativeLoader用于获取native广告的方法
 */
-(void)loadNativeAds;

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
/**
 * 获取到的native广告数组
 */
@property (nonatomic,strong) NSArray *nativeADs;
@end


@protocol MVADNativeLoaderDelegate <NSObject>
/**
 * 当请求完成后，SDK确定收到广告信息，会通过该方法回调
 * 接收到此方法后，可以将广告正常展示出来
 *
 * @param natives 为MVADNative的实例，用于展示native广告的对象.
 */
- (void)mvadNativeDidReceiveAds:(NSArray *)natives;

/**
 * 当请求失败后，SDK没有收到任何广告信息，会通过该方法回调
 *
 * @param nativeLoader 为MVADNativeLoader的实例，用于获取native广告信息
 * @param errorDescription 为字符串，用于返回错误提示.
 */
-(void)mvadNativeLoader:(MVADNativeLoader *)nativeLoader didFailToReceiveAdWithErrorDescription:(NSString *)errorDescription;
@end

