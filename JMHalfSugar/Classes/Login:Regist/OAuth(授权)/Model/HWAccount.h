//
//  HWAccount.h
//  黑马微博2期
//
//  Created by apple on 14-10-12.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HWAccount : NSObject <NSCoding>
/**　string	用于调用access_token，接口获取授权后的access token。*/
@property (nonatomic, copy) NSString *access_token;

/**　string	access_token的生命周期，单位是秒数。*/
@property (nonatomic, copy) NSNumber *expires_in;

/**　string	当前授权用户的UID。*/
@property (nonatomic, copy) NSString *uid;

/**	access token的创建时间 */
@property (nonatomic, strong) NSDate *created_time;

/**
 *  user name
 */
@property(nonatomic,copy)NSString *name;

@property(nonatomic,copy)NSString *profile_image_url;


+ (instancetype)accountWithDict:(NSDictionary *)dict;
@end
