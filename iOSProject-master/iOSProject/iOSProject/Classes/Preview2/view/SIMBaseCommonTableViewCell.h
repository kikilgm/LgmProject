//
//  SIMBaseCommonTableViewCell.h
//  Kaihuibao
//
//  Created by Ferris on 2017/4/3.
//  Copyright © 2017年 Ferris. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SIMBaseCommonTableViewCell : UITableViewCell
@property (strong,nonatomic,readonly) UIImageView* leftImageView;
@property (strong,nonatomic,readonly) UIImageView* avatarImageView;
@property (strong,nonatomic,readonly) UIImageView* deviceImageView;
@property (strong,nonatomic,readonly) UILabel* label;
@property (strong,nonatomic,readonly) UILabel* promptLabel;
@property (strong,nonatomic,readonly) UILabel* iconLabel;
@property (strong,nonatomic,readonly) UITextField *putin;
-(instancetype)initWithTitle:(NSString*)title leftViewImage:(UIImage*)image;
-(instancetype)initWithTitle:(NSString*)title;
-(instancetype)initWithTitle:(NSString*)title prompt:(NSString*)prompt;
-(instancetype)initWithActionTitle:(NSString*)title;
-(instancetype)initWithTitle:(NSString *)title putin:(NSString *)putin;
-(instancetype)initWithTitle:(NSString *)title rightViewImage:(NSURL *)imageurl;
-(instancetype)initWithTitle:(NSString *)title expalinPrompt:(NSString *)prompt;
-(instancetype)initWithTitle:(NSString *)title leftputin:(NSString *)putin;
-(instancetype)initWithTitleWithAccessory:(NSString *)title;

@end
