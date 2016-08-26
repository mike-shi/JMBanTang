//
//  JLMessageCell.h
//  01-QQ
//
//  Created by XinYou on 15-3-3.
//  Copyright (c) 2015年 vxinyou. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JLMessageFrame;

@interface JLMessageCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@property (nonatomic, strong) JLMessageFrame *messageFrame;

@end
