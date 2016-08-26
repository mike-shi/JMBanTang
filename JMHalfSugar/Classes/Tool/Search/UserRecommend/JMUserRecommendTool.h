//
//  JMUserRecommendTool.h
//  JMHalfSugar
//
//  Created by Jimmy on 16/6/15.
//  Copyright © 2016年 HDCircles. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^MyCallback)(id obj);
@interface JMUserRecommendTool : NSObject


//+ (NSArray *)createUserRecommendModelWithListID:(NSString *)listID;

+ (id)getSearchWithListID:(NSString *)ListID completionHandler:(MyCallback)callback;
@end
