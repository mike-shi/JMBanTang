//
//  JMSetUpInfo.m
//  JMHalfSugar
//
//  Created by mike on 16/8/24.
//  Copyright © 2016年 HDCircles. All rights reserved.
//

#import "JMSetUpInfo.h"
#import "MIkeItem.h"
#import "MIkeItemGroup.h"
#import "myTableVIewCell.h"
#import "MIkeSwitchItem.h"
#import "MIkeArrowItem.h"
#import "MikeLaberlItem.h"
#import "MBProgressHUD+MJ.h"
#import "ShareToSIna.h"
#import "HWOAuthViewController.h"

#import "JMGenderSelectedViewController.h"
#import "XYBFirstViewController.h"

#import <BmobSDK/Bmob.h>
@interface JMSetUpInfo ()
@property(nonatomic,strong)MikeLaberlItem *clean;
@end

@implementation JMSetUpInfo

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.navigationItem.title = @"设置";
    MIkeItemGroup *group2 = [[MIkeItemGroup alloc]init];
    MIkeArrowItem *share = [MIkeArrowItem iconWithIcon:nil Name:@"分享应用" arrowClass:nil];
    share.option = ^{
    
        ShareToSIna *sina = [[ShareToSIna alloc]init];
        
        sina.share_title = @"每天给自己的生活加半勺糖。半糖，带你逛遍世界好物";
        sina.share_url = @"http://m.bantangapp.com";
        [self.navigationController pushViewController:sina animated:YES];
    
    };

    
    MikeLaberlItem *clean = [MikeLaberlItem iconWithIcon:nil Name:@"清理缓存" arrowClass:nil];
    int byteSize = (int)[SDImageCache sharedImageCache].getSize;
    // M大小
    double size = byteSize / 1000.0 / 1000.0;
    
    clean.title = [NSString stringWithFormat:@"缓存大小(%.1fM)", size];
    self.clean = clean;
    clean.option = ^{
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"清理缓存" message:@"确定清除?" preferredStyle:UIAlertControllerStyleAlert];
        
        
        UIAlertAction *OK = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            [MBProgressHUD showMessage:@"正在清除中，请稍候。。。"];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [[SDImageCache sharedImageCache] clearDisk];
                [MBProgressHUD hideHUD];
                [MBProgressHUD showSuccess:@"清除成功"];
                self.clean.title = [NSString stringWithFormat:@"缓存大小(0M)"];
                [self.tableView reloadData];
            });
            
            
        }];
        
        UIAlertAction *calcle = [UIAlertAction actionWithTitle:@"cancle" style:UIAlertActionStyleCancel handler:nil];
        
        [alert addAction:OK];
        [alert addAction:calcle];
        [self presentViewController:alert animated:YES completion:nil];
 
    };
    group2.array = @[share,clean];
    
  
    [self.dataList addObject:group2];
    
    
    MIkeItemGroup *group1 = [[MIkeItemGroup alloc]init];
    MIkeArrowItem *noti = [MIkeArrowItem iconWithIcon:nil Name:@"个性化设置" arrowClass:[JMGenderSelectedViewController class]];

    MIkeArrowItem *secret = [MIkeArrowItem iconWithIcon:nil Name:@"意见反馈" arrowClass:nil];
    MIkeArrowItem *normallSet = [MIkeArrowItem iconWithIcon:nil Name:@"加入半糖" arrowClass:nil];
    group1.array = @[noti,secret,normallSet];
    
  
    [self.dataList addObject:group1];
    
    
    MIkeItemGroup *group3 = [[MIkeItemGroup alloc]init];

    MIkeSwitchItem *tuiSong = [MIkeSwitchItem iconWithIcon:nil Name:@"推送设置"];
    MIkeArrowItem *join = [MIkeArrowItem iconWithIcon:nil Name:@"微博快捷登录" arrowClass:[HWOAuthViewController class]];
    group3.array = @[join,tuiSong];
    
    
    [self.dataList addObject:group3];
    

    self.tableView.backgroundColor = HWColor(240, 240, 240);
    
    UIButton *btn = [[UIButton alloc]init];
    [btn setTitle:@"退出当前帐号" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(LogOut) forControlEvents:UIControlEventTouchUpInside];
//    btn.y = 15;
    btn.height = 44;
    btn.width = 375;
    
    self.tableView.tableFooterView = btn;
    btn.backgroundColor = [UIColor whiteColor];
    
    self.tableView.bounces = NO;

}

-(void)LogOut{
    

    XYBFirstViewController *first = [[XYBFirstViewController alloc]init];
    
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:first];
    
    [self.navigationController presentViewController:nav animated:YES completion:nil];

    [BmobUser logout];

}



@end
