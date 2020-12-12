//
//  ListTimerController.m
//  iOSProject
//
//  Created by lgm on 2020/12/11.
//  Copyright © 2020 github.com/njhu. All rights reserved.
//

#import "ListTimerController.h"
#import "ListTimerCell.h"

@interface ListTimerController (){
    
    NSTimeInterval _timeInterval;
    NSArray *dataSource;//时间数组

}

/** 创建timer */
@property (nonatomic, strong) NSTimer *timer;

@end

@implementation ListTimerController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=@"商品秒杀";
    //初始化数据源
    dataSource = @[@"2020-12-13 14:24:02",@"2020-12-12 15:50:10",@"2020-12-13 15:24:10",@"2020-12-13 15:24:10",@"2020-12-13 15:24:10",@"2023-04-11 14:34:08",@"2018-05-12 14:26:03",@"2018-05-13 22:23:49",@"2018-07-14 14:23:43",@"2018-08-15 14:23:14",@"2018-09-16 14:23:41",@"2018-10-17 14:11:46",@"2018-11-18 14:23:23",@"2018-12-19 14:23:43",@"2018-12-20 14:12:45",@"2018-12-21 14:23:22",@"2018-12-22 14:23:40",@"2018-12-23 14:13:40",@"2018-12-24 14:23:45",@"2018-12-25 14:23:45",@"2018-12-26 14:14:41"];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(@0);
        make.top.equalTo(@0);
        make.bottom.equalTo(@-80);
    }];
     
    self.tableView.showsVerticalScrollIndicator = NO;

    //自适应高度
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    [self startTimer];

}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return dataSource.count;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellID = @"ListTimerCellID";
    
    ListTimerCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[ListTimerCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.titleLb1.text=[dataSource objectAtIndex:indexPath.row];
    cell.titleLb1.text = [self getNowTimeWithString:dataSource[indexPath.row]];

    return cell;
    
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
}




-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 20;
}






-(void)startTimer
{
   if (!_timer) {
       _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeCount:) userInfo:nil repeats:YES];
       
       [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
   }
}

- (void)timeCount:(NSTimer *)timer
{
   @synchronized(self) {
       
       if (_timeInterval==0) {
           
       }else{
           _timeInterval--;
       }
       
    
//       [self.products enumerateObjectsUsingBlock:^(LMJCountDownModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//           if (obj.date == 0) {
//           }else {
//               obj.date--;
//           }
//       }];
//
       
       
       [[self.tableView visibleCells] enumerateObjectsUsingBlock:^(__kindof UITableViewCell * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
           ListTimerCell *cell = (ListTimerCell *)obj;
           cell.titleLb1.text = [self getNowTimeWithString:dataSource[idx]];
       }];
       
       
       
   }
    
    
//    [self.tableView reloadData];
}




-(NSString *)getNowTimeWithString:(NSString *)aTimeString{
    NSDateFormatter* formater = [[NSDateFormatter alloc] init];
    [formater setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    // 截止时间date格式
    NSDate  *expireDate = [formater dateFromString:aTimeString];
    NSDate  *nowDate = [NSDate date];
    
    
    // 当前时间字符串格式
    NSString *nowDateStr = [formater stringFromDate:nowDate];
    // 当前时间date格式
    nowDate = [formater dateFromString:nowDateStr];
  
    NSTimeInterval timeInterval =[expireDate timeIntervalSinceDate:nowDate];
    _timeInterval=timeInterval;
    int days = (int)(timeInterval/(3600*24));
    int hours = (int)((timeInterval-days*24*3600)/3600);
    int minutes = (int)(timeInterval-days*24*3600-hours*3600)/60;
    int seconds = timeInterval-days*24*3600-hours*3600-minutes*60;
    
    NSString *dayStr;NSString *hoursStr;NSString *minutesStr;NSString *secondsStr;
    //天
    dayStr = [NSString stringWithFormat:@"%d",days];
    //小时
    hoursStr = [NSString stringWithFormat:@"%d",hours];
   //分钟
    if(minutes<10)
        minutesStr = [NSString stringWithFormat:@"0%d",minutes];
    else
        minutesStr = [NSString stringWithFormat:@"%d",minutes];
    //秒
    if(seconds < 10)
        secondsStr = [NSString stringWithFormat:@"0%d", seconds];
    else
        secondsStr = [NSString stringWithFormat:@"%d",seconds];
    if (hours<=0&&minutes<=0&&seconds<=0) {
        return @"活动已经结束！";
    }
    if (days) {
        return [NSString stringWithFormat:@"%@天 %@小时 %@分 %@秒", dayStr,hoursStr, minutesStr,secondsStr];
    }
    return [NSString stringWithFormat:@"%@小时 %@分 %@秒",hoursStr , minutesStr,secondsStr];
}



/**
 * 根据传入的年份和月份获得该月份的天数
 *
 * @param year
 *            年份-正整数
 * @param month
 *            月份-正整数
 * @return 返回天数
 */
-(NSInteger)getDayNumberWithYear:(NSInteger )y month:(NSInteger )m{
    int days[] = { 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31 };
    if (2 == m && 0 == (y % 4) && (0 != (y % 100) || 0 == (y % 400))) {
        days[1] = 29;
    }
    return (days[m - 1]);
}


- (void)dealloc
{
    if (_timer) {
        [_timer invalidate];
        _timer = nil;
    }
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
