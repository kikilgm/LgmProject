//
//  SIMAvatarTableViewCell.m
//  Kaihuibao
//
//  Created by Ferris on 2017/4/11.
//  Copyright © 2017年 Ferris. All rights reserved.
//

#import "SIMAvatarTableViewCell.h"
#import <UIImageView+WebCache.h>

@interface  SIMAvatarTableViewCell(){
    
    UIImageView* _avatarImageView;
    UILabel* _nickNameLabel;
    UILabel* _mailLabel;
    UILabel* _longLine;
    UILabel* _stortLine;
    UILabel* _phoneLine;
    
}

@end


@implementation SIMAvatarTableViewCell

-(instancetype)init
{
    if(self=[super init])
    {
        CGFloat avatarHeight = 60;
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        self.contentView.backgroundColor = [UIColor whiteColor];
        _avatarImageView = [[UIImageView alloc] init];
        // 这里是self.currentUser.face
        NSString *path =@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1604639595095&di=3198b04228c1f3d3faadcc0683f6748c&imgtype=0&src=http%3A%2F%2Fb-ssl.duitang.com%2Fuploads%2Fitem%2F201706%2F10%2F20170610192627_yhAMN.thumb.700_0.jpeg";
        
        
        [_avatarImageView sd_setImageWithURL:[NSURL URLWithString:path] placeholderImage:[UIImage imageNamed:@"avatar"]];
        _avatarImageView.contentMode = UIViewContentModeScaleAspectFill;
        _avatarImageView.layer.masksToBounds = YES;
        _avatarImageView.layer.cornerRadius = avatarHeight/2.0f;
        [self.contentView addSubview:_avatarImageView];
        [_avatarImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(avatarHeight);
            make.centerY.mas_equalTo(0);
            make.left.mas_equalTo(kWidthScale(15));
        }];
        
        _nickNameLabel = [[UILabel alloc] init];
        _nickNameLabel.font = FontMediumName(15);
        _nickNameLabel.textColor = BlackTextColor;
        NSData *daa  = [[NSUserDefaults standardUserDefaults] objectForKey:@"com.oral.xferris.current.user1"];
        NSString *strin = [[NSString alloc] initWithData:daa encoding:NSUTF8StringEncoding];
        NSData *datastr = [strin dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *dd = [NSJSONSerialization JSONObjectWithData:datastr options:NSJSONReadingMutableLeaves error:nil];
        for (NSString *key in dd) {
            NSLog(@"%@,%@",key,[dd objectForKey:key]);
        }
        _nickNameLabel.text =@"张三丰";// 姓名
        [self.contentView addSubview:_nickNameLabel];
        [_nickNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_avatarImageView.mas_top).offset(3);
            make.left.mas_equalTo(_avatarImageView.mas_right).offset(kWidthScale(15));
            make.right.mas_equalTo(self.contentView.mas_right).offset(-kWidthScale(40));
        }];
        
        _phoneLine = [[UILabel alloc] init];
        _phoneLine.font = FontMediumName(13);
        _phoneLine.textAlignment = NSTextAlignmentCenter;
        _phoneLine.textColor = TableViewHeaderColor;
        _phoneLine.text = @"18765435653";// 电话
        [self.contentView addSubview:_phoneLine];
        [_phoneLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_avatarImageView.mas_right).offset(kWidthScale(15));
            make.bottom.mas_equalTo(_avatarImageView.mas_bottom).offset(-3);
        }];
        
        _mailLabel = [[UILabel alloc] init];
        _mailLabel.font = FontMediumName(13);
        _mailLabel.textAlignment = NSTextAlignmentLeft;
        _mailLabel.text = @"kikilgm@sina.com";// 邮箱
        _mailLabel.textColor = TableViewHeaderColor;
        [self.contentView addSubview:_mailLabel];
        [_mailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_phoneLine.mas_right).offset(kWidthScale(11));
            make.centerY.mas_equalTo(_phoneLine.mas_centerY);
            make.bottom.mas_equalTo(_avatarImageView.mas_bottom).offset(-3);
        }];
        _longLine = [[UILabel alloc] init];
        _longLine.backgroundColor = ZJYColorHex(@"#e5e5e5");
        [self.contentView addSubview:_longLine];
        // 后设置这个短线和长线 根据内容判断 暂时不要短线 因为没有邮箱
        if (_mailLabel.text !=nil) {
            _stortLine = [[UILabel alloc] init];
            _stortLine.backgroundColor = ZJYColorHex(@"#e5e5e5");
            [self.contentView addSubview:_stortLine];
            [_stortLine mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.mas_equalTo(_mailLabel.mas_left).offset(-kWidthScale(5));
                make.width.mas_equalTo(1);
                make.top.mas_equalTo(_mailLabel.mas_top);
                make.bottom.mas_equalTo(_mailLabel.mas_bottom);
            }];
            
            [_longLine mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.mas_equalTo(_avatarImageView.mas_centerY);
                make.left.mas_equalTo(_phoneLine.mas_left);
                make.right.mas_equalTo(_mailLabel.mas_right);
                make.height.mas_equalTo(1);
                
            }];
        }else {
            [_longLine mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.mas_equalTo(_avatarImageView.mas_centerY);
                make.left.mas_equalTo(_phoneLine.mas_left);
                make.width.mas_equalTo(_nickNameLabel.mas_width);
                make.height.mas_equalTo(1);
                
            }];
        }
        
        
    }
    return  self;
}

@end
