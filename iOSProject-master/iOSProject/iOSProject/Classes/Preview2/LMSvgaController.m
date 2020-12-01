//
//  LMSvgaController.m
//  iOSProject
//
//  Created by lgm on 2020/11/30.
//  Copyright © 2020 github.com/njhu. All rights reserved.
//

#import "LMSvgaController.h"
#import "SVGAParser.h"
#import <SVGAPlayer/SVGAPlayer.h>
#import <SVGA.h>
#import "SVGA.h"

@interface LMSvgaController ()<SVGAPlayerDelegate>

@property (nonatomic, strong) SVGAPlayer *player;
@end

@implementation LMSvgaController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=@"SVGA动画";
    // Do any additional setup after loading the view.

    SVGAPlayer *player = [[SVGAPlayer alloc] init];
    //循环播放几次
    player.loops=5;

    [self.view addSubview:player]; // Add subview by yourself.
    [player mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(@0);
        make.top.equalTo(@100);
        make.height.equalTo(@500);
    }];
    

    SVGAParser *parser = [[SVGAParser alloc] init];
    [parser parseWithNamed:@"posche" inBundle:[NSBundle mainBundle] completionBlock:^(SVGAVideoEntity * _Nonnull videoItem) {
        
        if(videoItem !=nil) {
            player.videoItem= videoItem;
            [player startAnimation];

        }

    } failureBlock:^(NSError*_Nonnullerror) {
        NSLog(@"%@",_Nonnullerror);
    }];

    

    
    
//[parser parseWithURL:[NSURL URLWithString:@"https://github.com/yyued/SVGA-Samples/blob/master/posche.svga?raw=true"] completionBlock:^(SVGAVideoEntity * _Nullable videoItem) {
//            if (videoItem != nil) {
//                player.videoItem = videoItem;
//                [player startAnimation];
//            }
//        } failureBlock:^(NSError*_Nonnullerror) {
//
//                    NSLog(@"%@",_Nonnullerror);
//        }];

    
    


}



-(void)creatUI{
    
    
    
    UIView *backview=[[UIView alloc]initWithFrame:CGRectMake(0,100,400,400)];
    backview.backgroundColor=[UIColor redColor];
    [self.view addSubview:backview];
    
    
    

    UIButton *btn=[[UIButton alloc]initWithFrame:CGRectMake(0,550,100,44)];
    [self.view addSubview:btn];
    [btn setTitle:@"点击执行" forState:UIControlStateNormal];
    [btn setBackgroundColor:[UIColor orangeColor]];
    [btn addTarget:self action:@selector(LoadBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    
    self.player = [[SVGAPlayer alloc] initWithFrame:CGRectMake(0,0 ,200,200)];
    self.player.backgroundColor =[UIColor grayColor];

   [backview addSubview:self.player];

    self.player.delegate=self;

    //动画循环次数 默认是0(无限次)

    self.player.loops=0;

    //动画停止后清除画布。 默认是true

    self.player.clearsAfterStop = true;

    //默认为Forward。可能是Forward，Backward。Forward 表示动画将在完成后在最后一帧暂停。Backward 表示动画将在完成后在第一帧暂停。

//    self.player.fillMode=@"Forward";

    //设置第一帧结束的时候触发

   //    [self svgaPlayerDidAnimatedToFrame:1];

    //当图片百分比出现的时候触发

   //    [self svgaPlayerDidAnimatedToPercentage:1.0];
    
}





//本地资源

-(void)LoadBtn:(id)sender {

 //先停止动画

[self.player stopAnimation];

 //Angel 是本地格式为svga 的文件

    SVGAParser * parser = [[SVGAParser alloc]init];

[parser parseWithNamed:@"kingset" inBundle:[NSBundle mainBundle]  completionBlock:^(SVGAVideoEntity * _Nonnull videoItem) {

 if(videoItem !=nil) {

            self.player.videoItem= videoItem;
            [self.player startAnimation];

        }

}failureBlock:^(NSError*_Nonnullerror) {
    NSLog(@"%@",_Nonnullerror);
    }];
    
    
    
    
//    NSURL *url1=[NSURL URLWithString: @"https://github.com/yyued/SVGA-Samples/blob/master/angel.svga?raw=true"];
//
//
//    [parser parseWithURL:url1 completionBlock:^(SVGAVideoEntity * _Nullable videoItem) {
//        if(videoItem !=nil) {
//
//                   self.player.videoItem= videoItem;
//                   [self.player startAnimation];
//
//               }
//
//    } failureBlock:^(NSError * _Nullable error) {
//
//    }];
    
    
    

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



/**

 这些方法暂时不清楚怎么使用

 //在特定范围内播放动画。如果reverse设置为true，则动画将从end开始反向开始。

 - (void)startAnimationWithRange:(NSRange)range reverse:(BOOL)reverse;

 //渲染特定帧，如果andPlay设置为，则从此帧播放true

 - (void)stepToFrame:(NSInteger)frame andPlay:(BOOL)andPlay;

 //渲染特定百分比架，percentage价值应0.0到1.0，从这个框架，如果玩andPlay套到true

 - (void)stepToPercentage:(CGFloat)percentage andPlay:(BOOL)andPlay;

 */



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
