//
//  JMListDetailViewController.m
//  JMHalfSugar
//
//  Created by Jimmy on 16/6/21.
//  Copyright © 2016年 HDCircles. All rights reserved.
//

#import "JMListDetailViewController.h"
#import "JMBuyProductViewController.h"
#import "JMCommentViewController.h"

#import "JMListDetailCell.h"
#import "JMListRecommendCell.h"
#import "JMListHeaderView.h"
#import "JMSegmentView.h"
#import "JMMoveToMyFavoriteViw.h"

#import "JMListDetailTool.h"
#import "JMListModel.h"

#import "JMUserRecommendTool.h"
#import "JMUserRecommendModel.h"
#import "JMUserRecommendProductModel.h"
#import "JMListDetailProductModel.h"
#import "JMListModel.h"
#import "UITableView+SDAutoTableViewCellHeight.h"
#import "MikeBarButton.h"
#import "ShareToSIna.h"
typedef enum : NSUInteger {
    BanTangGoodSelectMode,
    UserRecommendMode,
} TableViewMode;
@interface JMListDetailViewController ()<JMListDetailCellDelegate,JMListRecommendCellDelegate>

@property (nonatomic, weak) JMListHeaderView *headerview;
@property (nonatomic, weak) JMSegmentView *segmentView;
@property (nonatomic, strong) JMListModel *listModel;
@property (nonatomic, assign) TableViewMode tableViewMode;

@property (nonatomic, strong)NSMutableArray *recommendArray;
@property (nonatomic, strong)UIView *customBar;
@property (nonatomic, strong)UIButton *favoriteBtn;
@property (nonatomic, strong)UIButton *shareBtn;
@property (nonatomic, strong)UIView *navBackView;
@property (nonatomic, strong)UIView *tableHeadView;

@property(nonatomic,strong)NSArray *productArr;

//CustomNavigationBar
@property(nonatomic,strong)UIButton *backBtn;

@property(nonatomic,strong)UIView *customNavigationBar;
@property(nonatomic,strong)UIButton *navShareBtn;
@end
@implementation JMListDetailViewController


- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;

    NSLog(@"%@---list",self.listID);

    [self initializedSubviews];
//    [self setUpCustomNavigationBar];
    

}

-(void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    

    [self.navigationController setNavigationBarHidden:NO];
}

-(void)viewWillDisappear:(BOOL)animated{

    [super viewWillDisappear:animated];
    
     self.navigationController.navigationBar.alpha = 1;
}

#pragma mark - initialized subviews
- (void)initializedSubviews
{

    
    [JMUserRecommendTool getSearchWithListID:_listID completionHandler:^(id obj) {
        
        JMListModel *model = [JMListModel objectWithKeyValues:obj[@"data"]];
  
//        _listModel = model;
        
        NSArray *arr = [JMListDetailProductModel objectArrayWithKeyValuesArray:model.product_list];
        
        _productArr = arr;

        JMListHeaderView *headerView = [[JMListHeaderView alloc]initWithFrame:CGRectMake(0, 0, JMDeviceWidth, 0) withTitle:model.title subTitle:model.desc andImage:_image];
        _headerview = headerView;
        
        
        self.navigationItem.title = model.title;
        
        self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(shareUrl) image:@"share_hl" highImage:@"share_normal"];
        
//        UIView *navView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KScreenWith, 64)];
//        [headerView addSubview:navView];
//        navView.backgroundColor = [UIColor whiteColor];
//        _customNavigationBar = navView;
//        
//        UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//        backBtn.frame = CGRectMake(10, 0, 28, 28);
//        [backBtn setImage:[UIImage imageNamed:@"mobile-back"] forState:UIControlStateNormal];
//        [backBtn setImage:[UIImage imageNamed:@"mobile-back"] forState:UIControlStateHighlighted];
//        [backBtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
//        backBtn.centerY = 42;
//        [navView addSubview:backBtn];
//        _backBtn = backBtn;
//        
//        
//        
//        UIButton *shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//        shareBtn.frame = CGRectMake(JMDeviceWidth-28-10, 0, 28, 28);
//        [shareBtn setImage:[UIImage imageNamed:@"share_hl"] forState:UIControlStateNormal];
//        [shareBtn setImage:[UIImage imageNamed:@"share_normal"] forState:UIControlStateHighlighted];
//        [shareBtn addTarget:self action:@selector(shareUrl) forControlEvents:UIControlEventTouchUpInside];
//        shareBtn.centerY = 42;
//        [navView addSubview:shareBtn];
//        _navShareBtn = shareBtn;
//        
        CGRect frame = _headerview.frame;
        frame.size.height +=45;
        _headerview.frame = frame;
        
        self.tableView.tableHeaderView = _headerview;
        
          [self.tableView reloadData];
  
    }];
}

-(void)backAction{

    [self.navigationController popToRootViewControllerAnimated:YES];
}
-(void)shareUrl{

    [JMUserRecommendTool getSearchWithListID:_listID completionHandler:^(id obj) {
        
        JMListModel *model = [JMListModel objectWithKeyValues:obj[@"data"]];
    

        ShareToSIna *sina = [[ShareToSIna alloc]init];

        sina.share_url = model.pic;
        sina.share_title = model.title;
    
    [self.navigationController pushViewController:sina animated:YES];
    
    }];

}


