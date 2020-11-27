//
//  LMJTabBarController.m
//  PLMMPRJK
//
//  Created by HuXuPeng on 2017/4/6.
//  Copyright © 2017年 GoMePrjk. All rights reserved.
//

#import "LMJTabBarController.h"
#import "LMJNavigationController.h"
#import "LMJHomeViewController.h"
#import "LMJMessageViewController.h"
#import "LMJMeViewController.h"
#import "LMJNewViewController.h"
#import "LMJCasesViewController.h"
#import "LgmNewHomeController.h"




@interface LMJTabBarController ()<UITabBarControllerDelegate>
////记录上一次点击tabbar，使用时，记得先在init或viewDidLoad里 初始化 = 0
@property (nonatomic,assign) NSInteger  indexFlag;


@end

@implementation LMJTabBarController


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.indexFlag=0;

}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.indexFlag=0;

    [self addChildViewControllers];
    [self addTabarItems];
    self.delegate = self;
}
- (void)customIsInGod:(NSNotification *)noti {
    if (![noti.object boolValue]) {
        return;
    }
}


- (void)addChildViewControllers
{
    
    
    
    UINavigationController *one = [[UINavigationController alloc] initWithRootViewController:[[LgmNewHomeController alloc] init]];
    
    
    UINavigationController *two = [[UINavigationController alloc] initWithRootViewController:[[LMJNewViewController alloc] init]];
    
    LMJNavigationController *three = [[LMJNavigationController alloc] initWithRootViewController:[[LMJHomeViewController alloc] init]];
    
    LMJNavigationController *four = [[LMJNavigationController alloc] initWithRootViewController:[[LMJMessageViewController alloc] init]];
    
//    LMJNavigationController *four = [[LMJNavigationController alloc] initWithRootViewController:[[LMJMeViewController alloc] init]];
    
    LMJNavigationController *five = [[LMJNavigationController alloc] initWithRootViewController:[[LMJCasesViewController alloc] init]];
    
    self.viewControllers = @[one,two,three,four,five];
    
}

- (void)addTabarItems
{
    
    NSDictionary *firstTabBarItemsAttributes = @{
                                                    @"TabBarItemTitle" : @"首页",
                                                    @"TabBarItemImage" : @"Home",
                                                    @"TabBarItemSelectedImage" : @"Home_s",
                                                    
                                                 };
    
    NSDictionary *secondTabBarItemsAttributes = @{
                                                    @"TabBarItemTitle" : @"功能",
                                                    @"TabBarItemImage" : @"Category",
                                                    @"TabBarItemSelectedImage" : @"Category_s",
                                                 };
    
    NSDictionary *thirdTabBarItemsAttributes = @{
                                                 @"TabBarItemTitle" : @"基础",
                                                 @"TabBarItemImage" : @"Bu",
                                                 @"TabBarItemSelectedImage" : @"Bu_s",
                                                 };
    
    NSDictionary *fourthTabBarItemsAttributes = @{
                                                  @"TabBarItemTitle" : @"实例",
                                                  @"TabBarItemImage" : @"Shop",
                                                  @"TabBarItemSelectedImage" : @"Shop_s"
                                                  };
    
    NSDictionary *fifthTabBarItemsAttributes = @{
                                                  @"TabBarItemTitle" : @"更多",
                                                  @"TabBarItemImage" : @"mine",
                                                  @"TabBarItemSelectedImage" : @"mine_s"
                                                  };
    
    NSArray<NSDictionary *>  *tabBarItemsAttributes = @[
                                       firstTabBarItemsAttributes,
                                       secondTabBarItemsAttributes,
                                       thirdTabBarItemsAttributes,
                                       fourthTabBarItemsAttributes,
                                       fifthTabBarItemsAttributes
                                       ];
    
    [self.childViewControllers enumerateObjectsUsingBlock:^(__kindof UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        obj.tabBarItem.title = tabBarItemsAttributes[idx][@"TabBarItemTitle"];
        obj.tabBarItem.image = [[UIImage imageNamed:tabBarItemsAttributes[idx][@"TabBarItemImage"]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        obj.tabBarItem.selectedImage = [[UIImage imageNamed:tabBarItemsAttributes[idx][@"TabBarItemSelectedImage"]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        

        //tab文字 和 图标的间距
        obj.tabBarItem.titlePositionAdjustment = UIOffsetMake(0,-2);
        
        [obj.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#9B9B9B"],NSFontAttributeName:[UIFont
        systemFontOfSize:11]} forState:UIControlStateNormal];
        
        [obj.tabBarItem  setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#EA4747"],NSFontAttributeName:[UIFont
        systemFontOfSize:11]} forState:UIControlStateSelected];
        
        //从父类修改 tabbar 文字颜色
        self.tabBar.tintColor = [UIColor colorWithHexString:@"#EA4747"];
      //item0.image = [[UIImage imageNamed:@"notepad"]  imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];

        
    }];
    

}

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
{
    return YES;
}



