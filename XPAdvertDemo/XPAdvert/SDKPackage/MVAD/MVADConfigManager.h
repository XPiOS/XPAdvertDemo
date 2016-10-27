//
//  MVADConfigManager.h
//  MVAD
//
//  Created by 唱宏博 on 15/2/27.
//  Copyright (c) 2015年 MVAD. All rights reserved.
//

#import <UIKit/UIKit.h>

#define MVAD_IMG_CACHED_NUM 40 //min 30
#define MVAD_VIDEO_CACHED_NUM 20 //min 10

@interface MVADConfigManager : NSObject

@property (nonatomic,readonly) CGFloat longitude;
@property (nonatomic,readonly) CGFloat latitude;
@property (nonatomic,readonly) BOOL    isTest;
@property (nonatomic,readonly) BOOL    isDebugMode;

+ (MVADConfigManager *)sharedMVADConfigManager;

- (void)setLongitude:(CGFloat)lng andLatitude:(CGFloat)lat;//default 0,0
//使用测试数据
- (void)setIsTestMode:(BOOL)istestmode;//default NO
//输出debug Log
- (void)setIsDebugMode:(BOOL)isdebugmode;//default NO

- (void)cleanCache;

- (NSArray *)getSDKReservedFields;

- (void)debugLog:(NSString *)debugString;
@end
