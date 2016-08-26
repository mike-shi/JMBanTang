//
//  MKregistView.m
//  JMHalfSugar
//
//  Created by mike on 16/8/23.
//  Copyright © 2016年 HDCircles. All rights reserved.
//

#import "MKregistView.h"
#import <SMS_SDK/SMSSDK.h>
#import "MBProgressHUD+MJ.h"
#import <BmobSDK/Bmob.h>
#import "NSString+Hash.h"
#import "UIWindow+Extension.h"
#define Global_tintColor [UIColor colorWithRed:0 green:(190 / 255.0) blue:(12 / 255.0) alpha:1]
@interface MKregistView ()
@property(nonatomic,weak)UITextField *phoneText;
@property(nonatomic,weak)UITextField *registText;
@property(nonatomic,weak)UITextField *passWordText;

@property(nonatomic,strong)UIButton *yanZhengBtn;

@property(nonatomic,strong)UIButton *RegisteredBtn;

@end

@implementation MKregistView

- (void)viewDidLoad {
    [super viewDidLoad];
  
    [self createUI];
    

    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changeState) name:UITextFieldTextDidChangeNotification object:_phoneText];
    

}

-(void)changeState{
    
        NSString *textPattern = @"^1[3|4|5|7|8][0-9]\\d{8}$";
    
//        _registText.enabled = !_re.enabled;
    
        NSRegularExpression *regular = [[NSRegularExpression alloc]initWithPattern:textPattern options:NSRegularExpressionCaseInsensitive error:nil];
        NSArray *resultArr = [regular matchesInString:_phoneText.text options:NSMatchingReportProgress range:NSMakeRange(0, _phoneText.text.length)];
    
        //    NSLog(@"%@--%lu",_phoneText.text,(unsigned long)resultArr.count);
    
        _yanZhengBtn.enabled = (unsigned long)resultArr.count == 1?YES:NO;
    
//    _yanZhengBtn.enabled = [self isMobileNumberClassification];
}

-(void)createUI{
    self.view.backgroundColor = [UIColor whiteColor];
    // 手机号
    UITextField *phoneText = [[UITextField alloc] initWithFrame:CGRectMake(30, 150, self.view.width-120, 30)];
    phoneText.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    phoneText.keyboardType = UIKeyboardTypeNumberPad;
    phoneText.placeholder = @"手机号";
    [self.view addSubview:phoneText];
    self.phoneText = phoneText;
    
    UIButton *yanZhengBtn = [[UIButton alloc]initWithFrame:CGRectMake(phoneText.width + 60 - 30, 150 , 60, 30)];
    [self.view addSubview:yanZhengBtn];
    [yanZhengBtn bringSubviewToFront:self.view];
    yanZhengBtn.backgroundColor = [UIColor redColor];
    yanZhengBtn.layer.cornerRadius = 10;
    [yanZhengBtn setBackgroundImage:[UIImage imageNamed:@"redBtn"] forState:UIControlStateNormal];
    [yanZhengBtn setBackgroundImage:[UIImage imageNamed:@"grayBtn"] forState:UIControlStateDisabled];
    [yanZhengBtn setTitle:@"验证" forState:UIControlStateNormal];
    [yanZhengBtn addTarget:self action:@selector(getRegist) forControlEvents:UIControlEventTouchUpInside];
    _yanZhengBtn = yanZhengBtn;
    _yanZhengBtn.enabled = NO;
    
    
    //icon
    UIImageView *phoneIcon = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    phoneIcon.image = [UIImage imageNamed:@"label_phone.png"];
    
    phoneText.leftView = phoneIcon;
    phoneText.leftViewMode = UITextFieldViewModeAlways;
    // 线
    UIImageView *phoneImage = [[UIImageView alloc] initWithFrame:CGRectMake(28, 185, self.view.width-56, 1)];
    phoneImage.backgroundColor = [UIColor grayColor];
    phoneImage.alpha = 0.5;
    [self.view addSubview:phoneImage];
    
    
    // 验证码码
    UITextField *registText = [[UITextField alloc] initWithFrame:CGRectMake(30, 215, self.view.width-60, 30)];
    registText.placeholder = @"验证码";
    //    registText.secureTextEntry = YES;
    registText.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    [self.view addSubview:registText];
    self.registText = registText;
    
    //icon
    UIImageView *registWordIcon = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    registWordIcon.image = [UIImage imageNamed:@"irv.png"];
    registText.leftView = registWordIcon;
    registText.leftViewMode = UITextFieldViewModeAlways;
    // 线
    UIImageView *registWordImage = [[UIImageView alloc] initWithFrame:CGRectMake(28, 255, self.view.width-56, 1)];
    registWordImage.backgroundColor = [UIColor grayColor];
    registWordImage.alpha = 0.5;
    [self.view addSubview:registWordImage];
    
    
    UITextField *passWordText = [[UITextField alloc] initWithFrame:CGRectMake(30, 280, self.view.width-60, 30)];
    passWordText.placeholder = @"密码";
    passWordText.secureTextEntry = YES;
    passWordText.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    [self.view addSubview:passWordText];
    self.passWordText = passWordText;
    
    //icon
    UIImageView *passWordIcon = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    passWordIcon.image = [UIImage imageNamed:@"irv.png"];
    passWordText.leftView = passWordIcon;
    passWordText.leftViewMode = UITextFieldViewModeAlways;
    //    passWordIcon.contentMode = UIViewContentModeCenter
    // 线
    UIImageView *passWordImage = [[UIImageView alloc] initWithFrame:CGRectMake(28, 315, self.view.width-56, 1)];
    passWordImage.backgroundColor = [UIColor grayColor];
    passWordImage.alpha = 0.5;
    [self.view addSubview:passWordImage];
    

    // 注册按钮
    UIButton *RegisteredBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [RegisteredBtn setTitle:@"注册" forState:UIControlStateNormal];
    RegisteredBtn.titleLabel.font = [UIFont systemFontOfSize:20];
    RegisteredBtn.frame = CGRectMake(20, self.view.height * 0.56 , self.view.width -40, 40);
    [RegisteredBtn setTitleColor:Global_tintColor forState:UIControlStateNormal];
    RegisteredBtn.layer.cornerRadius = 10;
    RegisteredBtn.layer.borderColor = Global_tintColor.CGColor;
    RegisteredBtn.layer.borderWidth = 1;
    RegisteredBtn.backgroundColor = [UIColor whiteColor];
    [RegisteredBtn addTarget:self action:@selector(RegisteredBtnDidClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:RegisteredBtn];
    self.RegisteredBtn = RegisteredBtn;

    
}

-(void)getRegist{
    
    [SMSSDK getVerificationCodeByMethod:SMSGetCodeMethodSMS phoneNumber:_phoneText.text
                                   zone:@"86"
                       customIdentifier:nil
                                 result:^(NSError *error){
                                     if (!error) {
                                         NSLog(@"获取验证码成功");
                                     } else {
                                         NSLog(@"错误信息：%@",error);
                                     }
                                 }];
    
    __block int timeout= 59; //倒计时时间
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    
    dispatch_source_set_event_handler(_timer, ^{
        
        if(timeout<=0){ //倒计时结束，关闭
            
            dispatch_source_cancel(_timer);
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [_yanZhengBtn setTitle:@"验证" forState:UIControlStateNormal];
                
                _yanZhengBtn.enabled = YES;
                
            });
            
        }else{
            int seconds = timeout % 60;
            
            NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                //设置界面的按钮显示 根据自己需求设置
                
                [UIView beginAnimations:nil context:nil];
                
                [UIView setAnimationDuration:1];
                
                [_yanZhengBtn setTitle:[NSString stringWithFormat:@"%@秒",strTime] forState:UIControlStateDisabled];
                [_yanZhengBtn setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
                
                [UIView commitAnimations];
                
                _yanZhengBtn.enabled = NO;
                
            });
            
            timeout--;
            
        }
        
    });
    
    dispatch_resume(_timer);
    
}

