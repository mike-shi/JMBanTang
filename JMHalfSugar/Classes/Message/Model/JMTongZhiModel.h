//
//  JMTongZhiModel.h
//  JMHalfSugar
//
//  Created by mike on 16/8/24.
//  Copyright © 2016年 HDCircles. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JMTongZhiModel : NSObject

@property(nonatomic,copy)NSString *iconName;

@property(nonatomic,copy)NSString *nickName;

@property(nonatomic,copy)NSString *content;

@property(nonatomic,copy)NSString *btnName;

@property(nonatomic,copy)NSString *dataStr;

+(instancetype)modelWithIcon:(NSString *)iconName Name:(NSString *)nickName Content:(NSString *)content Btn:(NSString *)btnName Data:(NSString *)dataStr;

@end
