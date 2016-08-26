//
//  JLMessage.m
//  01-QQ
//
//  Created by XinYou on 15-3-3.
//  Copyright (c) 2015年 vxinyou. All rights reserved.
//

#import "JLMessage.h"

@implementation JLMessage

- (instancetype)initWithDict:(NSDictionary *)dict{

    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    
    return self;
}


+ (instancetype)messageWithDict:(NSDictionary *)dict{

    return [[self alloc] initWithDict:dict];
}

@end
