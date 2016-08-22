//
//  JMSearchTool.m
//  JMHalfSugar
//
//  Created by Jimmy on 16/6/11.
//  Copyright © 2016年 HDCircles. All rights reserved.
//

#import "JMSearchTool.h"
#import "JMSearchModel.h"
#import "JMSerchLishModel.h"
#import "JMSearchSingleGoodsModel.h"
@implementation JMSearchTool
+ (NSMutableArray *)createSearchModel
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"搜索列表" ofType:nil];
    NSData *data = [NSData dataWithContentsOfFile:path];
    //json to dictionary
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    NSArray *dataArr = [dict objectForKey:@"data"];
    NSMutableArray *searchArr = [NSMutableArray array];
    for (NSInteger i = 0; i < dataArr.count; i++) {
        JMSearchModel *searchModel = [JMSearchModel searchModelWithDictionary:dataArr[i]];
        [searchArr addObject:searchModel];
    }

    return searchArr;
}
+ (NSMutableArray *)createSearchListModel
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"搜索清单" ofType:nil];
    NSData *data = [NSData dataWithContentsOfFile:path];
    //json to dictionary
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    NSArray *dataArr = [dict objectForKey:@"data"];
    NSMutableArray *searchArr = [NSMutableArray array];
    for (NSInteger i = 0; i < dataArr.count; i++) {
        JMSerchLishModel *model = [JMSerchLishModel searchListModelWithDictionary:dataArr[i]];
        [searchArr addObject:model];
    }
    return searchArr;
    
    return nil;
}
+ (NSArray *)createSearchSingleGoodsModel
{
    NSString *path = [[NSBundle mainBundle]pathForResource:@"底妆" ofType:nil];
    NSData *jsonData = [NSData dataWithContentsOfFile:path];
    NSError *error = nil;
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:&error];
    if (error) {
        return nil;
    }
    NSArray *dataArray = dict[@"data"][@"list"];
    NSMutableArray *singleGoods = [NSMutableArray array];
    [dataArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        JMSearchSingleGoodsModel *model = [JMSearchSingleGoodsModel searchSingleGoodsWithDictionary:obj];
        [singleGoods addObject:model];
    }];
    return singleGoods;
    
}


@end
