//
//  JMRelationProCell.m
//  JMHalfSugar
//
//  Created by mike on 16/8/25.
//  Copyright © 2016年 HDCircles. All rights reserved.
//

#import "JMRelationProCell.h"
#import "JMSearchSingleGoodsModel.h"

@interface JMRelationProCell()
@property (weak, nonatomic) IBOutlet UIImageView *productImageView;
@property (weak, nonatomic) IBOutlet UILabel *proNameLabel;

@property (weak, nonatomic) IBOutlet UILabel *proPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *likesNumLabel;

@end

@implementation JMRelationProCell



-(void)setGoodsModel:(JMSearchSingleGoodsModel *)goodsModel{

//    _model = model;

    _goodsModel = goodsModel;
    [_productImageView sd_setImageWithURL:[NSURL URLWithString:goodsModel.pic] placeholderImage:[UIImage imageNamed:PlaceHolderImage]];
    _proNameLabel.text = goodsModel.productName;

    _proPriceLabel.text =[NSString stringWithFormat:@"$%@",goodsModel.price];
    _likesNumLabel.text = goodsModel.likeNumbers;


}

@end
