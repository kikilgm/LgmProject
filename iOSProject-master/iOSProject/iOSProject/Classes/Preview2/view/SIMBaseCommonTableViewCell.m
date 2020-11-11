//
//  SIMBaseCommonTableViewCell.m
//  Kaihuibao
//
//  Created by Ferris on 2017/4/3.
//  Copyright © 2017年 Ferris. All rights reserved.
//

#import "SIMBaseCommonTableViewCell.h"
#import <UIImageView+WebCache.h>
@implementation SIMBaseCommonTableViewCell
{
    UIImageView* _leftImageView;
    UILabel* _label;
    UILabel* _promptLable;
    UITextField *_putin;
    UIImageView* _avatarImageView;
    UILabel *_iconLabel;
    UIImageView *_selectImg;
    
}

//重写cell init 方法
-(instancetype)init
{
    if(self = [super init])
    {
        self.preservesSuperviewLayoutMargins = NO;
        //分割线从0 开始计算
        //self.separatorInset = UIEdgeInsetsZero;
        if ([self respondsToSelector:@selector(layoutMargins)]) {
            self.layoutMargins = UIEdgeInsetsZero;
        }
        
        //cell的小箭头
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        _leftImageView = [[UIImageView alloc] init];
        
        _label = [[UILabel alloc] init];
        _label.textAlignment = NSTextAlignmentLeft;
        _label.font = [UIFont systemFontOfSize:15];
        _label.textColor = RGB(46, 46, 46);
        
        _promptLable = [[UILabel alloc] init];
        _promptLable.textAlignment  = NSTextAlignmentRight;
        _promptLable.font = [UIFont systemFontOfSize:12];
        _promptLable.textColor = RGB(123, 124, 130);
    }
    return self;
}


-(instancetype)initWithTitle:(NSString *)title leftViewImage:(UIImage *)image
{
    if(self = [self init])
    {
        CGFloat imageHei = 35;
        _leftImageView.image = image;
        [self.contentView addSubview:_leftImageView];
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        _label.text = title;
        _label.textColor = TableViewHeaderColor;
        _label.font = FontRegularName(14);
        [self.contentView addSubview:_label];
        [_leftImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(0);
            make.left.mas_equalTo(15);
            make.height.mas_equalTo(imageHei);
            make.width.mas_equalTo(_leftImageView.mas_height);
        }];
        [_label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(0);
            make.left.mas_equalTo(_leftImageView.mas_right).offset(20);
        }];
    }
    return self;
}

-(instancetype)initWithTitle:(NSString *)title
{
    if(self = [self init]){
//        self.textLabel.text = title;
        _label.text = title;
        _label.font = FontMediumName(16);
        _label.textColor = BlackTextColor;
        [self.contentView addSubview:_label];
        [_label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(0);
            make.left.mas_equalTo(kWidthScale(15));
            make.height.mas_equalTo(30);
        }];
        
        
        
        
    }
    return self;
}


-(instancetype)initWithTitleWithAccessory:(NSString *)title
{
    if(self = [self init]){
        self.accessoryType = UITableViewCellAccessoryNone;
        UILabel *titleLab = [[UILabel alloc] init];
        titleLab.font = FontMediumName(17);
        titleLab.textColor = BlueButtonColor;
        titleLab.text = title;
        titleLab.textAlignment = NSTextAlignmentLeft;
        [self addSubview:titleLab];
        
        [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(0);
            make.left.mas_equalTo(15);
            make.right.mas_equalTo(self.contentView.mas_right).offset(-40);
        }];
        
        
        UIButton *arrow= [UIButton buttonWithType:UIButtonTypeCustom];
        arrow.frame=CGRectMake(screen_width-40, 10, 30, 30);
        [arrow setImage:[UIImage imageNamed:@"gd_left"] forState:UIControlStateNormal];
        [self addSubview:arrow];
    }
    return self;
}
-(instancetype)initWithTitle:(NSString *)title prompt:(NSString *)prompt
{
    if(self = [self initWithTitle:title])
    {
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        _promptLable.text = prompt;
        _promptLable.font = FontRegularName(15);
        _promptLable.textColor = GrayPromptTextColor;
        [self.contentView addSubview:_promptLable];
        
        [_promptLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(0);
            make.right.mas_equalTo(-10);
            make.left.mas_equalTo(screen_width/3);
            make.height.mas_equalTo(30);
        }];
    }
    return self;
}
-(instancetype)initWithTitle:(NSString *)title expalinPrompt:(NSString *)prompt
{
    if(self = [self initWithTitle:title])
    {
        self.accessoryType = UITableViewCellAccessoryNone;
        _promptLable.text = prompt;
        _promptLable.numberOfLines = 0;
        _promptLable.textAlignment = NSTextAlignmentLeft;
        _promptLable.font = FontRegularName(15);
        _promptLable.textColor = GrayPromptTextColor;
        [self.contentView addSubview:_promptLable];
        
//        _promptLable.sd_layout.topSpaceToView(self.contentView, 5).rightSpaceToView(self.contentView, 10).widthIs(screen_width/2).autoHeightRatio(0).minHeightIs(40);
//
//        [self setupAutoHeightWithBottomView:_promptLable bottomMargin:5];
    }
    return self;
}



