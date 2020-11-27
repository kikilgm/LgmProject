//
//  LgmNewHomeController.m
//  iOSProject
//
//  Created by lgm on 2020/11/27.
//  Copyright © 2020 github.com/njhu. All rights reserved.
//

#import "LgmNewHomeController.h"

@interface LgmNewHomeController ()

@end

@implementation LgmNewHomeController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.hidden=YES;
    // 不让自控制器控制系统导航条
    self.navigationController.fd_viewControllerBasedNavigationBarAppearanceEnabled = NO;
    
    // Do any additional setup after loading the view.
    
//    [self.navigationController.tabBarItem setBadgeValue:@"2"];
    //设置小红点
    UITabBarItem *homeItem = self.navigationController.tabBarItem;
    [homeItem setBadgeValue:@"3"];

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
