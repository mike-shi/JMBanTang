//
//  ReGetPwd.m
//  JMHalfSugar
//
//  Created by mike on 16/8/25.
//  Copyright © 2016年 HDCircles. All rights reserved.
//

#import "ReGetPwd.h"
#import <SMS_SDK/SMSSDK.h>
#import "MBProgressHUD+MJ.h"
@interface ReGetPwd ()
@property(nonatomic,weak)UITextField *phoneText;
@property(nonatomic,weak)UITextField *registText;


@property(nonatomic,strong)UIButton *yanZhengBtn;

@property(nonatomic,strong)UIButton *nextdBtn;
@end

@implementation ReGetPwd

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createUI];
    
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changeState) name:UITextFieldTextDidChangeNotification object:_phoneText];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changNextBtn) name:UITextFieldTextDidChangeNotification object:_registText];
    
    // Do any additional setup after loading the view.
}

-(void)changNextBtn{

    _nextdBtn.enabled = ( _registText.text.length == 4 )?YES : NO;
}

-(void)changeState{
    
    NSString *textPattern = @"^1[3|4|5|7|8][0-9]\\d{8}$";

    
    NSRegularExpression *regular = [[NSRegularExpression alloc]initWithPattern:textPattern options:NSRegularExpressionCaseInsensitive error:nil];
    NSArray *resultArr = [regular matchesInString:_phoneText.text options:NSMatchingReportProgress range:NSMakeRange(0, _phoneText.text.length)];

    
    _yanZhengBtn.enabled = (unsigned long)resultArr.count == 1?YES:NO;
    
    
//    当_yanZhengBtn为enable 且_registText的text 的length> 3 时，下一步btn 
 

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
    
    
    UIButton *nextdBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [nextdBtn setTitle:@"下一步" forState:UIControlStateNormal];
    nextdBtn.titleLabel.font = [UIFont systemFontOfSize:20];

    
    [nextdBtn setBackgroundImage:[UIImage imageNamed:@"grayBtn"] forState:UIControlStateDisabled];
    [nextdBtn setBackgroundImage:[UIImage imageNamed:@"redBtn"] forState:UIControlStateNormal];
    nextdBtn.layer.cornerRadius = 10;

    [nextdBtn addTarget:self action:@selector(RegisteredBtnDidClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nextdBtn];
    nextdBtn.layer.cornerRadius = 10;
    nextdBtn.imageView.layer.cornerRadius = 10;
    nextdBtn.imageView.layer.masksToBounds = YES;
    self.nextdBtn = nextdBtn;
    _nextdBtn.sd_layout.topSpaceToView(_registText,50).centerXEqualToView(self.view).leftSpaceToView(self.view,28).rightSpaceToView(self.view,28).heightIs(40);
    _nextdBtn.enabled = NO;
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

    
    [SMSSDK commitVerificationCode:_registText.text phoneNumber:_phoneText.text zone:@"86" result:^(NSError *error) {
        
        if (!error) {
            NSLog(@"验证成功");
        }
        
        
    }];
    
}

@end
