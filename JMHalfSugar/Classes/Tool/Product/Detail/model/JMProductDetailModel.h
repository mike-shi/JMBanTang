//

//
//  JMProductDetailModel.h
//  JMHalfSugar
//
//  Created by Jimmy on 16/6/16.
//  Copyright © 2016年 HDCircles. All rights reserved.
//

#import "JMListDetailProductModel.h"
@class JMCommentModel,JMListDetailProductModel;
@interface JMProductDetailModel : NSObject;
/*
 *  comment list
 */
@property (nonatomic, strong) NSArray *comment_list;
/*
 *  share URL
 */
@property (nonatomic, copy) NSString *share_URL;
/*
 *  like users
 */
@property (nonatomic, strong) NSArray *likes_list;


@property(nonatomic,strong)JMListDetailProductModel *product;


/*
 islike,
 comments,
 product{},
 id,
 likes_list[],
 comment_list[],
 likes,
 commodity,
 iscomments
 */
//+ (instancetype)productDetailModelWithDictionary:(NSDictionary *)dict;
@end
