//
//  JMUserRecommendTool.m
//  JMHalfSugar
//
//  Created by Jimmy on 16/6/15.
//  Copyright © 2016年 HDCircles. All rights reserved.
//

#import "JMUserRecommendTool.h"
#import "JMUserRecommendModel.h"
//#import "AFNetworking.h"
#import "NSObject+AFNetworking.h"
@implementation JMUserRecommendTool
+ (id)getSearchWithListID:(NSString *)ListID completionHandler:(MyCallback)callback{
    
    
    //     http://open4.bantangapp.com/topic/newInfo?app_id=com.jzyd.BanTang&client_id=bt_app_android&client_secret=ffcda7a1c4ff338e05c42e7972ba7b8d&track_user_id=&oauth_token=&track_deviceid=866656025428444&track_device_info=ALE-TL00&channel_name=UMENG_CHANNEL&app_installtime=1470240517&app_versions=5.8.6&os_versions=5.0.2&screensize=720&v=18&id=8763&trace_id=&relate_pid=&statistics_uv=1&is_night=0
    
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
    params[@"id"] = ListID;
    //    params[@"sort_type"] = @"0";
    params[@"statistics_uv"] = @"1";
    params[@"is_night"] = @"0";
//    params[@"comments_pagesize"]=@"10";
    
    return [self GET:@"http://open4.bantangapp.com/topic/newInfo?" parameters:params progress:nil completionHandler:^(id responseObj, NSError *error) {
        callback(responseObj);
    }];
    
}


//+ (NSArray *)createUserRecommendModelWithListID:(NSString *)listID
//{
//    if (![listID isEqualToString:@"1872"]) {
//        return nil;
//    }else {
//        NSMutableArray *userRecommendArray = [NSMutableArray array];
//        NSString *path = [[NSBundle mainBundle] pathForResource:@"用户推荐" ofType:nil];
//        NSData *JSONData = [NSData dataWithContentsOfFile:path];
//        //json to dictionary
//        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:JSONData options:NSJSONReadingAllowFragments error:nil];
//        NSDictionary *data = dict[@"data"];
//        
//        NSArray *list = data[@"list"];
//        [list enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//            JMUserRecommendModel *model = [JMUserRecommendModel userRecommendWithDictionary:obj];
//            [userRecommendArray addObject:model];
//        }];
//        return userRecommendArray;
//        
//    }
//       return nil;
//}
@end
