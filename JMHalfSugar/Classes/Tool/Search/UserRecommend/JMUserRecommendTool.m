//
//  JMUserRecommendTool.m
//  JMHalfSugar
//
//  Created by Jimmy on 16/6/15.
//  Copyright © 2016年 HDCircles. All rights reserved.
//

#import "JMUserRecommendTool.h"
#import "JMUserRecommendModel.h"
#import "AFNetworking.h"
@implementation JMUserRecommendTool
+ (NSArray *)createUserRecommendModelWithListID:(NSString *)listID
{
    if (![listID isEqualToString:@"1872"]) {
        return nil;
    }else {
        NSMutableArray *userRecommendArray = [NSMutableArray array];
        NSString *path = [[NSBundle mainBundle] pathForResource:@"用户推荐" ofType:nil];
        NSData *JSONData = [NSData dataWithContentsOfFile:path];
        //json to dictionary
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:JSONData options:NSJSONReadingAllowFragments error:nil];
        NSDictionary *data = dict[@"data"];
        
        NSArray *list = data[@"list"];
        [list enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            JMUserRecommendModel *model = [JMUserRecommendModel userRecommendWithDictionary:obj];
            [userRecommendArray addObject:model];
        }];
        return userRecommendArray;
        
    }
       return nil;
}
@end
