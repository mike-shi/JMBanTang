//
//  JMListDetailTool.m
//  JMHalfSugar
//
//  Created by Jimmy on 16/6/11.
//  Copyright © 2016年 HDCircles. All rights reserved.
//

#import "JMListDetailTool.h"
#import "JMListModel.h"
#import "NSObject+AFNetworking.h"
#define ListJSONName @[@"1872",@"1898"]
@implementation JMListDetailTool

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
//+ (JMListModel *)createListModelWithListID:(NSString *)listID
//{
//    NSDictionary *dict = [[self class] readDataFromJSONWithFileName:listID];
//    if (!dict) {
//        return nil;
//    }
//    NSDictionary *dataDict = dict[@"data"];
//    JMListModel *model = [JMListModel listModelWithDictionary:dataDict andListID:listID];
//    return model;
//}
//+ (NSDictionary *)readDataFromJSONWithFileName:(NSString *)fileName;
//{
//    BOOL isExist = NO;
//    for (NSString *name in ListJSONName) {
//        if ([name isEqualToString:fileName]) {
//            isExist = YES;
//        }
//    }
//    if (!isExist) {
//        return nil;
//    }else {
//        NSString *path = [[NSBundle mainBundle] pathForResource:fileName ofType:nil];
//        NSData *data = [NSData dataWithContentsOfFile:path];
//        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
//        return dict;
//    }
//    return nil;
//}
@end
