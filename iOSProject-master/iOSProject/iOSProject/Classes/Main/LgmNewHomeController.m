//
//  LgmNewHomeController.m
//  iOSProject
//
//  Created by lgm on 2020/11/27.
//  Copyright © 2020 github.com/njhu. All rights reserved.
//

#import "LgmNewHomeController.h"
#import "SDCycleScrollView.h"

#define kWidth [UIScreen mainScreen].bounds.size.width

@interface LgmNewHomeController ()<SDCycleScrollViewDelegate>

@property (nonatomic, strong) UIImageView  * bgImageView;
@property (nonatomic, strong) UIScrollView * bgScrollView;
// 自定义pageControl
@property (nonatomic, strong) SDCycleScrollView * customCycleScrollView;
// 跑马灯效果
@property (nonatomic, strong) SDCycleScrollView * textCycleScrollView;

@end

@implementation LgmNewHomeController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.hidden=YES;
    // 不让自控制器控制系统导航条
    self.navigationController.fd_viewControllerBasedNavigationBarAppearanceEnabled = NO;
    
//    self.bgScrollView
    
    
    
    
    
    // Do any additional setup after loading the view.
//    [self.navigationController.tabBarItem setBadgeValue:@"2"];
    //设置小红点
    UITabBarItem *homeItem = self.navigationController.tabBarItem;
    [homeItem setBadgeValue:@"3"];
    SDCycleScrollView *banner= [self customCycleScrollView];
    [self.view addSubview:banner];
    [banner mas_makeConstraints:^(MASConstraintMaker *make) {
          make.left.mas_equalTo(self.view).with.offset(0);
          make.top.equalTo(@88);
          make.width.mas_equalTo(kWidth);
          make.height.mas_equalTo(150);
      }];
    
}



//创建轮播图
-(SDCycleScrollView *)customCycleScrollView
{
    if (!_customCycleScrollView)
    {
        self.customCycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectZero delegate:self placeholderImage:[UIImage imageNamed:@"placeholder"]];
        self.customCycleScrollView.currentPageDotImage = [UIImage imageNamed:@"pageControlCurrentDot"];
        self.customCycleScrollView.pageDotImage = [UIImage imageNamed:@"pageControlDot"];
        self.customCycleScrollView.pageControlAliment=SDCycleScrollViewPageContolAlimentRight;
        self.customCycleScrollView.pageControlDotSize=CGSizeMake(5,5);
        self.customCycleScrollView.bannerImageViewContentMode=UIViewContentModeScaleAspectFill;
        
        // 网络图片数组
        NSArray *imagesURLStrings = @[
                                      @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1606475529468&di=bfbb865a8025f22dabbbcbf9e72aca43&imgtype=0&src=http%3A%2F%2Fbpic.588ku.com%2Fback_pic%2F17%2F10%2F23%2Ff7b8f4a806cfabad0375b6b46b854f0d.jpg",
                                      @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1606476326190&di=9cad2c53b7af10383a7af0e19842eb13&imgtype=0&src=http%3A%2F%2Fbpic.588ku.com%2Fback_pic%2F05%2F70%2F97%2F925ba5c5e126055.jpg",
                                      @"http://c.hiphotos.baidu.com/image/w%3D400/sign=c2318ff84334970a4773112fa5c8d1c0/b7fd5266d0160924c1fae5ccd60735fae7cd340d.jpg",
                                      @"https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=2030039030,3450047023&fm=26&gp=0.jpg",
                                      ];
        self.customCycleScrollView.imageURLStringsGroup = imagesURLStrings;
    }
    return _customCycleScrollView;
}


/** 点击图片回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    
    
    
    
}

/** 图片滚动回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didScrollToIndex:(NSInteger)index{
    
    
    
    
}








//- (NSMutableAttributedString*)lmjNavigationBarTitle:(LMJNavigationBar *)navigationBar
//{
//    return [self changeTitle:@"首页"];
//}

/** 背景色 */
- (UIColor *)lmjNavigationBackgroundColor:(LMJNavigationBar *)navigationBar{


    return  [UIColor colorWithHexString:@"#EA4747"];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
