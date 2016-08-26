//
//  JMProductDetailViewController.m
//  JMHalfSugar
//
//  Created by Jimmy on 16/6/16.
//  Copyright © 2016年 HDCircles. All rights reserved.
//

#import "JMProductDetailViewController.h"
#import "JMProductTitleView.h"
#import "JMProductCommentCell.h"
#import "JMPorductDetailTool.h"
#import "JMProductDetailModel.h"
#import "JMCommentModel.h"
#import "JMWebView.h"
#import "JMSearchRelationModel.h"

#import "JMSearchTool.h"
#import "JMSearchSingleGoodsModel.h"

#import "ShareToSIna.h"
//#import "MIkeFlow.h"
//#import "JMSearchTopicCell.h"
#import "JMRelationView.h"
#import "JMRelationProView.h"
#import "JMListDetailViewController.h"

@interface JMProductDetailViewController ()<UITableViewDataSource,UITableViewDelegate,JMRelationProViewDelagate,JMRelationViewDelegate>
@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, weak) UIView *customNavigationBar;
@property (nonatomic, weak) UIButton *backBtn;
@property (nonatomic, weak) UIButton *shareBtn;
@property (nonatomic, weak) UILabel *titleLbl;
@property (nonatomic, weak)JMProductTitleView *titleView;
@property (nonatomic, weak)UIView *bottomView;
@property (nonatomic, strong)NSMutableArray *comments;
@property(nonatomic,copy)NSString *url;

//相关产品
@property(nonatomic,strong)NSMutableArray *topicArr;
@property(nonatomic,strong)NSMutableArray *relationArr;

@property(nonatomic,strong)UICollectionView *collectionView;


@end

@implementation JMProductDetailViewController

static NSString *ID = @"cell";
static CGFloat _scrollViewheight = 0;
static CGFloat _imageHeight = 250;



- (NSMutableArray *)comments
{
    if (!_comments) {
        _comments = [NSMutableArray new];
        
        [JMPorductDetailTool getSearchWithProID:self.productID completionHandler:^(id obj) {

                NSArray *dataProduct = obj[@"data"][@"comment_list"];
                NSArray *model = [JMCommentModel objectArrayWithKeyValuesArray:dataProduct];
            
            [_comments addObjectsFromArray: model];

            
            [self.tableView reloadData];
        }];

    }
    return _comments;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
   
    
    [self initializedSubviews];
    [self setUpCustomNavigationBar];
    [self comments];
    [self loadData];
  
//    NSLog(@"%@",self.productID);
   
}

-(void)loadData{

    
    self.topicArr = [NSMutableArray array];
    self.relationArr = [[NSMutableArray alloc]init];
    
    [JMSearchTool getRelationWithObjID:self.productID completionHandler:^(id obj) {
        
        NSArray *topicArr = [JMSearchRelationModel objectArrayWithKeyValuesArray:obj[@"data"][@"topic"]];
        [_topicArr addObjectsFromArray:topicArr];
        
        NSArray *relationArr = [JMSearchSingleGoodsModel objectArrayWithKeyValuesArray:obj[@"data"][@"product"]];
        [_relationArr addObjectsFromArray:relationArr];
   
        UIView *bottomView = [[UIView alloc]init];
        bottomView.width = KScreenWith;
        bottomView.height = 1080 + 120 +10;
    
        JMRelationView *relation = [[JMRelationView alloc]initWithFrame:CGRectMake(0, 0, KScreenWith, 120) ];
          relation.modelArr = _topicArr;
        [bottomView addSubview:relation];
        relation.delegate = self;
        
        JMRelationProView *pro = [[JMRelationProView alloc]initWithFrame:CGRectMake(0, 130, KScreenWith, 1080)];
        [bottomView addSubview:pro];
        
        pro.delegate = self;
        
        pro.modelArr = relationArr;
        
        
        _tableView.tableFooterView = bottomView;

      

    }];
}
-(void)JMRelationViewDidClick:(JMRelationView *)proView proID:(NSString *)ID Image:(NSString *)imageName{

//    NSLog(@"%@---%@",ID,imageName);
    UIImageView *view = [[UIImageView alloc]init];
    [view sd_setImageWithURL:[NSURL URLWithString:imageName]];
    
    JMListDetailViewController *list = [[JMListDetailViewController alloc]init];
    list.listID = ID;
    list.image = view.image;
    [self.navigationController pushViewController:list animated:YES];

    
}

