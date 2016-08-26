//
//  JMPorductDetailTool.h
//  JMHalfSugar
//
//  Created by Jimmy on 16/6/16.
//  Copyright © 2016年 HDCircles. All rights reserved.
//
typedef void (^MyCallback)(id obj);
#import <Foundation/Foundation.h>

@class JMProductDetailModel;
@interface JMPorductDetailTool : NSObject
//+ (JMProductDetailModel *)createProductDetailModel;
+ (NSMutableArray *)createCommentList:(NSArray *)commentData;

+ (id)getSearchWithProID:(NSString *)ProID completionHandler:(MyCallback)callback;
@end
