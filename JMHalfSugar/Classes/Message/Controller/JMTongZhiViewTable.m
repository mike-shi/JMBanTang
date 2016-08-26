//
//  JMTongZhiViewTable.m
//  JMHalfSugar
//
//  Created by mike on 16/8/24.
//  Copyright © 2016年 HDCircles. All rights reserved.
//

#import "JMTongZhiViewTable.h"
#import "JMTongZhiModel.h"
#import "JMTongZhiCell.h"
#import "UITableView+SDAutoTableViewCellHeight.h"
#import "JLViewController.h"
@interface JMTongZhiViewTable ()
@property(nonatomic,strong)NSArray *NotiArr;
@end

@implementation JMTongZhiViewTable

-(NSArray *)NotiArr{
    
    if (!_NotiArr) {
        
        _NotiArr= [[NSArray alloc]init];
        
        JMTongZhiModel *model1 = [JMTongZhiModel modelWithIcon:@"http://7te7t9.com2.z0.glb.qiniucdn.com/000/00/00/01.jpg?v=2" Name:@"小糖君" Content:@"呵呵，你猜" Btn:@"点击留言>" Data:@"08-19 11:14"];
        
          JMTongZhiModel *model2 = [JMTongZhiModel modelWithIcon:@"http://7te7t9.com2.z0.glb.qiniucdn.com/000/00/00/01.jpg?v=2" Name:@"小糖君" Content:@"很遗憾，你发布的文章未通过审核，原因是不包含原创好物分享，不能通过审核" Btn:@"修改文章>" Data:@"08-12 10:08"];
          JMTongZhiModel *model3 = [JMTongZhiModel modelWithIcon:@"http://7te7t9.com2.z0.glb.qiniucdn.com/000/00/00/01.jpg?v=2" Name:@"小糖君" Content:@"很遗憾，你发布的文章未通过审核，原因是不包含原创好物分享，不能通过审核" Btn:@"修改文章>" Data:@"08-11 16:24"];
          JMTongZhiModel *model4 = [JMTongZhiModel modelWithIcon:@"http://7te7t9.com2.z0.glb.qiniucdn.com/000/00/00/01.jpg?v=2" Name:@"小糖君" Content:@"很遗憾，你发布的文章未通过审核，原因是不包含原创好物分享，不能通过审核" Btn:@"修改文章>" Data:@"08-10 15:33"];
        _NotiArr = @[model1,model2,model3,model4];
        
    }
    return _NotiArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self NotiArr];
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return _NotiArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    JMTongZhiCell *cell = [JMTongZhiCell cellWithTableView:tableView];
    
    JMTongZhiModel *model = _NotiArr[indexPath.row];
    
    cell.model = model;
    
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    return [self.tableView cellHeightForIndexPath:indexPath model:self.NotiArr[indexPath.row] keyPath:@"model" cellClass:[JMTongZhiCell class] contentViewWidth:[self cellContentViewWith]];
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

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    JLViewController *chatView = [[JLViewController alloc]init];
    
    [self.navigationController pushViewController:chatView animated:YES];
    
    

}

@end
