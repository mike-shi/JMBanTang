//
//  JMTongZhiCell.h
//  JMHalfSugar
//
//  Created by mike on 16/8/24.
//  Copyright © 2016年 HDCircles. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JMTongZhiModel;

@interface JMTongZhiCell : UITableViewCell

@property(nonatomic,strong)JMTongZhiModel *model;

+(instancetype)cellWithTableView:(UITableView *)tableView;

@end
