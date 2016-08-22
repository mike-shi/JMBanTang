//
//  ZLFirstViewController.m
//  光密码锁
//
//  Created by 俞琦 on 15/11/15.
//  Copyright (c) 2015年 俞琦. All rights reserved.
//

#import "XYBFirstViewController.h"
#import "UIView+Extension.h"
#import "XYBLoginViewController.h"
#import "MKregistView.h"
//#import "XYBRegisteredAllViewController.h"



@interface XYBFirstViewController ()
@property (nonatomic, strong) UIButton *LoginBtn;
@property (nonatomic, strong) UIButton *RegisteredBtn;
@end

@implementation XYBFirstViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 导航栏透明
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    
    UIImageView *imageview = [[UIImageView alloc] init];
    imageview.frame = self.view.bounds;
    imageview.image = [UIImage imageNamed:@"BgImage"];
    [self.view addSubview:imageview];
    
    UIButton *LoginBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [LoginBtn setTitle:@"登陆" forState:UIControlStateNormal];
    LoginBtn.titleLabel.font = [UIFont systemFontOfSize:20];
    LoginBtn.frame = CGRectMake(self.view.width, self.view.height * 0.8 , self.view.width/2 -20, 50);
    [LoginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    LoginBtn.layer.cornerRadius = 10;
    LoginBtn.layer.borderColor = [UIColor whiteColor].CGColor;
    LoginBtn.layer.borderWidth = 1;
    [LoginBtn addTarget:self action:@selector(LoginBtnDidClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:LoginBtn];
    self.LoginBtn = LoginBtn;
    
        
    UIButton *RegisteredBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [RegisteredBtn setTitle:@"注册" forState:UIControlStateNormal];
    RegisteredBtn.titleLabel.font = [UIFont systemFontOfSize:20];
    RegisteredBtn.frame = CGRectMake(-(self.view.width/2 -20), self.view.height * 0.8 , self.view.width/2 -20, 50);
    [RegisteredBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    RegisteredBtn.layer.cornerRadius = 10;
    RegisteredBtn.layer.borderColor = [UIColor whiteColor].CGColor;
    RegisteredBtn.layer.borderWidth = 1;
    [RegisteredBtn addTarget:self action:@selector(RegisteredBtnDidClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:RegisteredBtn];
    self.RegisteredBtn = RegisteredBtn;
    
}

- (void)viewDidAppear:(BOOL)animated
{

    
    [UIView animateWithDuration:1.0 delay:0.5 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.LoginBtn.frame = CGRectMake(self.view.width/2 +10, self.view.height * 0.8 , self.view.width/2 -20, 50);
        self.RegisteredBtn.frame = CGRectMake(10, self.view.height * 0.8 , self.view.width/2 -20, 50);
    } completion:^(BOOL finished) {
        
    }];
}

- (void)LoginBtnDidClick
{
    XYBLoginViewController *loginVc = [[XYBLoginViewController alloc] init];
    [self.navigationController pushViewController:loginVc animated:YES];
}
//
- (void)RegisteredBtnDidClick
{
    MKregistView *registeredVc = [[MKregistView alloc] init];
    [self.navigationController pushViewController:registeredVc animated:YES];
}

@end
