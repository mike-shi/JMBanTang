//
//  JMSearchTopicCell.m
//  JMHalfSugar
//
//  Created by mike on 16/8/25.
//  Copyright © 2016年 HDCircles. All rights reserved.
//

#import "JMSearchTopicCell.h"
#import "JMSearchRelationModel.h"
@interface JMSearchTopicCell()
@property (weak, nonatomic) IBOutlet UIImageView *imagV;

@property (weak, nonatomic) IBOutlet UILabel *proName;

@end

@implementation JMSearchTopicCell

-(void)setModel:(JMSearchRelationModel *)model{

    _model = model;
    
    [_imagV sd_setImageWithURL:[NSURL URLWithString:model.pic] placeholderImage:[UIImage imageNamed:PlaceHolderImage]];
    
    _proName.text = model.title;

}

@end
