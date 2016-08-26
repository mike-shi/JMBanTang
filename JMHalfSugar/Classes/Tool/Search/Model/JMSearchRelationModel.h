//
//  JMSearchRelationModel.h
//  JMHalfSugar
//
//  Created by mike on 16/8/25.
//  Copyright © 2016年 HDCircles. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JMSearchRelationModel : NSObject

//"id":"1674",
//"type_id":"1",
//"type":"0",
//"title":"大家都在买「第2期」",
//"pic":"http://bt.img.17gwx.com/topic/0/16/c1dZYA/620x330"

@property(nonatomic,copy)NSString *topicID;
@property(nonatomic,copy)NSString *title;
//@property(nonatomic,copy)NSString *price;
@property(nonatomic,copy)NSString *pic;
//@property(nonatomic,copy)NSString *likes;

@end