- (void)RegisteredBtnDidClick
    {
        if (self.phoneText.text.length == 0  || self.passWordText.text.length == 0 ||self.registText.text == 0) {
            [MBProgressHUD showError:@"上述均不能为空！"];
            return;
        }
        else if (self.passWordText.text.length < 6) {
            [MBProgressHUD showError:@"密码需要六位以上"];
            return;
        }
        
    [SMSSDK commitVerificationCode:_registText.text phoneNumber:_phoneText.text zone:@"86" result:^(NSError *error) {

        if (!error) {
            NSLog(@"验证成功");


        
//        BmobQuery   *bquery = [BmobQuery queryWithClassName:@"userInfo"];
        
            
            BmobUser *bUser = [[BmobUser alloc] init];
            [bUser setUsername:_phoneText.text];
            NSString *miwen = [[self.passWordText.text md5String] md5String];
            [bUser setPassword:miwen];
            //                    [bUser setObject:@18 forKey:@"age"];
            [bUser signUpInBackgroundWithBlock:^ (BOOL isSuccessful, NSError *error){
                if (isSuccessful){
                    [MBProgressHUD showSuccess:@"注册成功"];
                    
                    [BmobUser loginWithUsernameInBackground:_phoneText.text
                                                   password:miwen];
                    UIWindow *window = [UIApplication sharedApplication].keyWindow;
                    [window switchRootViewController];
                } else {
                    NSLog(@"%@",error);
                }
            }];
            
//        [bquery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
//            for (BmobObject *obj in array) {
//                
//                NSString *exsitPhone = [obj objectForKey:@"phoneNumber"];
//                
//                //                                NSLog(@"%@",exsitPhone);
//                
//                BOOL isEqual = [_phoneText.text isEqualToString:exsitPhone];
//                
//                
//                if (isEqual) {
//                    
//                    [MBProgressHUD showError:@"该手机号已存在"];
//                    return ;
//                }else{

   
//                    BmobObject *userInfo = [BmobObject objectWithClassName:@"userInfo"];
//                    [userInfo setObject:self.phoneText.text forKey:@"phoneNumber"];
//                    NSString *miwen = [[self.passWordText.text md5String] md5String];
//                    [userInfo setObject:miwen forKey:@"passWord"];
//                    
//                    [userInfo saveInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
//                        

//                    }];
                    
                    
//                }
//            }
//        }];
    
    }
    
}];

}


@end
