//
//  MikeNewFeature.m
//  微博项目
//
//  Created by mike on 16/6/17.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "MikeNewFeature.h"
#import "JMMainViewController.h"
//#import "UIFindDocumentPath.h"

#define PageNumber 3
@interface MikeNewFeature ()<UIScrollViewDelegate>
@property(nonatomic,strong)UIPageControl *pageC;
@property(nonatomic,strong)UIScrollView *scr;
@property(nonatomic,strong)UIButton *checkBox;
@property(nonatomic,strong)UIButton *startBtn;
@property(nonatomic,strong)NSTimer  *time;
@end


@implementation MikeNewFeature

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIScrollView *scroll=[[UIScrollView alloc]init];
    [self.view addSubview:scroll];
    scroll.size=self.view.size;
    scroll.delegate=self;
    _scr=scroll;
    CGFloat scrW=scroll.width;
    CGFloat scrH=scroll.height;
    scroll.contentSize=CGSizeMake(scrW*PageNumber, 0);
    scroll.bounces=NO;
    scroll.pagingEnabled=YES;
    scroll.showsHorizontalScrollIndicator=NO;
    
    NSArray *arr = @[@"引导1_2208_1242x2208_@1x",@"引导2_2208_1242x2208_@1x",@"引导3_2208_1242x2208_@1x"];
    
    for (int i=0; i<PageNumber; i++) {
        UIImageView *image=[[UIImageView alloc]init];
       
        [scroll addSubview:image];
        image.width=scrW;
        image.height=scrH;
        image.x=i*scrW;
        image.y=0;
//        NSString *imgName=[NSString stringWithFormat:arr[i]];
        image.image=[UIImage imageNamed:arr[i]];
        
        if (i == PageNumber - 1) {
            [self setupLastImageView:image];
        }
    }
    
    UIPageControl *page=[[UIPageControl alloc]init];
    [self.view addSubview:page];
    page.x=scrW*0.5;
    page.y=scrH-50;
    page.numberOfPages=PageNumber;
    page.currentPageIndicatorTintColor=[UIColor orangeColor];
    page.pageIndicatorTintColor=[UIColor grayColor];
    _pageC=page;
    [_pageC addTarget:self action:@selector(pageChage:) forControlEvents:UIControlEventValueChanged];

    [self startTime];
    
    
}
-(void)startTime{

    _time=[NSTimer timerWithTimeInterval:2.0 target:self selector:@selector(updatePic) userInfo:nil repeats:YES];
    
    [[NSRunLoop mainRunLoop] addTimer:_time forMode:NSRunLoopCommonModes];
    
    
}
-(void)updatePic{

    int page =(self.pageC.currentPage+1)%PageNumber;
    
    _pageC.currentPage=page;
    
    [self pageChage:_pageC];
    

}


-(void)pageChage:(UIPageControl *)pageC{

//    double page = _scr.contentOffset.x / self.scr.width;
//    HWLog(@"%f",page);
//    
//    // 四舍五入计算出页码
//    self.pageC.currentPage = (int)(page + 0.5);
    
    CGFloat x =pageC.currentPage * self.scr.bounds.size.width;
    
    [self.scr setContentOffset:CGPointMake(x, 0) animated:YES];
    
    NSLog(@"%f",x);
    NSLog(@"%f",self.scr.width);
    if ( x == ( PageNumber -1)*self.scr.width) {
        [_time invalidate];
        
    }
    
    
  

}
-(void)setupLastImageView:(UIImageView *)imageView{

    imageView.userInteractionEnabled = YES;
    
    
    _startBtn = [[UIButton alloc]init];
    [imageView addSubview:_startBtn];
    [_startBtn setTitle:@"开始新生活" forState:UIControlStateNormal];
    _startBtn.sd_layout.topSpaceToView(self.view,400).centerXEqualToView(imageView).heightIs(30).widthRatioToView(imageView,0.4);
    
    [_startBtn setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button"] forState:UIControlStateNormal];
       [_startBtn setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button_highlighted"] forState:UIControlStateHighlighted];
    [_startBtn addTarget:self action:@selector(startWeiBo) forControlEvents:UIControlEventTouchUpInside];
    
    

}
-(void)startWeiBo{
    UIWindow *window=[UIApplication sharedApplication].keyWindow ;
    window.rootViewController = [[JMMainViewController alloc]init];
 
    
}
-(void)shareClick:(UIButton *)btn{

    _checkBox.selected = !_checkBox.isSelected;

}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
    {
        // 停下来的当前页数
        
        
        // 计算页数
        int page = scrollView.contentOffset.x / scrollView.bounds.size.width;
        
        _pageC.currentPage = page;
}
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
        // NSLog(@"%s",__func__);
        [_time invalidate];
        
}
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{

        [self  startTime];
    
}

@end
