//
//  ZLLoginViewController.m
//  光密码锁
//
//  Created by 俞琦 on 15/11/15.
//  Copyright (c) 2015年 俞琦. All rights reserved.
//

#import "XYBLoginViewController.h"

#import "MBProgressHUD+MJ.h"
#import "JMMainViewController.h"


#define Global_tintColor [UIColor colorWithRed:0 green:(190 / 255.0) blue:(12 / 255.0) alpha:1]


@interface XYBLoginViewController ()
@property (nonatomic, weak) UITextField *phoneText;
@property (nonatomic, weak) UITextField *passWordText;
@end

@implementation XYBLoginViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self creatUI];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(windowDidClick)];
    [self.view addGestureRecognizer:tap];
    
    // 当键盘的frame改变的时候，self.view的frame也改变
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
}

- (void)creatUI
{
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"登陆";
    
    // 从本地获得account


    
    // 手机号
    UITextField *phoneText = [[UITextField alloc] initWithFrame:CGRectMake(30, 100, self.view.width-60, 30)];
    phoneText.clearButtonMode = UITextFieldViewModeWhileEditing;
  
    phoneText.keyboardType = UIKeyboardTypeNumberPad;
    phoneText.placeholder = @"请输入手机号码";
    [self.view addSubview:phoneText];
    self.phoneText = phoneText;
        
        //icon
        UIImageView *phoneIcon = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 25, 25)];
        phoneIcon.image = [UIImage imageNamed:@"label_phone.png"];
        phoneText.leftView = phoneIcon;
        phoneText.leftViewMode = UITextFieldViewModeAlways;
        // 线
        UIImageView *phoneImage = [[UIImageView alloc] initWithFrame:CGRectMake(28, 135, self.view.width-56, 1)];
        phoneImage.backgroundColor = [UIColor grayColor];
        phoneImage.alpha = 0.5;
        [self.view addSubview:phoneImage];
    
    
    
    // 密码
    UITextField *passWordText = [[UITextField alloc] initWithFrame:CGRectMake(30, 160, self.view.width-60, 30)];
    passWordText.placeholder = @"请输入正确密码";
    passWordText.secureTextEntry = YES;
    passWordText.clearButtonMode = UITextFieldViewModeWhileEditing;
 
    [self.view addSubview:passWordText];
    self.passWordText = passWordText;
    
        //icon
        UIImageView *passWordIcon = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 25, 25)];
        passWordIcon.image = [UIImage imageNamed:@"irv.png"];
        passWordText.leftView = passWordIcon;
        passWordText.leftViewMode = UITextFieldViewModeAlways;
        // 线
        UIImageView *passWordImage = [[UIImageView alloc] initWithFrame:CGRectMake(28, 195, self.view.width-56, 1)];
        passWordImage.backgroundColor = [UIColor grayColor];
        passWordImage.alpha = 0.5;
        [self.view addSubview:passWordImage];
    
    
    // 登录
    UIButton *loginBtn = [UIButton buttonWithType:0];
    loginBtn.frame = CGRectMake(20, self.view.height *0.5, self.view.width-40, 40);
    [loginBtn setTitle:@"登录" forState:0];
    loginBtn.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:loginBtn];
    loginBtn.clipsToBounds = YES;
    [loginBtn setTitleColor:Global_tintColor forState:UIControlStateNormal];
    loginBtn.layer.cornerRadius = 10;
    loginBtn.layer.borderColor = Global_tintColor.CGColor;
    loginBtn.layer.borderWidth = 1;
    [loginBtn addTarget:self action:@selector(loginBtnClick) forControlEvents:UIControlEventTouchUpInside];

    // 忘记密码
    UIButton *forgetBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    forgetBtn.frame = CGRectMake(20, self.view.height - 40, 50, 20);
    [forgetBtn setTitle:@"忘记密码" forState:UIControlStateNormal];
    forgetBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [forgetBtn setTitleColor:Global_tintColor forState:UIControlStateNormal];
    [self.view addSubview:forgetBtn];
    
    // 新用户
    UIButton *newBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    newBtn.frame = CGRectMake(self.view.width - 70, self.view.height - 40, 50, 20);
    [newBtn setTitle:@"新用户" forState:UIControlStateNormal];
    newBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [newBtn addTarget:self action:@selector(newAccountDidClick) forControlEvents:UIControlEventTouchUpInside];
    [newBtn setTitleColor:Global_tintColor forState:UIControlStateNormal];
    [self.view addSubview:newBtn];
    
    
} 

// 点击登陆按钮
- (void)loginBtnClick
{
    
//    [MBProgressHUD showMessage:@"正在加载中..."];
//    NSString *phoneNum = self.phoneText.text;
//    NSString *passWord = self.passWordText.text;
//    
//    NSDictionary *para = @{ @"PhoneNumber": phoneNum,
//                            @"Password": passWord};
//
//    NSString *url = [NSString stringWithFormat:@"%@LoginUser",textURL];
//
//    [XYBHttpTool post:url params:para success:^(id responseObj) {
//        // 获取服务器返回的信息
//        NSString *statusStr = responseObj[@"status"];
//        int status = statusStr.intValue;
//        if (status == 0) { // 登陆成功
//            [MBProgressHUD hideHUD];
//            NSDictionary *userDic = responseObj[@"user"];
//            XYBAccount *account = [XYBAccountTool returnAccountWithDic:userDic];
//            [XYBAccountTool save:account];
//            UIWindow *window = [UIApplication sharedApplication].keyWindow;
//            XYBTabBarViewController *tabbar = [[XYBTabBarViewController alloc] init];
//            window.rootViewController = tabbar;
//            [XYBSavingTool setBool:YES key:isLogin];
//        } else if (status == 2){
//            [MBProgressHUD hideHUD];
//            [MBProgressHUD showError:@"无该手机号，请输入正确手机号"];
//        } else {
//            [MBProgressHUD hideHUD];
//            [MBProgressHUD showError:@"密码错误，请输入正确密码"];
//        }
//    } failure:^(NSError *error) {
//        NSLog(@"%@", error);
//        [MBProgressHUD hideHUD];
//        [MBProgressHUD showError:@"连接超时，请稍后重试"];
//    }];
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    JMMainViewController *tabbar = [[JMMainViewController alloc] init];
    window.rootViewController = tabbar;
}


- (void)windowDidClick
{
    [self.phoneText resignFirstResponder];
    [self.passWordText resignFirstResponder];
}



- (void)newAccountDidClick
{
//    [self.navigationController pushViewController:[[XYBRegisteredAllViewController alloc] init] animated:YES];
}

- (void)keyboardWillChangeFrame:(NSNotification *)noti
{
    //改变window的背景颜色
    self.view.window.backgroundColor = [UIColor whiteColor];
    
    //最终键盘的frame
    CGRect frame = [noti.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    //键盘实时y
    CGFloat keyY = frame.origin.y;
    
    //屏幕的高度
    CGFloat screenH = [[UIScreen mainScreen] bounds].size.height;
    
    //动画时间
    CGFloat keyDuration = [noti.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
    
    //执行动画
    [UIView animateWithDuration:keyDuration animations:^{
        self.view.transform = CGAffineTransformMakeTranslation(0, (keyY - screenH)/5);
    }];
}

@end
