//
//  ZLRegisteredTextViewController.m
//  光密码锁
//
//  Created by 俞琦 on 15/11/16.
//  Copyright (c) 2015年 俞琦. All rights reserved.
//

#import "XYBRegisteredTextViewController.h"
#import "UIView+Extension.h"
//#import "XYBHttpTool.h"
//#import "XYBAccount.h"
#import "MBProgressHUD+MJ.h"
//#import "CoreConst.h"
#define Global_tintColor [UIColor colorWithRed:0 green:(190 / 255.0) blue:(12 / 255.0) alpha:1]
@interface XYBRegisteredTextViewController ()
@property (nonatomic, weak) UITextField *textText;
@end

@implementation XYBRegisteredTextViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self creatUI];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.textText becomeFirstResponder];
}

- (void)creatUI
{
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"注册";
    
    // 提醒已发送
    UILabel *remindLabel = [[UILabel alloc] init];
    remindLabel.text = @"验证码已发送至手机";
    remindLabel.frame = CGRectMake(0, self.view.height *0.2, self.view.width, 30);
    remindLabel.textColor = [UIColor lightGrayColor];
    remindLabel.font = [UIFont systemFontOfSize:20];
    remindLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:remindLabel];
    
    // 验证码
    UITextField *textText = [[UITextField alloc] initWithFrame:CGRectMake(30, self.view.height *0.3, self.view.width-60, 30)];
    textText.keyboardType = UIKeyboardTypeNumberPad;
    textText.placeholder = @"请输入验证码";
    [self.view addSubview:textText];
    self.textText = textText;
    
    //icon
    UIImageView *textIcon = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 25, 25)];
    textIcon.image = [UIImage imageNamed:@"irv.png"];
    textText.leftView = textIcon;
    textText.leftViewMode = UITextFieldViewModeAlways;
    // 线
    UIImageView *textImage = [[UIImageView alloc] initWithFrame:CGRectMake(28, self.view.height *0.3+textText.height, self.view.width-56, 1)];
    textImage.backgroundColor = [UIColor grayColor];
    textImage.alpha = 0.5;
    [self.view addSubview:textImage];
    
    UIButton *warnBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    warnBtn.frame = CGRectMake(0, textText.y + 40, self.view.width, 20);
    [warnBtn setTitle:@"验证码没收到？" forState:UIControlStateNormal];
    [warnBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    warnBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [self.view addSubview:warnBtn];
    
    // 注册按钮
    UIButton *RegisteredBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [RegisteredBtn setTitle:@"注册" forState:UIControlStateNormal];
    RegisteredBtn.titleLabel.font = [UIFont systemFontOfSize:20];
    RegisteredBtn.frame = CGRectMake(20, self.view.height * 0.45 , self.view.width -40, 40);
    [RegisteredBtn setTitleColor:Global_tintColor forState:UIControlStateNormal];
    RegisteredBtn.layer.cornerRadius = 10;
    RegisteredBtn.layer.borderColor = Global_tintColor.CGColor;
    RegisteredBtn.layer.borderWidth = 1;
    RegisteredBtn.backgroundColor = [UIColor whiteColor];
    [RegisteredBtn addTarget:self action:@selector(RegisteredBtnDidClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:RegisteredBtn];
}


- (void)RegisteredBtnDidClick
{
  //    [XYBHttpTool post:url params:para success:^(id responseObj) {
//        [MBProgressHUD hideHUD];
//        NSString *statusStr = responseObj[@"status"];
//        int status = statusStr.intValue;
//        if (status == 5) {
//            [MBProgressHUD showError:@"验证码错误，请输入正确的验证码"];
//        } else if (status == 6) {
//            [MBProgressHUD showError:@"验证码超时，请重新发送"];
//        } else if (status == 7) {
//            [MBProgressHUD showError:@"注册超时，请重新注册"];
//        } else {
//            [MBProgressHUD showSuccess:@"注册成功"];
//            XYBRegisteredSuccessViewController *successVc = [[XYBRegisteredSuccessViewController alloc] init];
//            [self.navigationController pushViewController:successVc animated:YES];
//        }
//
//    } failure:^(NSError *error) {
//        [MBProgressHUD hideHUD];
//        [MBProgressHUD showError:@"连接超时，请稍后重试"];
//    }];
}


@end
