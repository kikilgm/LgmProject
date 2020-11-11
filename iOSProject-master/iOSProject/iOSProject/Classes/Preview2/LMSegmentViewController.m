//
//  SegmentViewController.m
//  iOSProject
//
//  Created by lgm on 2020/11/4.
//  Copyright © 2020 github.com/njhu. All rights reserved.
//

#import "LMSegmentViewController.h"
#import "YJSegmentedControl.h"

@interface LMSegmentViewController ()<YJSegmentedControlDelegate>

@end

@implementation LMSegmentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createUISegmentedControl];
    // Do any additional setup after loading the view.
}






#pragma mark - LMJNavUIBaseViewControllerDataSource

/** 导航条左边的按钮 */
- (UIImage *)lmjNavigationBarLeftButtonImage:(UIButton *)leftButton navigationBar:(LMJNavigationBar *)navigationBar
{
    [leftButton setImage:[UIImage imageNamed:@"NavgationBar_white_back"] forState:UIControlStateHighlighted];
    
    return [UIImage imageNamed:@"NavgationBar_blue_back"];
}







#pragma mark - LMJNavUIBaseViewControllerDelegate
/** 左边的按钮的点击 */
-(void)leftButtonEvent:(UIButton *)sender navigationBar:(LMJNavigationBar *)navigationBar
{
    [self.navigationController popViewControllerAnimated:YES];
}





-(void)createUISegmentedControl{
    // **********************  样式1 *******************************
    //  第3步  创建需要的选择器
    NSArray * btnDataSource = @[@"未付款", @"已付款", @"待收货"];
    
    
    
    
   //  第4部  调用创建
    YJSegmentedControl * segment = [YJSegmentedControl segmentedControlFrame:CGRectMake(0, 44, self.view.bounds.size.width, 44) titleDataSource:btnDataSource backgroundColor:[UIColor colorWithRed:253.0f/255 green:239.0f/255 blue:230.0f/255 alpha:1.0f] titleColor:[UIColor grayColor] titleFont:[UIFont fontWithName:@".Helvetica Neue Interface" size:16.0f] selectColor:[UIColor orangeColor] buttonDownColor:[UIColor redColor] Delegate:self];
    // 第5步 添加到试图上
    [self.view addSubview:segment];
    
    [segment mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@86);
        make.width.equalTo(self.view);
        make.height.equalTo(@44);
        
    }];
    
    
    
    
    
    
    
    /************************* 样式2 ***************************
     *  样式2
     */
    
    

    
    
    NSArray * btnDataSource2 = @[@"未付款", @"已付款", @"待发货", @"待收货"];
    YJSegmentedControl * segment2 = [YJSegmentedControl segmentedControlFrame:CGRectMake(0, CGRectGetMaxY(segment.frame) + 100, self.view.bounds.size.width, 44) titleDataSource:btnDataSource2 backgroundColor:[UIColor lightGrayColor] titleColor:[UIColor whiteColor] titleFont:[UIFont fontWithName:@".Helvetica Neue Interface" size:16.0f] selectColor:[UIColor redColor] buttonDownColor:[UIColor orangeColor] Delegate:self];
    [self.view addSubview:segment2];
    
    
    
    
    
    /************************* 样式3 ***************************
     *  样式2
     */
    
    NSArray * btnDataSource3 = @[@"未付款", @"已付款", @"待发货", @"待收货", @"退款"];
    YJSegmentedControl * segment3 = [YJSegmentedControl segmentedControlFrame:CGRectMake(0, CGRectGetMaxY(segment2.frame) + 100, self.view.bounds.size.width, 44) titleDataSource:btnDataSource3 backgroundColor:[UIColor whiteColor] titleColor:[UIColor grayColor] titleFont:[UIFont fontWithName:@".Helvetica Neue Interface" size:16.0f] selectColor:[UIColor orangeColor] buttonDownColor:[UIColor redColor] Delegate:self];
    [self.view addSubview:segment3];
    
    
    
}







#pragma mark -- 遵守代理 实现代理方法
- (void)segumentSelectionChange:(NSInteger)selection{
    if (selection == 0) {
         NSLog(@"未付款");
    }else if (selection == 1){
         NSLog(@"已付款");
    }else{
         NSLog(@"待发货");
    }

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
