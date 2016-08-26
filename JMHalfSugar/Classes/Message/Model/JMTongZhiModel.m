
//
//  JMTongZhiModel.m
//  JMHalfSugar
//
//  Created by mike on 16/8/24.
//  Copyright © 2016年 HDCircles. All rights reserved.
//

#import "JMTongZhiModel.h"

@implementation JMTongZhiModel
+(instancetype)modelWithIcon:(NSString *)iconName Name:(NSString *)nickName Content:(NSString *)content Btn:(NSString *)btnName Data:(NSString *)dataStr{

    JMTongZhiModel *tongzhi = [[JMTongZhiModel alloc]init];
    tongzhi.iconName = iconName;
    tongzhi.nickName = nickName;
    tongzhi.content = content;
    tongzhi.btnName = btnName;
    tongzhi.dataStr = dataStr;
    
    return tongzhi;

}
@end