#pragma mark - NavBtnAction
- (void)favoriteBtnAction:(UIButton *)sender
{
    sender.selected = !sender.selected;
    if (sender.selected) {
        [UIAlertController showAlertTips:@"谢谢你的收藏" onView:self.view alertStyle:UIAlertControllerStyleAlert timeInterval:1.0f compeletion:^{
            [[NSUserDefaults standardUserDefaults] setObject:@(YES) forKey:_listID];
        }];
    }else {
        [UIAlertController showAlertTips:@"取消收藏" onView:self.view alertStyle:UIAlertControllerStyleAlert timeInterval:1.0f compeletion:^{
            [[NSUserDefaults standardUserDefaults] setObject:@(NO) forKey:_listID];
        }];
    }
}



#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{


    return _productArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   
      JMListDetailProductModel *model =  _productArr[indexPath.row];
    
        JMListDetailCell *cell = [JMListDetailCell cellWithTableView:tableView];

  
        cell.model = model;

        cell.delegate = self;

        return cell;
}
#pragma mark -UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // >>>>>>>>>>>>>>>>>>>>> * cell自适应步骤2 * >>>>>>>>>>>>>>>>>>>>>>>>
    /* model 为模型实例， keyPath 为 model 的属性名，通过 kvc 统一赋值接口 */
    
    return [self.tableView cellHeightForIndexPath:indexPath model:self.productArr[indexPath.row] keyPath:@"model" cellClass:[JMListDetailCell class] contentViewWidth:[self cellContentViewWith]];
}

- (CGFloat)cellContentViewWith
{
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    
    // 适配ios7
    if ([UIApplication sharedApplication].statusBarOrientation != UIInterfaceOrientationPortrait && [[UIDevice currentDevice].systemVersion floatValue] < 8) {
        width = [UIScreen mainScreen].bounds.size.height;
    }
    return width;
}


#pragma mark - JMListDetailCellDelegate
- (void)checkProductDetails:(NSInteger)productID
{
    NSLog(@"%ld",productID);
}
- (void)clickCenterWithType:(ListDetailCellClickType)clickType atIndexPath:(NSIndexPath *)indexPath
{
    switch (clickType) {
        case AllowComment_type:
        {
            [self.navigationController pushViewController:[JMCommentViewController new] animated:YES];
            break;
        }
        case NotAllowComment_type:
        {
            [self.navigationController pushViewController:[JMCommentViewController new] animated:YES];
            break;
        }
        case LikeIt_type:
        {
            NSLog(@"collected");
            break;
        }
        case MoveToOtherFavoriteList_type:
        {
            JMListDetailProductModel *model = _listModel.product_list[0];
            JMMoveToMyFavoriteViw *moveView = [[JMMoveToMyFavoriteViw alloc]initWithFrame:CGRectMake(0, JMDeviceHeight, JMDeviceWidth, JMDeviceHeight)];
            [moveView showWithAnimation:model.productID];
            break;
        }
        case BuyThisProduct_type:
        {
            JMListDetailProductModel *product = _listModel.product_list[0];
            JMBuyProductViewController *buyPro = [[JMBuyProductViewController alloc]init];
            buyPro.productURL = product.url;
            [self.navigationController pushViewController:buyPro animated:YES];
        }
        default:
            break;
    }
}
#pragma mark - JMListRecommendCellDelegate
- (void)listRecommendClickCenter:(ListDetailCellClickType)clickType atIndexPath:(NSIndexPath *)indexPath
{
    switch (clickType) {
        case AllowComment_type:
        {
            [self.navigationController pushViewController:[JMCommentViewController new] animated:YES];
            break;
        }
        case LikeIt_type:
        {
            JMUserRecommendModel *model = _recommendArray[indexPath.section];
            JMUserRecommendProductModel *product = model.productArray[0];
            product.isCollect = YES;
            [[NSUserDefaults standardUserDefaults] setObject:@(YES) forKey:[NSString stringWithFormat:@"%d",product.isCollect]];
            break;
        }
        case BuyThisProduct_type:
        {
            JMUserRecommendModel *model = _recommendArray[indexPath.section];
            JMUserRecommendProductModel *product = model.productArray[0];
            JMBuyProductViewController *buyPro = [[JMBuyProductViewController alloc]init];
            buyPro.productURL = product.url;
            [self.navigationController pushViewController:buyPro animated:YES];
            break;
        }
        default:
            break;
    }
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat scrollY = scrollView.contentOffset.y;
    
    
    
//    NSLog(@"%lf",scrollY / 300);
    
   _customNavigationBar.alpha = scrollY / 300;
    
//    if (scrollY>= 0 && scrollY < _headerview.height-64-_segmentView.height) {
//        _navBackView.backgroundColor = [UIColor colorWithHexString:@"EC5252" alpha:scrollY/(_headerview.height-64-_segmentView.height)];
//        [_segmentView removeFromSuperview];
//        _segmentView.y = _headerview.height-_segmentView.height;
//        [_headerview addSubview:_segmentView];
//    }else if (scrollY <= 0 ){
//
//    }else if(scrollY == _headerview.height-64-_segmentView.height ||scrollY>_headerview.height-64-_segmentView.height ) {
//        _navBackView.backgroundColor = JMCustomBarTintColor;
//        _segmentView.y = 64;
//        [self.view addSubview:_segmentView];
//        
//    }
//    NSLog(@"%lf",scrollView.contentOffset.y);
    

    
    
}
@end
