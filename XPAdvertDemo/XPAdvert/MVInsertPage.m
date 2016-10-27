//
//  MVInsertPage.m
//  创新版
//
//  Created by XuPeng on 16/8/17.
//  Copyright © 2016年 cxb. All rights reserved.
//

#import "MVInsertPage.h"
#import "MVADConfigManager.h"

@implementation MVInsertPage {
    MVADNativeLoader        *_nativeLoader;
    NSMutableArray          *_impResultArr;
    UIView                  *_interstitialADView;
    UIImageView             *_logoImageView;
    UILabel                 *_titleLabel;
    UILabel                 *_textLabel;
    UIImageView             *_contentImageView;
    UITapGestureRecognizer  *_tapGestureRecognizer;
}
- (void)loadAdvert {
    if (!_impResultArr) {
        _impResultArr = [NSMutableArray array];
    }
    for (int i = 0; i < _impResultArr.count; i++) {
        NSString *trackStatus = _impResultArr[i];
        if ([trackStatus isEqualToString:@"NO"]) {
            [self buildNativeContentIndex:i];
            return;
        }
    }
    if (!_nativeLoader) {
        _nativeLoader = [[MVADNativeLoader alloc] initWithadspaceId:kJuXiaoInsertId
                                                        andDelegate:self];
    }
    [_nativeLoader loadNativeAds];
}
- (UIView *)buildNativeContentIndex:(NSInteger)index{

    MVADNative *native                  = [_nativeLoader.nativeADs objectAtIndex:index];
    NSDictionary *contentDict           = [NSJSONSerialization JSONObjectWithData:[native.content dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];
    NSString *logo                      = [contentDict objectForKey:@"logo"];
    NSString *contentimg                = [contentDict objectForKey:@"contentimg"];
    NSString *ext_text                  = [contentDict objectForKey:@"ext_text"];
    NSString *title                     = [contentDict objectForKey:@"title"];
    _interstitialADView                 = [[UIView alloc] initWithFrame:self.frame];
    _interstitialADView.backgroundColor = [UIColor whiteColor];
    _interstitialADView.tag             = index;
    _titleLabel                         = [[UILabel alloc] initWithFrame:CGRectMake(kTitleLabelX, kTitleLabelY, kTitleLabelWidth, kTitleLabelHeight)];
    _titleLabel.text                    = title;
    _titleLabel.textColor               = [UIColor blackColor];
    _titleLabel.textAlignment           = NSTextAlignmentLeft;
    _titleLabel.font                    = [UIFont systemFontOfSize:14.0f];
    [_interstitialADView addSubview:_titleLabel];
    _textLabel                          = [[UILabel alloc] initWithFrame:CGRectMake(kTextLabelX, kTextLabelY, kTextLabelWidth, kTextLabelHeight)];
    _textLabel.text                     = ext_text;
    _textLabel.textColor                = [UIColor colorWithRed:153 / 255.0f green:153 / 255.0f blue:153 / 255.0f alpha:1.0f];
    _textLabel.textAlignment            = NSTextAlignmentLeft;
    _textLabel.font                     = [UIFont systemFontOfSize:14.0f];
    [_interstitialADView addSubview:_textLabel];
    NSData* data                        = [NSData dataWithContentsOfURL:[NSURL URLWithString:logo]];
    UIImage *logoImage                  = [UIImage imageWithData:data];
    _logoImageView                      = [[UIImageView alloc] initWithImage:logoImage];
    _logoImageView.frame                = CGRectMake(kLogoImageViewX, kLogoImageViewY, kLogoImageViewWidth, kLogoImageViewHeight);
    _logoImageView.layer.cornerRadius   = 8;
    _logoImageView.layer.masksToBounds  = YES;
    _logoImageView.layer.borderWidth    = 2;
    _logoImageView.layer.borderColor    = [[UIColor colorWithRed:153 / 255.0f green:153 / 255.0f blue:153 / 255.0f alpha:1.0f] CGColor];
    [_interstitialADView addSubview:_logoImageView];
    data                                = [NSData dataWithContentsOfURL:[NSURL URLWithString:contentimg]];
    UIImage *contentImg                 = [UIImage imageWithData:data];
    _contentImageView                   = [[UIImageView alloc] initWithImage:contentImg];
    _contentImageView.frame             = CGRectMake(kContentImageViewX, kContentImageViewY, kContentImageViewWidth, kContentImageViewHeight);
    [_interstitialADView addSubview:_contentImageView];
    _tapGestureRecognizer               = [[UITapGestureRecognizer alloc] init];
    _tapGestureRecognizer.delegate      = self;
    [_interstitialADView addGestureRecognizer:_tapGestureRecognizer];
    _impResultArr[index]                = @"YES";
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.view addSubview:_interstitialADView];
    });
    return nil;
}
- (void)mvadNativeDidReceiveAds:(NSArray *)natives {
    [_impResultArr removeAllObjects];
    if (natives.count <= 0) {
        return;
    }
    for (int i = 0; i < natives.count; i++) {
        NSString *trackStatus = @"NO";
        [_impResultArr addObject:trackStatus];
    }
    [self buildNativeContentIndex:0];
    if (self.advertLoadedSuccess) {
        self.advertLoadedSuccess();
    }
}
-(void)mvadNativeLoader:(MVADNativeLoader *)nativeLoader didFailToReceiveAdWithErrorDescription:(NSString *)errorDescription {
    if (self.advertLoadedFailure) {
        self.advertLoadedFailure();
    }
}
- (void)tapGestureRecognizerClick {
    MVADNative *native = [_nativeLoader.nativeADs objectAtIndex:_interstitialADView.tag];
    [native handleADOnClick:nil andPoint:_interstitialADView.center];
    if (self.clickAdvertSuccess) {
        self.clickAdvertSuccess();
    }
}
-(void)mvadNativeDidInteract:(MVADNative *)native withParams:(NSDictionary *)params {
}
- (void)mvadNativeWillLeaveApplication:(MVADNative *)native {
}
- (BOOL)allowMvadNativeShowLandingPage:(MVADNative *)native {
    return YES;
}
- (void)mvadNative:(MVADNative *)native withLandingPageView:(UIView *)landingPageView {
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    UIViewController *rootViewController = window.rootViewController;
    [rootViewController.view addSubview:landingPageView];
    
    landingPageView.center = CGPointMake(rootViewController.view.bounds.size.width/2, rootViewController.view.bounds.size.height/2 * 3);
    
    [UIView animateWithDuration:0.3f animations:^{
        landingPageView.center = CGPointMake(rootViewController.view.bounds.size.width/2, rootViewController.view.bounds.size.height/2);
    }];
}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    [self tapGestureRecognizerClick];
    return YES;
}

@end