-(void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item{
    NSInteger index = [self.tabBar.items indexOfObject:item];
    if (index != self.indexFlag) {
        //执行动画
        NSMutableArray *arry = [NSMutableArray array];
        for (UIView *btn in self.tabBar.subviews) {
            if ([btn isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
                 [arry addObject:btn];
            }
        }

        //添加动画
        //放大效果，并回到原位
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
        //速度控制函数，控制动画运行的节奏
        animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        animation.duration = 0.15;       //执行时间
        animation.repeatCount = 1;      //执行次数
        animation.autoreverses = YES;    //完成动画后会回到执行动画之前的状态

        //先缩小再放大
        animation.fromValue = [NSNumber numberWithFloat:0.9];   //初始伸缩倍数
        animation.toValue = [NSNumber numberWithFloat:1.1];     //结束伸缩倍数
        [[arry[index] layer] addAnimation:animation forKey:nil];
        
        
        
        
        
        
//        //向上移动 效果
//        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.translation.y"];
//        //速度控制函数，控制动画运行的节奏
//        animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
//        animation.duration = 0.15;       //执行时间
//        animation.repeatCount = 1;      //执行次数
//        animation.removedOnCompletion = YES;
//        animation.fromValue = [NSNumber numberWithFloat:0];   //初始伸缩倍数
//        animation.toValue = [NSNumber numberWithFloat:-8];     //结束伸缩倍数
//        [[arry[index] layer] addAnimation:animation forKey:nil];
                
        
        

        
        
        
//        //放大效果  放到并保持
//        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
//        //速度控制函数，控制动画运行的节奏
//        animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
//        animation.duration = 0.2;       //执行时间
//        animation.repeatCount = 1;      //执行次数
//        animation.removedOnCompletion = NO;
//        animation.fillMode = kCAFillModeForwards;           //保证动画效果延续
//        animation.fromValue = [NSNumber numberWithFloat:1.0];   //初始伸缩倍数
//        animation.toValue = [NSNumber numberWithFloat:1.2];     //结束伸缩倍数
//        [[arry[index] layer] addAnimation:animation forKey:nil];
//        //移除其他tabbar的动画
//        for (int i = 0; i<arry.count; i++) {
//            if (i != index) {
//                [[arry[i] layer] removeAllAnimations];
//            }
//        }
        
        
        
        
        

        
        
        
//        //z轴旋转180度  太夸张
//        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
//        //速度控制函数，控制动画运行的节奏
//        animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
//        animation.duration = 0.2;       //执行时间
//        animation.repeatCount = 1;      //执行次数
//        animation.removedOnCompletion = YES;
//        animation.fromValue = [NSNumber numberWithFloat:0];   //初始伸缩倍数
//        animation.toValue = [NSNumber numberWithFloat:M_PI];     //结束伸缩倍数
//        [[arry[index] layer] addAnimation:animation forKey:nil];
//
        
        
        
        self.indexFlag = index;

        
    }
}

@end
