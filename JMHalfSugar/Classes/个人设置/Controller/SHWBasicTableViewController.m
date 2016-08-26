//
//  SHWBasicTableViewController.m
//  
//
//  Created by mike on 16/3/30.
//
//

#import "SHWBasicTableViewController.h"
#import "MIkeItem.h"
#import "MIkeItemGroup.h"
#import "myTableVIewCell.h"
#import "MIkeSwitchItem.h"
#import "MIkeArrowItem.h"
#import "MikeLaberlItem.h"
#import "UIView+SDAutoLayout.h"
#import "UITableView+SDAutoTableViewCellHeight.h"
@interface SHWBasicTableViewController ()
@end

@implementation SHWBasicTableViewController
-(NSMutableArray *)dataList{
    
    if (_dataList==nil) {
        _dataList=[NSMutableArray array];
        
    }
    return _dataList;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self dataList];
    
    UIView *footer=[[UIView alloc]initWithFrame:CGRectMake(0,0, self.view.bounds.size.width, 40)];
    
    UIImage *image=[UIImage imageNamed:@"RedButton"];
    image=[image stretchableImageWithLeftCapWidth:image.size.width*0.5 topCapHeight:image.size.height*0.5];
    UIButton *logoutBtn=[[UIButton alloc]init];
    
    [logoutBtn setBackgroundImage:image forState:UIControlStateNormal];
    
    [footer addSubview: logoutBtn];
    
    
    [logoutBtn setTitle:@"推出当前账户"forState:UIControlStateNormal];
    
    
    
    self.tableView.tableFooterView=footer;
    
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return _dataList.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    // Return the number of rows in the section.
    MIkeItemGroup *array=self.dataList[section];
    
    
    return  array.array.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    myTableVIewCell *cell=[[myTableVIewCell class] cellWithTableView:self.tableView];
    
    MIkeItemGroup *itemGroup=_dataList[indexPath.section];
    MIkeItem *item=itemGroup.array[indexPath.row];
    
    cell.item=item;    
    return cell;
}

-(NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section{
    
    MIkeItemGroup *group=_dataList[section];
    return group.footer;
    
    
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    MIkeItemGroup *gruup=_dataList[section];
    
    return gruup.header;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    MIkeItemGroup *group = self.dataList[indexPath.section];
    MIkeItem *item = group.array[indexPath.row];
    
    
    if (item.option) {
        item.option();
        return;
    }
    
    if ([item isKindOfClass:[MikeLaberlItem class]]) {
        MikeLaberlItem *labelItem=(MikeLaberlItem *)item;
        
        if (labelItem.arrowClass) {
            UIViewController *lvc=[[labelItem.arrowClass alloc]init];
            lvc.title=labelItem.name;
            [self.navigationController pushViewController:lvc animated:YES];
        }
    }
    
    
    if ([item isKindOfClass:[MIkeArrowItem class]]  ){
        
        MIkeArrowItem *arrowItem = (MIkeArrowItem *)item;
        
        if (arrowItem.arrowClass) {
            
            UIViewController *vc = [[arrowItem.arrowClass alloc] init];
            
            vc.title=arrowItem.name;
            [self.navigationController pushViewController:vc animated:YES];
        }       
        
    }
  
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{

    return 15;
}

@end
