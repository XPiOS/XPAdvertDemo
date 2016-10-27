/**
 *  百度的配置信息
 */
#define kBaiDuAppId      @"a905b394"
#define kBaiDuBannerId   @"2822125"
#define kBaiDuInsertId   @"2822140"
#define kBaiDuSplashId   @"2822131"
/**
 *  聚效的配置信息
 */
#define kJuXiaoBannerId  @"aa5vllE6tJ"
#define kJuXiaoInsertId  @"Fua6QQjvOI"
/**
 *  广点通的配置信息
 */
#define kGDTAppId        @"1105543429"
#define kGDTBannerId     @"5090816483460706"
#define kGDTBookId       @"9000519473665708"
#define kGDTInsertId     @"4020713403766810"
#define kGDTSplashId     @"3010917483365686"

// logo
#define kLogoImageViewX                       20.0f
#define kLogoImageViewY                       20.0f
#define kLogoImageViewWidth                   51.0f
#define kLogoImageViewHeight                  51.0f
// title
#define kTitleLabelX                          (kLogoImageViewX + kLogoImageViewWidth + 10.0f)
#define kTitleLabelY                          20.0f
#define kTitleLabelWidth                      (self.frame.size.width - kTitleLabelX - 20.0f)
#define kTitleLabelHeight                     kLogoImageViewHeight / 2.0f
// text
#define kTextLabelX                           kTitleLabelX
#define kTextLabelY                           (kTitleLabelY + kTitleLabelHeight)
#define kTextLabelWidth                       kTitleLabelWidth
#define kTextLabelHeight                      kTitleLabelHeight
// 内容图片
#define kContentImageViewX                    20.0f
#define kContentImageViewY                    (kLogoImageViewY + kLogoImageViewHeight + 20.0f)
#define kContentImageViewWidth                (self.frame.size.width - 40.0f)
#define kContentImageViewHeight               (self.frame.size.height - 20.0f - 20.0f - kContentImageViewY)