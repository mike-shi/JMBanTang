//
//  JMPorductDetailTool.m
//  JMHalfSugar
//
//  Created by Jimmy on 16/6/16.
//  Copyright © 2016年 HDCircles. All rights reserved.
//

#import "JMPorductDetailTool.h"
#import "JMProductDetailModel.h"
#import "JMCommentModel.h"
#import "NSObject+AFNetworking.h"
@implementation JMPorductDetailTool


+ (id)getSearchWithProID:(NSString *)ProID completionHandler:(MyCallback)callback{
    
    
//        http://open4.bantangapp.com/product/newInfo?app_id=com.jzyd.BanTang&client_id=bt_app_android&client_secret=ffcda7a1c4ff338e05c42e7972ba7b8d&track_user_id=&oauth_token=&track_deviceid=866656025428444&track_device_info=ALE-TL00&channel_name=UMENG_CHANNEL&app_installtime=1470240517&app_versions=5.8.6&os_versions=5.0.2&screensize=720&v=18&id=185223&trace_id=&page=0&pagesize=10&comments_pagesize=10
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"app_id"] = @"com.jzyd.BanTang";
    params[@"client_id"] = @"bt_app_android";
    params[@"client_secret"] = @"ffcda7a1c4ff338e05c42e7972ba7b8d";
//    params[@"track_user_id"] = @"http://www.baidu.com";
    params[@"track_deviceid"] = @"866656025428444";
    params[@"track_device_info"] = @"ALE-TL00";
    params[@"channel_name"] = @"UMENG_CHANNEL";
    params[@"app_installtime"] = @"1470240517";
    params[@"app_versions"] = @"5.8.6";
    params[@"os_versions"] = @"5.0.2";
    params[@"screensize"] = @"720";
    params[@"v"] = @"18";
    params[@"id"] = ProID;
    //    params[@"sort_type"] = @"0";
    params[@"page"] = @"0";
    params[@"pagesize"] = @"10";
    params[@"comments_pagesize"]=@"10";
    
    return [self GET:@"http://open4.bantangapp.com/product/newInfo" parameters:params progress:nil completionHandler:^(id responseObj, NSError *error) {
        callback(responseObj);
    }];
    
}
//
//+(JMProductDetailModel *)createProductDetailModel
//{
//    NSString *path = [[NSBundle mainBundle] pathForResource:@"stylenand 打底霜" ofType:nil];
//    NSData *JSONData = [NSData dataWithContentsOfFile:path];
//    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:JSONData options:NSJSONReadingAllowFragments error:nil];
//    NSDictionary *dataDict = dict[@"data"];
//    NSDictionary *dataProduct = dict[@"data"][@"product"];
//    JMProductDetailModel *model = [JMProductDetailModel productDetailModelWithDictionary:dataDict];
//    [model setValuesForKeysWithDictionary:dataProduct];
//    return model;
//}
+ (NSMutableArray  *)createCommentList:(NSArray *)commentData
{
    NSMutableArray *commentArray = [NSMutableArray new];
    if (commentData.count>0) {
        [commentData enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            JMCommentModel *model = [JMCommentModel commentWithDictionary:obj]
            ;
            [commentArray addObject:model];
        }];
    }else {
        return nil;
    }
    return commentArray;
}
@end
