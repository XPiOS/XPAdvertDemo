一、功能简介
将百度、广点通、聚效sdk进行封装，实现一行代码调用广告。
1、百度：banner广告、插页广告、开屏广告
2、广点通：banner广告、插页广告、开屏广告、书型广告
3、聚效：banner广告、插页广告

二、用法简介
1、导入XPAdvert文件夹
2、导入类库：CoreMotionFramework、MessageUI.framework、StoreKit.framework、libc++.tbd、libz.tbd
3、开启http功能
4、根据需求，上传广告id
5、在需要调用时，导入头文件：XPAdvert.h
6、调用初始化方法：- (instancetype)initWithView:(UIView *)view frame:(CGRect)frame advertType:(AdvertType)advertType platformType:(PlatformType)platformType superVC:(UIViewController *)superVC;
7、调用加载方法：- (void)loadAdvert;
8、另提供三个block：advertLoadedSuccess（加载成功）、advertLoadedFailure（加载失败）、clickAdvertSuccess（点击广告）

三、代码演示
   
   self.advert = [[XPAdvert alloc] initWithView:self.view frame:CGRectMake(0, 0, self.view.frame.size.width, 49) advertType:BannerAdvertType platformType:BaiDupPlatformType superVC:self];
    self.advert.clickAdvertSuccess = ^() {
        NSLog(@"点击了广告");
    };
    self.advert.advertLoadedSuccess = ^() {
        NSLog(@"获取广告成功");
    };
    self.advert.advertLoadedFailure = ^() {
        NSLog(@"获取广告失败");
    };
    [self.advert loadAdvert];
