//
//  myTableVIewCell.m
//  
//
//  Created by mike on 16/3/27.
//
//

#import "myTableVIewCell.h"
#import "MIkeItem.h"
#import "MIkeArrowItem.h"
#import "MIkeSwitchItem.h"
#import "MikeLaberlItem.h"
//#import "UIImage+Tool.h"
@interface myTableVIewCell()

@property(nonatomic,strong )UISwitch* switch1;
@property(nonatomic,strong)UIImageView *imgView;
@property(nonatomic,strong)UILabel *LabelView;

@end
@implementation myTableVIewCell
-(UILabel *)LabelView{

    if (_LabelView==nil) {
        
        _LabelView = [[UILabel alloc] init];
        _LabelView.bounds = CGRectMake(0, 0, 100, 44);
        _LabelView.textColor = [UIColor blackColor];
        _LabelView.textAlignment = NSTextAlignmentRight;
        
        _LabelView.font=[UIFont systemFontOfSize:12];
   
    }
    return _LabelView;
}
-(UISwitch *)switch1{


    if (_switch1==nil) {
        _switch1=[[UISwitch alloc]init];
        _switch1.on=YES;
//        NSLog(@"swtich alloc");
        
    }
    return _switch1;
    
}
-(UIImageView *)imgView{


    if (_imgView==nil) {
        _imgView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"CellArrow"]];
     
    }
    return _imgView;
}
-(void)setItem:(MIkeItem *)item{


    _item=item;
    self.textLabel.text=item.name;
    self.textLabel.numberOfLines = 1;
    //当字无法完全显示时，是否改变字体大小
    self.textLabel.adjustsFontSizeToFitWidth = YES;

    self.textLabel.font = [UIFont systemFontOfSize:13];
    if (_item.icon.length) {
        
        UIImage *iconImage=[UIImage imageNamed:item.icon];
        self.imageView.image=iconImage;
        CGFloat imageVIewX=self.contentView.bounds.size.height*0.8;
        
        self.imageView.frame=CGRectMake(0, 0, imageVIewX, imageVIewX);

    }
   
    
    [self setUp];//设置右边的
}
-(void)setUp
{

    if ([_item isKindOfClass:[MIkeArrowItem class]]) {
        self.accessoryView=self.imgView;
        
    }else if([_item isKindOfClass:[MIkeSwitchItem class]]){
        
        
        self.accessoryView=self.switch1;
 
    }
    else if([_item isKindOfClass:[MikeLaberlItem class]]){

        
        MikeLaberlItem *labelItem = (MikeLaberlItem *)_item;
        self.LabelView.text = labelItem.title;
           self.accessoryView = self.LabelView;
        
        
    }
    else{
        self.accessoryView=nil;
    }
}
+(instancetype)cellWithTableView:(UITableView *)tableView{

    static NSString *Id=@"cell";
    
    myTableVIewCell *cell = [tableView dequeueReusableCellWithIdentifier:Id ];
    
    
    if (cell==nil) {
        cell=[[myTableVIewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Id];
        
        cell.separatorInset=UIEdgeInsetsZero;
        cell.layoutMargins=UIEdgeInsetsZero;
        cell.preservesSuperviewLayoutMargins=NO;
    }
    return cell;
    
}

@end
