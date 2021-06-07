//
//  LMAlertController.m
//  iOSProject
//
//  Created by lgm on 2021/4/21.
//  Copyright © 2021 github.com/njhu. All rights reserved.
//

#import "LMAlertController.h"

@interface LMAlertController (){
    
    UIView  *viewdd;
    UILabel *dd;
    UILabel *cc;

}

@end

@implementation LMAlertController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    viewdd=[[UIView alloc]init];
    viewdd.backgroundColor=[UIColor  orangeColor];
    viewdd.frame=CGRectMake((ScreenWidth-100)/2, 130,100,100);
    [self.view addSubview:viewdd];
//    [viewdd mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(@130);
//        make.size.mas_equalTo(CGSizeMake(100,100));
//        make.left.mas_equalTo((ScreenWidth-100)/2);
//    }];
    
    dd=[[UILabel alloc]init];

    
    dd.text=@"这是个测试的弹窗";
    dd.font=[UIFont  systemFontOfSize:12];
    dd.frame=CGRectMake(0,0,self->viewdd.frame.size.width,22);
    dd.textAlignment=NSTextAlignmentCenter;
    [viewdd addSubview:dd];
    
//    [dd mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(@0);
//        make.left.right.equalTo(@0);
//        make.height.equalTo(@22);
//    }];
//
    
    cc=[[UILabel alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY(dd.frame),viewdd.frame.size.width,22)];
    
    cc.text=@"这是个测试的弹窗";
    cc.font=[UIFont  systemFontOfSize:12];
    cc.textAlignment=NSTextAlignmentCenter;
    [viewdd addSubview:cc];
    
    
    UIButton *btn=[[UIButton alloc]initWithFrame:CGRectMake(100,300,60,40)];
    btn.backgroundColor=[UIColor redColor];
    [self.view addSubview:btn];
    [btn  addTarget:self action:@selector(action) forControlEvents:UIControlEventTouchUpInside];
    
}


-(void)action{
    [LMAlertController transitformShowView:viewdd hiddenView:viewdd];
    
    return;
    
    
    [UIView animateWithDuration:0.3 animations:^{
//                self->dd.hidden=YES;
//          self->cc.hidden=YES;

    
        
   
//        self->viewdd.frame=CGRectMake((ScreenWidth-150)/2, 130,150,150);
        
//        self->dd.frame=CGRectMake(0,0,self->viewdd.frame.size.width,22);
//        self->dd.font=[UIFont systemFontOfSize:14];
//        self->cc.frame=CGRectMake(0,CGRectGetMaxY(self->dd.frame),self->viewdd.frame.size.width,22);
//        self->cc.font=[UIFont systemFontOfSize:14];
        
    

      
    } completion:^(BOOL finished) {

     


    }];
    self->viewdd.frame=CGRectMake((ScreenWidth-150)/2, 130,150,150);
            self->dd.frame=CGRectMake(0,0,self->viewdd.frame.size.width,22);
            self->dd.font=[UIFont systemFontOfSize:14];
            self->cc.frame=CGRectMake(0,CGRectGetMaxY(self->dd.frame),self->viewdd.frame.size.width,22);
            self->cc.font=[UIFont systemFontOfSize:14];
    
    

    [UIView animateWithDuration:0.2 animations:^{
        //缩放
        //self.imageV.transform = CGAffineTransformMakeScale(0.5, 0.5);
            self->viewdd.transform = CGAffineTransformScale(self->viewdd.transform, 1.1, 1.1);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.1 animations:^{
            self->viewdd.transform = CGAffineTransformIdentity; //回复原始状态
        } completion:^(BOOL finished) {
//            [UIView animateWithDuration:0.08 animations:^{
//                self->view.transform = CGAffineTransformScale(self->view.transform, 1.1, 1.1);
//            } completion:^(BOOL finished) {
////                self->view.transform = CGAffineTransformIdentity; //回复原始状态
//                [UIView animateWithDuration:0.04 animations:^{
//                            self->view.transform = CGAffineTransformIdentity; //回复原始状态
//                    }];
//
//            }];
        }];
    }];
    
    
    
    
    
    
//    // 放大动画
//       [UIView animateWithDuration:0.2 animations:^{
//           self->view.transform = CGAffineTransformMakeScale(1.2, 1.2); //等比放大1.2倍
//       } completion:^(BOOL finished) {
//           // 缩回去动画
//           [UIView animateWithDuration:0.1 animations:^{
//               self->view.transform = CGAffineTransformIdentity; //回复原始状态
//           } completion:^(BOOL finished) {
//               // 放大动画
//               [UIView animateWithDuration:0.08 animations:^{
//                   self->view.transform = CGAffineTransformMakeScale(1.1, 1.1); //等比放大1.1倍
//               } completion:^(BOOL finished) {
//                   // 缩回去动画
//                   [UIView animateWithDuration:0.04 animations:^{
//                       self->view.transform = CGAffineTransformIdentity; //回复原始状态
//                   }];
//               }];
//           }];
//       }];
    
    
    
    
    
}




+ (void)transitformShowView:(UIView *)view hiddenView:(UIView *)toView
{
    view.layer.transform = CATransform3DMakeRotation( M_PI/ 2 , 0, 1, 0);
    toView.layer.transform = CATransform3DMakeRotation( M_PI/ 2 , 0, 0, 0);
    [view.superview bringSubviewToFront:view];

    [UIView animateWithDuration:0.6 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        toView.layer.transform = CATransform3DMakeRotation( M_PI/ 2 , 0, 1, 0);
    } completion:^(BOOL finished) {

        [view.superview bringSubviewToFront:view];

        [UIView animateWithDuration:0.6 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        view.layer.transform = CATransform3DMakeRotation( 0 , 0, 1, 0);
        }completion:nil];

    }];
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
