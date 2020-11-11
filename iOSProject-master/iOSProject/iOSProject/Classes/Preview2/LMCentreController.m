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
#import "SIMAvatarTableViewCell.h"
#import "SIMBaseCommonTableViewCell.h"


@interface LMCentreController ()<UITableViewDelegate,UITableViewDataSource>{
    
    UITableView *_tableView;
    NSArray<NSArray<UITableViewCell*>*>* _cells;
}

@end


@implementation LMCentreController


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [_tableView  reloadData];
}


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
    _tableView.backgroundColor=[UIColor grayColor];
    _tableView.backgroundColor=[UIColor colorWithHexString:@"#e4e4e4"];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    [self.view addSubview:_tableView];
    _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screen_width, 80)];

    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.width.height.equalTo(self.view);
        make.top.equalTo(self.view).with.offset(88);
        //make.bottom.equalTo(self.view).with.offset(-40);
    }];

    //初始化Cell
    [self prepareCells];

}




//创建静态cell
-(void)prepareCells
{
    SIMAvatarTableViewCell* avatarCell = [[SIMAvatarTableViewCell alloc] init];
    SIMBaseCommonTableViewCell* systemCell = [[SIMBaseCommonTableViewCell alloc] initWithTitle:@"系统通知"];
    SIMBaseCommonTableViewCell* meetingCell = [[SIMBaseCommonTableViewCell alloc] initWithTitle:@"课程设置"];
    SIMBaseCommonTableViewCell* imCell = [[SIMBaseCommonTableViewCell alloc] initWithTitle:@"消息通知"];
    SIMBaseCommonTableViewCell*shebeiCell = [[SIMBaseCommonTableViewCell alloc] initWithTitle:@"设备设置"];
      SIMBaseCommonTableViewCell*HuoDongCell = [[SIMBaseCommonTableViewCell alloc] initWithTitle:@"活动"];
    SIMBaseCommonTableViewCell*duanlianCell = [[SIMBaseCommonTableViewCell alloc] initWithTitle:@"锻炼项目"];
    SIMBaseCommonTableViewCell*yyCell = [[SIMBaseCommonTableViewCell alloc] initWithTitle:@"营养和身体"];
    SIMBaseCommonTableViewCell*sleepCell = [[SIMBaseCommonTableViewCell alloc] initWithTitle:@"睡眠"];
    SIMBaseCommonTableViewCell*jiaolianCell = [[SIMBaseCommonTableViewCell alloc] initWithTitle:@"申请成为教练"];
    SIMBaseCommonTableViewCell* aboutCell = [[SIMBaseCommonTableViewCell alloc] initWithTitle:@"帮助"];
    
    _cells = @[@[avatarCell],@[systemCell,meetingCell,imCell,shebeiCell],@[HuoDongCell,duanlianCell,yyCell,sleepCell],@[jiaolianCell,aboutCell]];
    
    [_tableView reloadData];

}



#pragma mark - TableView
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section==0)
    {
        return 120;
    }else{
        
        return 44;
    }
}


-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return CGFLOAT_MIN;
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return CGFLOAT_MIN;
    }else if(section==2){
    
        return 10;
    
    }else {
        return 10;
    }
    
}




- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger) section
{
    
 if(section==2){
     
//     if (IS_IPHONE) {
//         UIView *v=[[UIView alloc]initWithFrame:CGRectMake(0,0,ScreenWidth,20)];
//         UILabel* lb;
//         if(ScreenHeight>=735){
//             lb=[[UILabel alloc]initWithFrame:CGRectMake(20,10,v.frame.size.width,v.frame.size.height)];
//         }else{
//
//               lb=[[UILabel alloc]initWithFrame:CGRectMake(20,-10,v.frame.size.width,v.frame.size.height)];
//         }
//
//         lb.text=@"目标";
//         lb.font=FontRegularName(15);
//         lb.textColor=[UIColor lightGrayColor];
//         [v addSubview:lb];
//
//
//         return v;
//     }else{
//         UIView *v=[[UIView alloc]initWithFrame:CGRectMake(0,0,ScreenWidth,50)];
//         UILabel* lb=[[UILabel alloc]initWithFrame:CGRectMake(25, 0,v.frame.size.width,v.frame.size.height)];
//         lb.text=@"目标";
//         lb.font=FontRegularName(8);
//         lb.textColor=[UIColor lightGrayColor];
//         [v addSubview:lb];
//        return v;
//     }
     
     return [UIView new];
     
 }else{
     
     return [UIView new];
 }
   
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _cells.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _cells[section].count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return _cells[indexPath.section][indexPath.row];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}


// 获取用户信息列表
- (void)getUserList {
    
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
