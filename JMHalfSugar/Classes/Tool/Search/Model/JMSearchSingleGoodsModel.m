//
//  JMSearchSingleGoodsModel.m
//  JMHalfSugar
//
//  Created by Jimmy on 16/6/15.
//  Copyright © 2016年 HDCircles. All rights reserved.
//

#import "JMSearchSingleGoodsModel.h"
#import "MJExtension.h"
@implementation JMSearchSingleGoodsModel

-(NSDictionary *)replacedKeyFromPropertyName{

    return @{
             @"productID":@"id",
                  @"productName":@"title",
                  @"imageUrl":@"url",
                  @"detailText":@"desc",
                  @"likeNumbers":@"likes"
             
             };

}
@end