-(void)JMRelationProViewDidClick:(JMRelationProView *)proView proID:(NSString *)ID{

    NSLog(@"%@",ID);

    JMProductDetailViewController *proDetailView = [[JMProductDetailViewController alloc]init];
    proDetailView.productID = ID;
    [self.navigationController pushViewController:proDetailView animated:YES];


}

-(void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];

}
-(void)viewWillDisappear:(BOOL)animated{

    [super viewWillDisappear:animated];
    
    [self.navigationController setNavigationBarHidden:NO];

}

#pragma mark - initialized subviews
- (void)initializedSubviews
{

    JMProductTitleView *titleView = [[JMProductTitleView alloc]initWithFrame:CGRectMake(0, 0, JMDeviceWidth, 480)];

    [JMPorductDetailTool getSearchWithProID:self.productID completionHandler:^(id obj) {

        
        NSDictionary *dataProduct = obj[@"data"];
        JMProductDetailModel *model = [JMProductDetailModel objectWithKeyValues:dataProduct];

        JMListDetailProductModel *detailPro = model.product;
        
            _url = detailPro.url;
        titleView.model = detailPro;
        
        [self.view setNeedsDisplay];
    }];
    
    
    titleView.autoresizesSubviews= YES;
    _titleView = titleView;
    [self.view layoutIfNeeded];
    _scrollViewheight = _titleView.height;

    //tableView
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, JMDeviceWidth, JMDeviceHeight-44) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.contentInset = UIEdgeInsetsMake(titleView.height, 0, 0, 0);
    [self.view addSubview:tableView];
    _tableView = tableView;
    _titleView.y = -_titleView.height;
    [tableView addSubview:titleView];
    _tableView = tableView;
 
    //bottom view;
     [self setUpBottomView];
    
}
-(void)setUpBottomView{

    UIView *bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_tableView.frame), JMDeviceWidth, 44)];
    bottomView.backgroundColor = [UIColor whiteColor];
    //      bottomView.backgroundColor = HWRandomColor;
    
    NSArray *titleArr = @[@"评论",@"喜欢",@"购买"];
    NSArray *imageArr = @[@"btn_group_comment",@"btn_group_like",@"icon_group_post_buy_17x17_"];
    CGFloat BtnX = 0;
    
    CGFloat BtnW = self.view.width/3;
    CGFloat BTnH = 44;
    
    CGFloat paddingX=(self.view.width-3*BtnW)/(3+1);
    for (int i=0; i<3; i++) {
        BtnX=paddingX +(paddingX +BtnW)*i;
        
        UIButton *btn=[[UIButton alloc]initWithFrame:CGRectMake(BtnX, 0, BtnW, BTnH)];
        
        [bottomView addSubview:btn];
        
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        [btn setTitle:titleArr[i] forState:UIControlStateNormal];
        
        [btn setImage:[UIImage imageNamed:imageArr[i]] forState:UIControlStateNormal];
        
        btn.titleLabel.font=[UIFont systemFontOfSize:14];
        
        btn.tag = 40+i;
        [btn addTarget:self action:@selector(toolBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    
    [self.view addSubview:bottomView];
    
    
    
    _bottomView = bottomView;
}

-(void)toolBtnClick:(UIButton *)btn{

    if (btn.tag == 42) {
        JMWebView *web = [[JMWebView alloc]init];
        
        web.url = self.url;
        
        [self.navigationController pushViewController:web animated:YES];
    }
    if (btn.tag == 41) {
        
        [btn setImage:[UIImage imageNamed:@"btn_product_like_already_20x17_"] forState:UIControlStateSelected];
//        btn.selected
    }
    
}

- (void)setUpCustomNavigationBar
{
    UIView *navBar = [[UIView alloc]initWithFrame:CGRectMake(0, 0, JMDeviceWidth, 64)];
    navBar.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.0];
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(10, 0, 28, 28);
    [backBtn setImage:[UIImage imageNamed:@"mobile-back"] forState:UIControlStateNormal];
    [backBtn setImage:[UIImage imageNamed:@"mobile-back"] forState:UIControlStateHighlighted];
    [backBtn addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
    backBtn.centerY = 42;
    [navBar addSubview:backBtn];
    _backBtn = backBtn;
    
    UIButton *shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    shareBtn.frame = CGRectMake(JMDeviceWidth-28-10, 0, 28, 28);
    [shareBtn setImage:[UIImage imageNamed:@"share_hl"] forState:UIControlStateNormal];
    [shareBtn setImage:[UIImage imageNamed:@"share_normal"] forState:UIControlStateHighlighted];
    [shareBtn addTarget:self action:@selector(shareUrl) forControlEvents:UIControlEventTouchUpInside];
    shareBtn.centerY = 42;
    [navBar addSubview:shareBtn];
    _shareBtn = shareBtn;
    
    UILabel *titleLbael = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
    titleLbael.text = @"产品详情";
    titleLbael.font = [UIFont fontWithName:RegularFont size:16.0];
    titleLbael.textColor = [UIColor colorWithHexString:@"EC5252" alpha:0.0];
    [titleLbael sizeToFit];
    titleLbael.center = CGPointMake(JMDeviceWidth/2, 42);
    [navBar addSubview:titleLbael];
    _titleLbl = titleLbael;

    [self.view addSubview:navBar];
    _customNavigationBar = navBar;
    
}
-(void)shareUrl{


    [JMPorductDetailTool getSearchWithProID:self.productID completionHandler:^(id obj) {
        
        
            ShareToSIna *share = [[ShareToSIna alloc]init];
        NSDictionary *dataProduct = obj[@"data"];
        JMProductDetailModel *model = [JMProductDetailModel objectWithKeyValues:dataProduct];
        JMListDetailProductModel *listModel = model.product;
        
        share.share_title = listModel.title;
        share.share_url = listModel.url;
        [share.view setNeedsDisplay];
    [self.navigationController pushViewController:share animated:YES];
    
    }];

    
}

- (void)backAction:(UIButton *)btn
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)goToComment
{
    
}
-(void)likeOrDislikeAction:(UIButton *)sender
{
    sender.selected = !sender.selected;
    if (sender.selected == YES) {
        [sender setImage:[UIImage imageNamed:@"addToFavoriteBtn_selected"] forState:UIControlStateHighlighted];
        [UIView animateWithDuration:0.3 animations:^{
            sender.transform = CGAffineTransformMakeScale(1.2, 1.2);
        } completion:^(BOOL finished) {
            sender.transform = CGAffineTransformIdentity;
        }];
    }else {
        [sender setImage:[UIImage imageNamed:@"addToFavoriteBtn"] forState:UIControlStateHighlighted];
    }
}
#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.comments.count) {
        return _comments.count;
    }else {
        return 0;
    }

}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    JMProductCommentCell *cell = [JMProductCommentCell cellWithTableView:tableView];
    cell.model = _comments[indexPath.row];
    
    return cell;
 
}
- (NSInteger)tableView:(UITableView *)tableView indentationLevelForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 1;
}
#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    JMCommentModel *modle = _comments[indexPath.row];
    if (modle.cellHeight != 0) {
        return modle.cellHeight;
    }else {
        return 100;
    }
}
#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat y = scrollView.contentOffset.y;
//    NSLog(@"%lf",y);
    if (y < -_scrollViewheight) {
        _titleView.contentOffsetY = _imageHeight + (-_scrollViewheight-y);
        CGRect frame = _titleView.frame;
        frame.origin.y = y;
        frame.size.height = -y;
        _titleView.frame = frame;
    }
    if (y < -264) {
        _customNavigationBar.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.0];
        _titleLbl.textColor = [UIColor colorWithHexString:@"EC5252" alpha:0];
        _shareBtn.highlighted = NO;
        _backBtn.highlighted = NO;
        _shareBtn.alpha = 1.0;
        _backBtn.alpha = 1.0;
    }
    if (y > -264 && y< -164) {
        _customNavigationBar.backgroundColor = [UIColor colorWithWhite:1.0 alpha:y/(-264)];
        _titleLbl.textColor = [UIColor colorWithHexString:@"EC5252" alpha:y/(-264)];
        _shareBtn.alpha = (-264-y)/(-264);
        _backBtn.alpha = (-264-y)/(-264);
    }else if (y>=-164){
        _customNavigationBar.backgroundColor = [UIColor colorWithWhite:1.0 alpha:1.0];
        _titleLbl.textColor = [UIColor colorWithHexString:@"EC5252" alpha:1.0];
        _shareBtn.alpha = 1.0;
        _backBtn.alpha = 1.0;
        
        _shareBtn.highlighted = YES;
        _backBtn.highlighted = YES;
    }
}
@end
