//
//  JMWebView.m
//  JMHalfSugar
//
//  Created by mike on 16/8/23.
//  Copyright © 2016年 HDCircles. All rights reserved.
//

#import "JMWebView.h"
#import "MBProgressHUD+MJ.h"
@interface JMWebView ()<UIWebViewDelegate>
@property(nonatomic,strong)UIWebView *webView;

@end

@implementation JMWebView

-(void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    
//    [self.navigationController setNavigationBarHidden:NO];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // 1.创建一个webView
    UIWebView *webView = [[UIWebView alloc] init];
    webView.frame = self.view.bounds;
    webView.delegate = self;
    [self.view addSubview:webView];
    _webView = webView;

    NSURL *url = [NSURL URLWithString:self.url];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [MBProgressHUD hideHUDForView:_webView animated:YES];
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [MBProgressHUD showHUDAddedTo:_webView animated:YES];
    
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [MBProgressHUD hideHUDForView:_webView animated:YES];

    [MBProgressHUD showError:@"亲，你的网络不给力哦"];
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
