//
//  JMSearchViewController.m
//  JMHalfSugar
//
//  Created by Jimmy on 16/6/11.
//  Copyright © 2016年 HDCircles. All rights reserved.
//

#import "JMSearchViewController.h"
#import "JMSingleGoodsViewController.h"
#import "SDImageCache.h"
#import "JMSegmentView.h"
#import "JMInventoryView.h"
#import "JMSearchTool.h"
#import "JMSearchModel.h"
#import "JMSerchLishModel.h"
#import "JMSearchListCell.h"

#import "JMSearchSingleGoodsModel.h"
#import "JMSearchModel.h"
@interface JMSearchViewController ()<UISearchBarDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,JMSegmentViewDelegate,JMINventoryViewDelegate>
@property (nonatomic, weak)UISearchBar *searchBar;
@property (nonatomic, weak)UIView *naviBgView;
@property (nonatomic, weak)JMSegmentView *segmentView;
@property (nonatomic, weak)JMInventoryView *inventoryView;
@property (nonatomic, weak)UIScrollView *mainScrollView;
@property (nonatomic, weak)UICollectionView *showCollectionView;
@property (nonatomic, strong)NSMutableArray<JMSearchModel *> *searchSingleModels;
@property (nonatomic, strong)NSMutableArray<JMSearchModel *> *subSearchModels;
@property (nonatomic, strong)NSMutableArray<JMSerchLishModel *> *searchListModels;

@property(nonatomic,strong)UIView *searchField;
@property(nonatomic,strong)NSArray *searchArr;
@end

@implementation JMSearchViewController
- (NSMutableArray<JMSerchLishModel *> *)searchListModels
{
    if (!_searchListModels) {
        _searchListModels = [NSMutableArray array];
    }
    return _searchListModels;
}
- (NSMutableArray<JMSearchModel *> *)searchSingleModels
{
    if (!_searchSingleModels) {
        _searchSingleModels = [NSMutableArray array];
    }
    return _searchSingleModels;
}
- (NSMutableArray<JMSearchModel *> *)subSearchModels
{
    if (!_subSearchModels) {
        _subSearchModels = [NSMutableArray array];
    }
    return _subSearchModels;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    [self loadData];
    [self initializedSubviews];
    [self createSearchField];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [self.navigationController setNavigationBarHidden:YES];
}


