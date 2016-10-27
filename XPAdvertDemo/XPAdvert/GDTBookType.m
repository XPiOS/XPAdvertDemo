//
//  GDTBookType.m
//  创新版
//
//  Created by XuPeng on 16/8/26.
//  Copyright © 2016年 cxb. All rights reserved.
//

#import "GDTBookType.h"

@implementation GDTBookType {
    GDTNativeAd     *_nativeAd;
    UIView          *_bookTypeView;
    GDTNativeAdData *_currentAdData;
    
}
- (void)loadAdvert {
    if (_bookTypeView) {
        [_bookTypeView removeFromSuperview];
        _bookTypeView = nil;
    }
    _nativeAd            = [[GDTNativeAd alloc] initWithAppkey:kGDTAppId placementId:kGDTBookId];
    _nativeAd.controller = self.superVC;
    _nativeAd.delegate   = self;
    [_nativeAd loadAd:1];
    _bookTypeView        = [[UIView alloc] initWithFrame:self.frame];
    [self.view addSubview:_bookTypeView];
}
-(void)nativeAdSuccessToLoad:(NSArray *)nativeAdDataArray {

    CGRect imageViewRect                         = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height - 36);
    CGRect titleRect                             = CGRectMake(0, self.frame.size.height - 26, self.frame.size.width, 16);
    _currentAdData                               = [nativeAdDataArray objectAtIndex:0];
    _bookTypeView                                = [[UIView alloc] initWithFrame:self.frame];
    _bookTypeView.backgroundColor                = [UIColor whiteColor];
    UIImageView *contentImageView                = [[UIImageView alloc] init];
    NSData *data                                 = [NSData dataWithContentsOfURL:[NSURL URLWithString:[_currentAdData.properties objectForKey:GDTNativeAdDataKeyImgUrl]]];
    UIImage *contentImg                          = [UIImage imageWithData:data];
    contentImageView.image                       = contentImg;
    contentImageView.frame                       = imageViewRect;
    contentImageView.layer.masksToBounds         = YES;
    contentImageView.layer.cornerRadius          = 5.0f;
    [_bookTypeView addSubview:contentImageView];
    NSString *text                               = [_currentAdData.properties objectForKey:GDTNativeAdDataKeyTitle];
    UILabel *bookName                            = [[UILabel alloc] init];
    bookName.frame                               = titleRect;
    bookName.textAlignment                       = NSTextAlignmentLeft;
    bookName.font                                = [UIFont systemFontOfSize:13.0f];
    [_bookTypeView addSubview:bookName];
    [_nativeAd attachAd:_currentAdData toView:_bookTypeView];
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(nativeAdClick)];
    [_bookTypeView addGestureRecognizer:tapGestureRecognizer];
    dispatch_async(dispatch_get_main_queue(), ^{
        bookName.text = text;
        [self.view addSubview:_bookTypeView];
    });
    if (self.advertLoadedSuccess) {
        self.advertLoadedSuccess();
    }
}
-(void)nativeAdFailToLoad:(NSError *)error {
    if (self.advertLoadedFailure) {
        self.advertLoadedFailure();
    }
}
- (void)nativeAdClick {
    [_nativeAd clickAd:_currentAdData];
    if (self.clickAdvertSuccess) {
        self.clickAdvertSuccess();
    }
}
@end
