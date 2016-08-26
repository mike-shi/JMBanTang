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
#import <BmobSDK/Bmob.h>
#import "NSString+Hash.h"
#import "UIWindow+Extension.h"
#import "ReGetPwd.h"
#import "MKregistView.h"
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
    [forgetBtn addTarget:self action:@selector(forgetMiMa) forControlEvents:UIControlEventTouchUpInside];
    
    // 新用户
    UIButton *newBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    newBtn.frame = CGRectMake(self.view.width - 70, self.view.height - 40, 50, 20);
    [newBtn setTitle:@"新用户" forState:UIControlStateNormal];
    newBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [newBtn addTarget:self action:@selector(newAccountDidClick) forControlEvents:UIControlEventTouchUpInside];
    [newBtn setTitleColor:Global_tintColor forState:UIControlStateNormal];
    [self.view addSubview:newBtn];
    
    
} 

-(void)forgetMiMa{

    ReGetPwd *getPwd = [[ReGetPwd alloc]init];
    
    [self.navigationController pushViewController:getPwd animated:YES];
    

}
// 点击登陆按钮
- (void)loginBtnClick
{

  [self windowDidClick];
    
//    + (void)loginWithUsernameInBackground:(NSString *)username
////password:(NSString *)password
//block:(BmobUserResultBlock)block;
                NSString *currentMiWen = [[_passWordText.text md5String] md5String];
    [BmobUser loginWithUsernameInBackground:_phoneText.text password:currentMiWen block:^(BmobUser *user, NSError *error) {
       
        if (user) {
            NSLog(@"%@",user);
                                UIWindow *window = [UIApplication sharedApplication].keyWindow;
                                [window switchRootViewController];
        } else {
            NSLog(@"%@",error);
                            [MBProgressHUD showError:@"用户名或密码错误"];
        }
        
    }];
    
//    BmobQuery  *bquery = [BmobQuery queryWithClassName:@"userInfo"];
//    
//    [bquery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
//        for (BmobObject *obj in array) {
//            
//            NSString *exsitPhone = [obj objectForKey:@"phoneNumber"];
//            
//            NSString *existPwd = [obj objectForKey:@"passWord"];
//            
//            NSString *currentMiWen = [[_passWordText.text md5String] md5String];
//            
//            BOOL isEuqalMima = [currentMiWen isEqualToString:existPwd];
//            
//            BOOL isEqualPhone = [_phoneText.text isEqualToString:exsitPhone];
//            
//            
//            
//            if (isEqualPhone && isEuqalMima) {
//                
//                    UIWindow *window = [UIApplication sharedApplication].keyWindow;
//                    [window switchRootViewController];
//              
////                return ;
//            }else{
//
//                [MBProgressHUD showError:@"用户名或密码错误"];
//            }
//        }
//    }];


    

}


- (void)windowDidClick
{
    [self.phoneText resignFirstResponder];
    [self.passWordText resignFirstResponder];
}



- (void)newAccountDidClick
{
    MKregistView *regist = [[MKregistView alloc]init];
    [self.navigationController pushViewController:regist animated:YES];
    
    
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
