//
//  LMCentreController.m
//  iOSProject
//
//  Created by lgm on 2020/11/5.
//  Copyright © 2020 github.com/njhu. All rights reserved.
//

#import "LMCentreController.h"
#import "LMJSettingCell.h"
#import "LMJWordItem.h"


@interface LMCentreController ()<UITableViewDelegate,UITableViewDataSource>{
    
    UITableView *_tableView;
    
}

@end

@implementation LMCentreController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initView];
}






-(void)initView{
    
//    self.extendedLayoutIncludesOpaqueBars = NO;
//    self.edgesForExtendedLayout = UIRectEdgeBottom | UIRectEdgeLeft | UIRectEdgeRight;
    
//    //解决fram从导航栏下面开始方法:
//    //第一种: 将导航栏改成不透明即可
//
//    if( ([[[UIDevice currentDevice] systemVersion] doubleValue]>=7.0))
//    {
//        self.navigationController.navigationBar.translucent = NO;// 设置导航栏是否透明
//    }
//    //第二种:导航栏透明的情况下,frame从导航栏下面开始
//
//    if( ([[[UIDevice currentDevice] systemVersion] doubleValue]>=7.0))
//       {
//           self.edgesForExtendedLayout = UIRectEdgeNone; //页面延伸到的边界
//    }
    

    

    


    _tableView=[[UITableView alloc]init];
//    _tableView.backgroundColor=[UIColor orangeColor];
    [self.view addSubview:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.width.height.equalTo(self.view);
        make.top.equalTo(self.view).with.offset(88);
        //make.bottom.equalTo(self.view).with.offset(-40);
    }];

    
}





-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(section==0){
        return 2;
    }
    
    if (section==1) {
        return 3;
    }
    
    if (section==2) {
        return 3;
    }
    
    
    return 0;
}








-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
        
    LMJSettingCell *cell = [LMJSettingCell cellWithTableView:tableView andCellStyle:UITableViewCellStyleValue1];
    cell.item.title=@"今天";
    
    
    return cell;
    
}




-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
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





/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