#pragma mark - loading data
- (void)loadData
{
    self.searchSingleModels = [JMSearchTool createSearchModel];
    self.subSearchModels = _searchSingleModels[0].subList;
    self.searchListModels = [JMSearchTool createSearchListModel];
}
#pragma mark - initialized subviews
- (void)initializedSubviews
{
    [self createCustomNavgationBar];

    JMSegmentView *segmentView =[[JMSegmentView alloc]initWithFrame:CGRectMake(0, _naviBgView.height, JMDeviceWidth, 44) firstTitle:@"清单" secondTitle:@"单品"];
    segmentView.delegate = self;
    [self.view addSubview:segmentView];
    _segmentView = segmentView;
    
    //
    JMInventoryView *inventoryView = [[JMInventoryView alloc]initWithFrame:CGRectMake(0, 0, JMDeviceWidth, JMDeviceHeight-CGRectGetMaxY(_segmentView.frame))];
    inventoryView.categoryModel = self.searchSingleModels;
    inventoryView.delegate = self;
    [self.view addSubview:inventoryView];

    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    flowLayout.sectionInset = UIEdgeInsetsZero;
    flowLayout.minimumInteritemSpacing = 20.0f;
    flowLayout.minimumLineSpacing = 20.0f;
    
    CGFloat cHeight = JMDeviceWidth- CGRectGetMaxY(_segmentView.frame);
    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(JMDeviceWidth, 0, JMDeviceWidth, JMDeviceHeight) collectionViewLayout:flowLayout];
    collectionView.dataSource = self;
    collectionView.delegate = self;
    collectionView.contentSize = CGSizeMake(0, cHeight);
    collectionView.bounces = NO;
    collectionView.pagingEnabled = YES;
    collectionView.backgroundColor = [UIColor whiteColor];
    [collectionView registerClass:[JMSearchListCell class] forCellWithReuseIdentifier:@"ListCell"];

    //
    UIScrollView *mainScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_segmentView.frame), JMDeviceWidth, JMDeviceHeight-CGRectGetMaxY(_segmentView.frame))];
    mainScrollView.showsHorizontalScrollIndicator = false;
    mainScrollView.bounces = NO;
    mainScrollView.pagingEnabled = YES;
    mainScrollView.delegate = self;
    mainScrollView.contentSize = CGSizeMake(JMDeviceWidth*2, cHeight);
    [self.view addSubview:mainScrollView];
    [mainScrollView addSubview:inventoryView];
    [mainScrollView addSubview:collectionView];
    _mainScrollView = mainScrollView;
}
- (void)createCustomNavgationBar
{
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    UIView *navBar = [[UIView alloc]initWithFrame:CGRectMake(0, 0, JMDeviceWidth, 64)];
    
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(10, 0, 28, 28);
    backBtn.centerY = 42;
    [backBtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    [backBtn setImage:[UIImage imageNamed:@"mobile-back"] forState:UIControlStateNormal];
    [navBar addSubview:backBtn];
    
    CGFloat searhBarWidth = JMDeviceWidth-backBtn.width-15*2-10;
    UISearchBar *searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(backBtn.width+15+10, 0, searhBarWidth, 44)];
    searchBar.centerY = 42;
    searchBar.delegate  = self;
    searchBar.searchBarStyle =UISearchBarStyleMinimal;
    searchBar.tintColor = [UIColor redColor];
    searchBar.placeholder = @"searching your favorite product";
    [navBar addSubview:searchBar];
    for (UIView *view in searchBar.subviews) {
        for (UIView *subView in view.subviews) {
            if ([subView isKindOfClass:[UITextField class]]) {
                UITextField *textField = (UITextField *)subView;
                textField.clipsToBounds = YES;
                textField.layer.cornerRadius = 25/2;
            }
        }
    }
    _searchBar = searchBar;
    [self.view addSubview:navBar];
    _naviBgView = navBar;
}
- (void)backAction
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)createSearchField{

    UIView *searchField = [[UIView alloc]init];
    searchField.frame = CGRectMake(0, 64, KScreenWith, self.view.height-64);
    [self.view addSubview:searchField];
    _searchField = searchField;
    _searchField.backgroundColor = HWColor(240, 240, 240);
    _searchField.hidden = YES;
    
    UILabel *titleLabel = [UILabel new];
    titleLabel.text = @"热门搜索";
    
    int  kAppViewW =60;
    int  kAppViewH =30;
    int tolcol =5;
    int  appx=(self.view.bounds.size.width-tolcol*kAppViewW)/(tolcol+1);
    int appy=10;
    NSArray *titleArr = @[@"手机壳",@"宿舍",@"双肩包",@"钱包",@"杯子",@"性冷淡",@"手表",@"笔袋",@"耳机",@"泳衣",@"水杯",@"礼物",@"书包",@"充电宝",@"睡衣",];
    _searchArr = titleArr;
    for (int i=0; i<15; i++) {
        int col=i%tolcol;
        int row=i/tolcol;
        
        CGFloat x=appx+col*(appx+kAppViewW);
        CGFloat y=appy+row*(appy+kAppViewH) +10;
        
        
        UIButton *btn = [[UIButton alloc]init];
        btn.frame=CGRectMake(x,y, kAppViewW, kAppViewH);

        [_searchField addSubview:btn];
    
        NSDictionary *dict = @{
                               NSFontAttributeName:[UIFont systemFontOfSize:13],
                               NSForegroundColorAttributeName:[UIColor blackColor]
                               };
        NSAttributedString *str = [[NSAttributedString alloc]initWithString:titleArr[i] attributes:
                                   dict];
        [btn setAttributedTitle:str forState:UIControlStateNormal];
//        [btn setTitle:titleArr[i] forState:UIControlStateNormal];
        btn.tag = i+20;
        btn.layer.cornerRadius = 10;
        btn.backgroundColor = [UIColor whiteColor];
        [btn addTarget:self action:@selector(searchForID:) forControlEvents:UIControlEventTouchUpInside];
    }
    
}
-(void)searchForID:(UIButton *)btn{
    
    NSString *str= _searchArr[btn.tag-20];
//    NSLog(@"%@",str);
    _searchBar.text = str;
    
    [self searchForText:str];
    
    
}
#pragma mark - UISearchBarDelegate
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    [searchBar setShowsCancelButton:YES animated:YES];

    _searchField.hidden = NO;

    
}
-(void)searchForText:(NSString *)text{
    JMSingleGoodsViewController *singleGoods = [[JMSingleGoodsViewController alloc]init];
    
    
    //    NSLog(@"%@",model.name);
    [JMSearchTool getSearchWithText:text completionHandler:^(id obj) {
        NSArray *dataArray = obj[@"data"];
        
        NSArray *arr = [JMSearchSingleGoodsModel objectArrayWithKeyValuesArray:dataArray];
        
        
        
        [singleGoods.singleModels addObjectsFromArray:arr];
        
        singleGoods.title = text;
        [singleGoods.collectionView reloadData];
    }];
    
    //        [singleGoods.singleModels  addObjectsFromArray:[JMSearchTool createSearchSingleGoodsModelByStr:@"mk"]];
    
    [self.navigationController pushViewController:singleGoods animated:YES];

    
}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [self searchForText:_searchBar.text];
    
    _searchField.hidden = YES;
    
   [searchBar setShowsCancelButton:YES animated:YES];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
    _searchField.hidden = YES;

    [searchBar setShowsCancelButton:NO animated:YES];

}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.searchListModels.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    JMSearchListCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ListCell" forIndexPath:indexPath];
    cell.searchListModel = self.searchListModels[indexPath.row];
    
    
    return cell;
}
#pragma mark - UICollectionViewDelegateFlowLayout
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(10, 15, 25, 15);
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(60, 100);
}
#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"clicked");
}
#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView == _mainScrollView) {
        _segmentView.currentIndex = scrollView.contentOffset.x/JMDeviceWidth;
    }
}
#pragma mark - JMINventoryViewDelegate


- (void)didSelectedItem:(NSString *)name
{
    
    [self searchForText:name];
//    JMSingleGoodsViewController *singleGoods = [[JMSingleGoodsViewController alloc]init];
//
////    NSLog(@"%@---inde%@",model.name,indexPath);
//    [JMSearchTool getSearchWithText:list.name completionHandler:^(id obj) {
//        NSArray *dataArray = obj[@"data"];
//        
//        NSArray *arr = [JMSearchSingleGoodsModel objectArrayWithKeyValuesArray:dataArray];
//        
//        
//        
//        [singleGoods.singleModels addObjectsFromArray:arr];
//        
//        singleGoods.title = model.name;
//        [singleGoods.collectionView reloadData];
//    }];
//    
////        [singleGoods.singleModels  addObjectsFromArray:[JMSearchTool createSearchSingleGoodsModelByStr:@"mk"]];
//    
//    [self.navigationController pushViewController:singleGoods animated:YES];
}
#pragma mark - JMSegmentViewDelegate
- (void)clickSegmentViewAtIndex:(NSInteger)index
{
    NSLog(@"index_%ld",index);
    [_mainScrollView setContentOffset:CGPointMake((index-1)*JMDeviceWidth, 0) animated:YES];
}
@end
