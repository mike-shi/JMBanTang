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
#import "MJExtension.h"
#import "AFNetworking.h"
#import "NSObject+AFNetworking.h"
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

+(id)getRelationWithObjID:(NSString *)proID completionHandler:(MyCallback)callback{

    //http://open4.bantangapp.com/product/relation?
//    app_id=com.jzyd.BanTang&client_id=bt_app_android&client_secret=ffcda7a1c4ff338e05c42e7972ba7b8d&track_user_id=&oauth_token=&track_deviceid=866656025428444&track_device_info=ALE-TL00&channel_name=UMENG_CHANNEL&app_installtime=1470240517&app_versions=5.8.6&os_versions=5.0.2&screensize=720&v=18&object_id=185223&type_id=2
    
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
    params[@"object_id"] = proID;
//    params[@"sort_type"] = @"0";
//    params[@"page"] = @"0";
    params[@"type_id"] = @"2";
    
    return [self GET:@"http://open4.bantangapp.com/product/relation" parameters:params progress:nil completionHandler:^(id responseObj, NSError *error) {
        callback(responseObj);
    }];
    
}

+ (id)getSearchWithText:(NSString *)text completionHandler:(MyCallback)callback{

    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"app_id"] = @"com.jzyd.BanTang";
    params[@"client_id"] = @"bt_app_android";
    params[@"client_secret"] = @"ffcda7a1c4ff338e05c42e7972ba7b8d";
    params[@"track_user_id"] = @"http://www.baidu.com";
    params[@"track_deviceid"] = @"866656025428444";
    params[@"track_device_info"] = @"ALE-TL00";
    params[@"channel_name"] = @"UMENG_CHANNEL";
    params[@"app_installtime"] = @"1470240517";
    params[@"app_versions"] = @"5.8.6";
    params[@"os_versions"] = @"5.0.2";
    params[@"screensize"] = @"720";
    params[@"v"] = @"18";
    params[@"keyword"] = text;
    params[@"sort_type"] = @"0";
    params[@"page"] = @"0";
    params[@"pagesize"] = @"20";
    
    return [self GET:@"http://open4.bantangapp.com/search/product/listByKeyword" parameters:params progress:nil completionHandler:^(id responseObj, NSError *error) {
        callback(responseObj);
    }];

}

+ (id)getSearchWithText:(NSString *)text Page:(NSString *)pageNum completionHandler:(MyCallback)callback{

    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"app_id"] = @"com.jzyd.BanTang";
    params[@"client_id"] = @"bt_app_android";
    params[@"client_secret"] = @"ffcda7a1c4ff338e05c42e7972ba7b8d";
    params[@"track_user_id"] = @"http://www.baidu.com";
    params[@"track_deviceid"] = @"866656025428444";
    params[@"track_device_info"] = @"ALE-TL00";
    params[@"channel_name"] = @"UMENG_CHANNEL";
    params[@"app_installtime"] = @"1470240517";
    params[@"app_versions"] = @"5.8.6";
    params[@"os_versions"] = @"5.0.2";
    params[@"screensize"] = @"720";
    params[@"v"] = @"18";
    params[@"keyword"] = text;
    params[@"sort_type"] = @"0";
    params[@"page"] = pageNum;
    params[@"pagesize"] = @"20";
    
    return [self GET:@"http://open4.bantangapp.com/search/product/listByKeyword" parameters:params progress:nil completionHandler:^(id responseObj, NSError *error) {
        callback(responseObj);
    }];

    

}

//+ (NSArray *)createSearchSingleGoodsModelByStr:(NSString *)text
//{
//    
//    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
//
//
//
//    // 3.发送请求
//     NSMutableArray *singleGoods = [NSMutableArray array];
//    [mgr POST:@"http://open4.bantangapp.com/search/product/listByKeyword" parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
//        
//    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//
//        NSArray *dataArray = responseObject[@"data"];
//
//        NSArray *arr = [JMSearchSingleGoodsModel objectArrayWithKeyValuesArray:dataArray];
//
//        [singleGoods addObjectsFromArray:arr];
//        
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
// 
//        HWLog(@"请求失败-%@", error);
//    }];
//    
//    return singleGoods;
//    
//}


@end
