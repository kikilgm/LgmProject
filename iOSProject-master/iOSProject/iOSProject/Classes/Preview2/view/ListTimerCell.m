//
//  ListTimerCell.m
//  iOSProject
//
//  Created by lgm on 2020/12/11.
//  Copyright © 2020 github.com/njhu. All rights reserved.
//

#import "ListTimerCell.h"

@interface ListTimerCell(){
    UIImageView *hedaImg;// 商品图片
    UILabel *titleLb; //商品标题
}

@end





@implementation ListTimerCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    // Initialization code
}




-(void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}




-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self initUI];
    }
    return self;
}





-(void)initUI{
    
    hedaImg=[[UIImageView alloc]init];
    hedaImg.backgroundColor=[UIColor redColor];
    [self.contentView addSubview:hedaImg];
    [hedaImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@5);
        make.left.equalTo(@5);
        make.bottom.equalTo(@-5);
        make.width.equalTo(@100);
        make.centerY.equalTo(self);
        make.height.equalTo(@100);
        
    }];
    
    titleLb=[[UILabel alloc]init];
    titleLb.text=@"de";
    titleLb.backgroundColor=[UIColor orangeColor];
    [self.contentView addSubview:titleLb];
    [titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(hedaImg.mas_right).offset(15);
        make.top.equalTo(@10);
        make.width.mas_greaterThanOrEqualTo(50); // 设置最小宽度
        make.right.mas_lessThanOrEqualTo(self.contentView.mas_right).offset(-10);  // 设置距离右边最小距离

    }];
    
    [titleLb setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];

    self.titleLb1=titleLb;
    
    
    
    
}




@end
