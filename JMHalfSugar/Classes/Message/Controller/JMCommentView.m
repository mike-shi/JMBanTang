//
//  JMCommentView.m
//  JMHalfSugar
//
//  Created by mike on 16/8/24.
//  Copyright © 2016年 HDCircles. All rights reserved.
//

#import "JMCommentView.h"

@interface JMCommentView ()

@end

@implementation JMCommentView

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.view.backgroundColor = HWColor(240, 240, 240);
    UIImageView *bgImgae = [[UIImageView alloc]initWithFrame:self.view.bounds];
    bgImgae.height = self.view.height - 100 ;
    [self.view addSubview:bgImgae];
    bgImgae.image = [UIImage imageNamed:@"nomessage"];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
