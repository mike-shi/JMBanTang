//
//  JMListDetailTool.h
//  JMHalfSugar
//
//  Created by Jimmy on 16/6/11.
//  Copyright © 2016年 HDCircles. All rights reserved.
//
typedef void (^MyCallback)(id obj);
#import <Foundation/Foundation.h>
@class JMListModel;
@interface JMListDetailTool : NSObject

+ (id)getSearchWithListID:(NSString *)ListID completionHandler:(MyCallback)callback;
//+ (JMListModel *)createListModelWithListID:(NSString *)listID;
@end
