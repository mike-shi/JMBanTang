//
//  JMListModel.m
//  JMHalfSugar
//
//  Created by Jimmy on 16/6/15.
//  Copyright © 2016年 HDCircles. All rights reserved.
//

#import "JMListModel.h"
#import "JMListDetailProductModel.h"
@implementation JMListModel

+ (NSDictionary *)objectClassInArray{
    return @{
             @"product_list" : @"JMListDetailProductModel"
             };
}


+ (NSDictionary *)replacedKeyFromPropertyName{
    return @{
             @"detailText":@"desc",
             @"listID":@"id",
             @"likesNum":@"likes",
             @"imageUrl":@"pic"
             };
}


@end
