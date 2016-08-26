//
//  JLMessage.h
//  01-QQ
//
//  Created by XinYou on 15-3-3.
//  Copyright (c) 2015年 vxinyou. All rights reserved.
//

#import <Foundation/Foundation.h>
//定义一个枚举
typedef enum {
    // 枚举中的第一个元素默认=0，第二个元素=1，依次递增，也可以不写
    JLMessageTypeMeToOther = 0,//自己发给别人
    JLMessageTypeOtherToMe// 别人发给自己
} JLMessageType;



@interface JLMessage : NSObject
/**
 *  信息内容
 */
@property (nonatomic, copy) NSString *text;
/**
 *  信息发送时间
 */
@property (nonatomic, copy) NSString *time;
/**
 *  信息的类型(类型有两种，一种是自己发送给别人的信息，一种是别人发送给自己的信息)
 */
@property (nonatomic, assign) JLMessageType type;
/**
 *  是否隐藏时间(如果连续多条信息的时间相同，只能有一条信息显示时间)
 */
@property (nonatomic, assign) BOOL hideTime;

+ (instancetype)messageWithDict:(NSDictionary *)dict;

- (instancetype)initWithDict:(NSDictionary *)dict;

@end
