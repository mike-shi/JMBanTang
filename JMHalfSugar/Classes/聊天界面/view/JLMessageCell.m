//
//  JLMessageCell.m
//  01-QQ
//
//  Created by XinYou on 15-3-3.
//  Copyright (c) 2015年 vxinyou. All rights reserved.
//

#import "JLMessageCell.h"
#import "JLMessage.h"
#import "JLMessageFrame.h"
#import "JLMessageCell.h"
#import "UIImage+Extension.h"

@interface JLMessageCell()
/**
 *  信息发送时间
 */
@property (nonatomic, weak) UILabel *timeView;
/**
 *  头像
 */
@property (nonatomic, weak) UIImageView *iconView;
/**
 *  信息内容
 */
@property (nonatomic, weak) UIButton *textView;

@end

@implementation JLMessageCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // 子控件的创建和初始化
        // 1,时间
        UILabel *timeView = [[UILabel alloc] init];
        // 设置文本居中显示
        timeView.textAlignment = NSTextAlignmentCenter;
        // 设置文本颜色
        timeView.textColor = [UIColor grayColor];
        // 设置文本字体
        timeView.font = [UIFont systemFontOfSize:13];
        
        [self.contentView addSubview:timeView];
        self.timeView = timeView;
        
        // 2,头像
        UIImageView *iconView = [[UIImageView alloc] init];
        [self.contentView addSubview:iconView];
        self.iconView = iconView;
        
        // 3,文本信息
        UIButton *textView = [[UIButton alloc] init];
        // 设置自动换行
        textView.titleLabel.numberOfLines = 0;
        // 设置字体
        textView.titleLabel.font = JLTextFont;
        // 设置文本距离UIButton的边距
        textView.contentEdgeInsets = UIEdgeInsetsMake(JLTextPadding, JLTextPadding, JLTextPadding, JLTextPadding);
        // 设置文本颜色
        [textView setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.contentView addSubview:textView];
        self.textView = textView;
        
        // 4,清空cell的背景色，这样才能看见UITableView的背景色
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

+ (instancetype)cellWithTableView:(UITableView *)tableView{

    static NSString *ID = @"message";
    JLMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[JLMessageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    return cell;
}

- (void)setMessageFrame:(JLMessageFrame *)messageFrame{
    // 固定写法
    _messageFrame = messageFrame;
    
    JLMessage *message = messageFrame.message;
    
    // 1,时间
    self.timeView.text = message.time;
    self.timeView.frame = messageFrame.timeF;
    
    // 2,头像
    NSString *icon = (message.type == JLMessageTypeMeToOther ? @"me" : @"other");
    self.iconView.image = [UIImage imageNamed:icon];
    self.iconView.frame = messageFrame.iconF;
    
    // 3,文本信息
    [self.textView setTitle:message.text forState:UIControlStateNormal];
    self.textView.frame = messageFrame.textF;
    
    // 4,正文的背景
    if (message.type == JLMessageTypeMeToOther) {// 自己发给别人，蓝色背景
        [self.textView setBackgroundImage:[UIImage resizableImage:@"chat_send_nor"] forState:UIControlStateNormal];
    }else{// 别人发给自己，白色背景
        [self.textView setBackgroundImage:[UIImage resizableImage:@"chat_recive_nor"] forState:UIControlStateNormal];
    }
}

@end
