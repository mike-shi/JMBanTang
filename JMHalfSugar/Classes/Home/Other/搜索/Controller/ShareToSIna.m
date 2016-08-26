//
//  ShareToSIna.m
//  JMHalfSugar
//
//  Created by mike on 16/8/23.
//  Copyright © 2016年 HDCircles. All rights reserved.
//

#import "ShareToSIna.h"
#import "JMProductDetailModel.h"
#import "JMListDetailProductModel.h"
#import "NSObject+AFNetworking.h"
#import "HWAccountTool.h"
#import "MBProgressHUD+MJ.h"
#import "HWOAuthViewController.h"

@interface ShareToSIna ()
@property(nonatomic,strong)UITextView *textView;

@end

@implementation ShareToSIna

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = HWColor(240, 240, 240);
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"发送" style:UIBarButtonItemStylePlain target:self action:@selector(sendTosina)];
    self.title = @"分享到新浪微博";
    UITextView *textView = [[UITextView alloc]init];
    [self.view addSubview:textView];
    _textView = textView;
    textView.sd_layout.topSpaceToView(self.view,10).bottomSpaceToView(self.view,10).leftSpaceToView(self.view,10).rightSpaceToView(self.view,10);
    textView.font = [UIFont systemFontOfSize:13];
    
//    JMProductDetailModel *model = self.detailModel;
    
//    NSLog(@"%@",model.productName);
//    JMListDetailProductModel *detailModel = self.detailModel;
    
    NSString *proName = self.share_title;
    
    NSString *url = self.share_url;
    
    NSString *str = [NSString stringWithFormat:@"%@ %@ (分享自@JMBanTang App)",proName,url];
    
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc]initWithString:str];
    
    [attStr addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:NSMakeRange(proName.length, url.length + 1)];
    
    textView.attributedText = attStr;

    
    
}

-(void)sendTosina{

    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    
    // 2.拼接请求参数
    HWAccount *account = [HWAccountTool account];
    
    if (account == nil) {
        HWOAuthViewController *oauth = [[HWOAuthViewController alloc]init];
        
        [self.navigationController pushViewController:oauth animated:YES];
    }
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = account.access_token;
    params[@"status"] = self.textView.text;
    
    // 3.发送请求
    [mgr POST:@"https://api.weibo.com/2/statuses/update.json" parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self.navigationController popViewControllerAnimated:YES];
        [MBProgressHUD showSuccess:@"发送成功"];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];

}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