-(instancetype)initWithTitle:(NSString *)title rightViewImage:(NSURL *)imageurl
{
    if(self = [self initWithTitle:title])
    {
        CGFloat avaterHei = 60;
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        // 这里是self.currentUser.face
        _avatarImageView = [[UIImageView alloc] init];
        [_avatarImageView sd_setImageWithURL:imageurl placeholderImage:[UIImage imageNamed:@"avatar"]];
        _avatarImageView.layer.cornerRadius = avaterHei/2.0;
        _avatarImageView.layer.masksToBounds = YES;
        _avatarImageView.contentMode = UIViewContentModeScaleAspectFill;
        [self.contentView addSubview:_avatarImageView];
        [_avatarImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(0);
            make.right.mas_equalTo(-15);
            make.size.mas_equalTo(avaterHei);
        }];
    }
    return self;
}

-(instancetype)initWithTitle:(NSString *)title putin:(NSString *)putin
{
    if(self = [self initWithTitle:title])
    {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        _putin = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, kWidthScale(200), 40)];
        self.accessoryType = UITableViewCellAccessoryNone;
        _putin.textAlignment = NSTextAlignmentRight;
        _putin.placeholder = @"可选";
        _putin.clearButtonMode = UITextFieldViewModeWhileEditing;
        _putin.textColor = BlackTextColor;
        [_putin setValue:GrayPromptTextColor forKeyPath:@"_placeholderLabel.textColor"];
        [_putin setValue:[UIFont fontWithName:@"PingFangSC-Regular" size:15] forKeyPath:@"_placeholderLabel.font"];
//        [self.contentView addSubview:_putin];
        self.accessoryView = _putin;
//        [_putin mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.centerY.mas_equalTo(0);
//            make.right.mas_equalTo(-15);
//            make.height.mas_equalTo(20);
//            make.left.mas_equalTo(screen_width/2);
//
//        }];
    }
    return self;
}
-(instancetype)initWithTitle:(NSString *)title leftputin:(NSString *)putin
{
    if(self = [self initWithTitle:title])
    {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
//        self.selectionStyle = UITableViewCellSelectionStyleNone;
        _putin = [[UITextField alloc] init];
        self.accessoryType = UITableViewCellAccessoryNone;
        _putin.textAlignment = NSTextAlignmentLeft;
//        _putin.placeholder = @"可选";
//        _putin.clearButtonMode = UITextFieldViewModeWhileEditing;
        _putin.textColor = TableViewHeaderColor;
        _putin.text = putin;
        [self.contentView addSubview:_putin];
        [_putin mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(0);
            make.right.mas_equalTo(-15);
            make.height.mas_equalTo(45);
            make.left.mas_equalTo(_label.mas_right).offset(10);
        }];
    }
    return self;
}

-(instancetype)initWithActionTitle:(NSString *)title
{
    if(self = [self init])
    {
//        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.accessoryType = UITableViewCellAccessoryNone;
        
        _label.textAlignment = NSTextAlignmentCenter;
        _label.font = [UIFont systemFontOfSize:17];
        _label.textColor = [UIColor redColor];
        _label.text = title;
        [self.contentView addSubview:_label];
        [_label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.mas_equalTo(0);
        }];
    }
    return self;
}
-(UIImageView *)leftImageView
{
    return _leftImageView;
}
-(UILabel *)label
{
    return _label;
}
-(UILabel *)promptLabel
{
    return _promptLable;
}
-(UITextField *)putin {
    return _putin;
}
-(UIImageView *)avatarImageView
{
    return _avatarImageView;
}

- (UILabel *)iconLabel {
    return _iconLabel;
}


@end
