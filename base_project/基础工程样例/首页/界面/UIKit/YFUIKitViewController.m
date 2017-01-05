//
//  YFUIKitViewController.m
//  base_project
//
//  Created by zyh on 17/1/4.
//  Copyright © 2017年 jangbuk. All rights reserved.
//

#import "YFUIKitViewController.h"
#import "YFUIButton.h"
#import "YFTextField.h"

@interface YFUIKitViewController ()

@property (weak, nonatomic) IBOutlet YFUIButton *cornerRadiusBtn;

@property (weak, nonatomic) IBOutlet YFUIButton *roundedRectBtn;

@property (weak, nonatomic) IBOutlet YFTextField *leftViewTextField;
@property (weak, nonatomic) IBOutlet YFTextField *underLineTextField;
@property (weak, nonatomic) IBOutlet YFTextField *textField;

@end

@implementation YFUIKitViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupButton];
    
    [self setupTextField];
}

- (void)setupButton
{
    [self.cornerRadiusBtn setButtonCornerRadius:10.0 borderColor:[UIColor blackColor] andBorderWidth:0.1];
    
    [self.roundedRectBtn setButtonCornerRadius:20.0 borderColor:[UIColor blackColor] andBorderWidth:0.1];
}

- (void)setupTextField
{
    // 输入手机号
    [self.leftViewTextField setYFTextFieldBorderStyle:YFTextFieldBorderStyleCustomRoundedRect];
    [self.leftViewTextField setYFTextFieldWithBorderCornerRadius:20.0];
    [self.leftViewTextField setYFTextFieldWithLeftViewText:@"手机号" spacing:10.0 textFont:[UIFont systemFontOfSize:16.0] andTextColor:[UIColor darkGrayColor]];
    [self.leftViewTextField setYFTextFieldWithBorderLineColor:[UIColor blackColor] andWidth:0.2];
    [self.leftViewTextField setYFTextFieldWithPlaceholderText:@"请输入手机号" alignment:YFTextAlignmentLeft textFont:[UIFont systemFontOfSize:15.0] andTextColor:[UIColor lightGrayColor]];
    
    // 输入邮箱
    [self.textField setYFTextFieldBorderStyle:YFTextFieldBorderStyleUnderLine];
    [self.textField setYFTextFieldWithLeftViewText:@"邮箱" spacing:10.0 textFont:[UIFont systemFontOfSize:16.0] andTextColor:[UIColor darkGrayColor]];
    [self.textField setYFTextFieldWithPlaceholderText:@"请输入邮箱" alignment:YFTextAlignmentRight textFont:[UIFont systemFontOfSize:15.0] andTextColor:[UIColor lightGrayColor]];
    [self.textField setYFTextFieldWithBorderLineColor:[UIColor blackColor] andWidth:0.5];

    
    // 输入密码
    [self.underLineTextField setYFTextFieldBorderStyle:YFTextFieldBorderStyleUnderLine];
    [self.underLineTextField setYFTextFieldWithBorderLineColor:[UIColor blackColor] andWidth:0.5];
    [self.underLineTextField setYFTextFieldWithLeftViewImage:[UIImage imageNamed:@"psw"] spacing:10.0 imageWH:CGSizeMake(30, 30)];
    [self.underLineTextField setYFTextFieldWithPlaceholderText:@"请输入密码" alignment:YFTextAlignmentLeft textFont:[UIFont systemFontOfSize:16.0] andTextColor:[UIColor lightGrayColor]];
    
}

@end
