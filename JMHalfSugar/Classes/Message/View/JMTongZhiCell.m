//
//  JMTongZhiCell.m
//  JMHalfSugar
//
//  Created by mike on 16/8/24.
//  Copyright © 2016年 HDCircles. All rights reserved.
//

#import "JMTongZhiCell.h"
#import "JMTongZhiModel.h"
//#import "<#header#>"

#define CellPadding 10
@interface JMTongZhiCell()
@property(nonatomic,weak)UIImageView *icon;
@property(nonatomic,weak)UILabel *nameLabel;
@property(nonatomic,weak)UILabel *contentLabel;
@property(nonatomic,weak)UILabel *tipLabel;
@property(nonatomic,weak)UILabel *dataLabel;
@end

@implementation JMTongZhiCell
+(instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString *ID = @"status";
    JMTongZhiCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[JMTongZhiCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }

    return cell;
    
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.backgroundColor = HWColor(240, 240, 240);
        // 点击cell的时候不要变色
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self setUpOriangle];
        
    }
    return self;
}

-(void)setUpOriangle{

    UIImageView *icon = [UIImageView new];
    [self.contentView addSubview:icon];
    _icon = icon;
    icon.layer.cornerRadius = 20;
    icon.layer.cornerRadius = 20;
    icon.layer.masksToBounds = YES;
    
    UILabel *nameLabel = [UILabel new];
    [self.contentView addSubview:nameLabel];
    nameLabel.font = [UIFont systemFontOfSize:14];
    _nameLabel = nameLabel;
    
    UILabel *contentLabel = [UILabel new];
    [self.contentView addSubview:contentLabel];
    contentLabel.numberOfLines = 0;
    contentLabel.font = [UIFont systemFontOfSize:13];
    _contentLabel = contentLabel;
    
    UILabel *tipLabel = [UILabel new];
    [self.contentView addSubview:tipLabel];
    tipLabel.textColor = [UIColor blueColor];
    tipLabel.font = [UIFont systemFontOfSize:13];
    _tipLabel = tipLabel;
    
    UILabel *dataLabel = [UILabel new];
    [self.contentView addSubview:dataLabel];
    dataLabel.textColor = HWColor(100, 100, 100);
    dataLabel.font = [UIFont systemFontOfSize:12];
    _dataLabel = dataLabel;
    
    

    icon.sd_layout.topSpaceToView(self.contentView,CellPadding).leftSpaceToView(self.contentView,CellPadding).widthIs(40).heightEqualToWidth(0);
    nameLabel.sd_layout.topSpaceToView(self.contentView,CellPadding).leftSpaceToView(icon,CellPadding).widthIs(200).heightIs(20);
    
    contentLabel.sd_layout.topSpaceToView(nameLabel,CellPadding).leftSpaceToView(icon,CellPadding).rightSpaceToView(self.contentView,40).autoHeightRatio(0);
    
    tipLabel.sd_layout.topSpaceToView(contentLabel,CellPadding).leftEqualToView(contentLabel).widthIs(200).heightIs(20);
    
    dataLabel.sd_layout.topSpaceToView(tipLabel,CellPadding).leftEqualToView(contentLabel).widthIs(200).heightIs(20);
    
    [self setupAutoHeightWithBottomView:dataLabel bottomMargin:10];
}

-(void)setModel:(JMTongZhiModel *)model{

    _model = model;
    
    [_icon sd_setImageWithURL:[NSURL URLWithString:model.iconName] placeholderImage:[UIImage imageNamed:PlaceHolderImage]];

    _nameLabel.text = model.nickName;
    
    _contentLabel.text = model.content;
    
    _tipLabel.text = model.btnName;
    
    _dataLabel.text = model.dataStr;
    
}

@end
