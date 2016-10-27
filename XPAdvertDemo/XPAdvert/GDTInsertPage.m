//
//  GDTInsertPage.m
//  创新版
//
//  Created by XuPeng on 16/8/23.
//  Copyright © 2016年 cxb. All rights reserved.
//

#import "GDTInsertPage.h"

@implementation GDTInsertPage {
    GDTNativeAd     *_nativeAd;
    NSMutableArray  *_cacheAdArr;
    NSMutableArray  *_impResultArr;
    UIView          *_insertView;
    GDTNativeAdData *_currentAdData;
}
- (void)loadAdvert {
    if (!_impResultArr) {
        _impResultArr = [NSMutableArray array];
    }
    for (int i = 0; i < _impResultArr.count; i++) {
        NSString *trackStatus = _impResultArr[i];
        if ([trackStatus isEqualToString:@"NO"]) {
            [self createInsertView:i];
            return;
        }
    }
    if (!_nativeAd) {
        _nativeAd            = [[GDTNativeAd alloc] initWithAppkey:kGDTAppId placementId:kGDTInsertId];
        _nativeAd.controller = self.superVC;
        _nativeAd.delegate   = self;
    }
    [_nativeAd loadAd:1];
}
- (void)createInsertView:(NSInteger)index {
    if (index >= _cacheAdArr.count) {
        return;
    }
    _currentAdData                = [_cacheAdArr objectAtIndex:index];
    _insertView                   = [[UIView alloc] initWithFrame:self.frame];
    _insertView.backgroundColor   = [UIColor whiteColor];
    _insertView.tag               = index;
    UITapGestureRecognizer *tap   = [[UITapGestureRecognizer alloc] init];
    tap.delegate                  = self;
    [_insertView addGestureRecognizer:tap];
    NSString *titleText           = [_currentAdData.properties objectForKey:GDTNativeAdDataKeyTitle];
    UILabel *titleLable           = [[UILabel alloc] initWithFrame:CGRectMake(kTitleLabelX, kTitleLabelY, kTitleLabelWidth, kTitleLabelHeight)];
    titleLable.textColor          = [UIColor blackColor];
    titleLable.textAlignment      = NSTextAlignmentLeft;
    titleLable.font               = [UIFont systemFontOfSize:14.0f];
    [_insertView addSubview:titleLable];
    NSString *contentText         = [_currentAdData.properties objectForKey:GDTNativeAdDataKeyDesc];
    UILabel *contentLabel         = [[UILabel alloc] initWithFrame:CGRectMake(kTextLabelX, kTextLabelY, kTextLabelWidth, kTextLabelHeight)];
    contentLabel.textColor        = [UIColor colorWithRed:153 / 255.0f green:153 / 255.0f blue:153 / 255.0f alpha:1.0f];
    contentLabel.textAlignment    = NSTextAlignmentLeft;
    contentLabel.font             = [UIFont systemFontOfSize:14.0f];
    [_insertView addSubview:contentLabel];
    NSData* data                  = [NSData dataWithContentsOfURL:[NSURL URLWithString:[_currentAdData.properties objectForKey:GDTNativeAdDataKeyIconUrl]]];
    UIImage *logoImage            = [UIImage imageWithData:data];
    UIImageView *logoImageView    = [[UIImageView alloc] initWithImage:logoImage];
    logoImageView.frame           = CGRectMake(kLogoImageViewX, kLogoImageViewY, kLogoImageViewWidth, kLogoImageViewHeight);
    [_insertView addSubview:logoImageView];
    data                          = [NSData dataWithContentsOfURL:[NSURL URLWithString:[_currentAdData.properties objectForKey:GDTNativeAdDataKeyImgUrl]]];
    UIImage *contentImg           = [UIImage imageWithData:data];
    UIImageView *contentImageView = [[UIImageView alloc] initWithImage:contentImg];
    contentImageView.frame        = CGRectMake(kContentImageViewX, kContentImageViewY, kContentImageViewWidth, kContentImageViewHeight);
    [_insertView addSubview:contentImageView];
    [_nativeAd attachAd:_currentAdData toView:_insertView];
    dispatch_async(dispatch_get_main_queue(), ^{
        titleLable.text   = titleText;
        contentLabel.text = contentText;
        [self.view addSubview:_insertView];
    });
}
-(void)nativeAdSuccessToLoad:(NSArray *)nativeAdDataArray {
    _cacheAdArr = [NSMutableArray arrayWithArray:nativeAdDataArray];
    [_impResultArr removeAllObjects];
    for (int i = 0; i < _cacheAdArr.count; i++) {
        NSString *trackStatus        = @"NO";
        [_impResultArr addObject:trackStatus];
    }
    [self createInsertView:0];
    if (self.advertLoadedSuccess) {
        self.advertLoadedSuccess();
    }
}
-(void)nativeAdFailToLoad:(NSError *)error {
    if (self.advertLoadedFailure) {
        self.advertLoadedFailure();
    }
}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    [self tapGestureRecognizerClick];
    return YES;
}
- (void)tapGestureRecognizerClick {
    [_nativeAd clickAd:_currentAdData];
    if (self.clickAdvertSuccess) {
        self.clickAdvertSuccess();
    }
}
@end
