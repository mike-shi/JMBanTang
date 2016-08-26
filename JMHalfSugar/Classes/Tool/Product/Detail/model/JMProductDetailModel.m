//
//  JMCommentModel.m
//  JMHalfSugar
//
//  Created by Jimmy on 16/6/16.
//  Copyright © 2016年 HDCircles. All rights reserved.
//

#import "JMProductDetailModel.h"
#import "JMCommentModel.h"
#import "JMCommentUsersModel.h"
#import "JMLikeListModel.h"
@implementation JMProductDetailModel

+(NSDictionary *)objectClassInArray{
    
    return @{
             @"comment_list":@"JMCommentModel",
             @"likeUser":@"JMLikeListModel"
             
             };
    
}

+(NSDictionary *)replacedKeyFromPropertyName{

    return @{
             @"share_URL":@"url"
             };

}

@end
