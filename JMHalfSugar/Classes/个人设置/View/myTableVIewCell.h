//
//  myTableVIewCell.h
//  
//
//  Created by mike on 16/3/27.
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class MIkeItem;
@interface myTableVIewCell :UITableViewCell
@property(nonatomic,strong)MIkeItem *item;

+(instancetype)cellWithTableView:(UITableView *)tableView;

@end
