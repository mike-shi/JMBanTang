//
//  JMSearchTool.h
//  JMHalfSugar
//
//  Created by Jimmy on 16/6/11.
//  Copyright © 2016年 HDCircles. All rights reserved.
//
typedef void (^MyCallback)(id obj);
#import <Foundation/Foundation.h>
#define kCompetionHandlerBlock (void(^)(id model, NSError *error))completionHandler;
@interface JMSearchTool : NSObject
+ (NSMutableArray *)createSearchModel;
+ (NSMutableArray *)createSearchListModel;
//+ (NSArray *)createSearchSingleGoodsModelByStr:(NSString *)text;

+ (id)getSearchWithText:(NSString *)text completionHandler:(MyCallback)callback;

+(id)getRelationWithObjID:(NSString *)proID completionHandler:(MyCallback)callback;


//加载更多数据
+ (id)getSearchWithText:(NSString *)text Page:(NSString *)pageNum completionHandler:(MyCallback)callback;

@end

