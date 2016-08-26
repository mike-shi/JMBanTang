//
//  JMListModel.h
//  JMHalfSugar
//
//  Created by Jimmy on 16/6/15.
//  Copyright © 2016年 HDCircles. All rights reserved.
//

#import <Foundation/Foundation.h>
@class JMListDetailProductModel;
@interface JMListModel : NSObject


//"id":"8763",
//"type":"",
//"type_id":"",
//"title":"办公室必备神器，从此上班不煎熬",
//"desc":"作为一个上班狗，每天面对的最多的就是电脑吧。这时间一长，脖子也疼了，腰也酸了，屁股也大了，随便扭个头，听到喀喀喀的响声，所以我就去搜罗了一圈，仿佛发现了新世界，种草了一大堆，不能我一个人独享，忍不住赶紧分享给大家！",
//"category":"",
//"pic":"http://bt.img.17gwx.com/topic/0/87/elZYZw/800x440",
//"islike":false,
//"likes":"11083",
//"comments":"12",
//"views":"61180",
//"datestr":"08-15 09:00",
//"share_url":"http://m.ibantang.com/topic/detail/8763/",
//"share_pic":"http://bt.img.17gwx.com/topic/0/87/elZYZw/800x440",
//"is_show_like":true,
//"user":{
//    "user_id":"1",
//    "nickname":"小糖君",
//    "avatar":"http://7te7t9.com2.z0.glb.qiniucdn.com/000/00/00/01.jpg?v=2",
//    "is_official":1,
//    "attention_type":0
//},

/*
 *  listID
 */
@property (nonatomic, copy) NSString *listID;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *desc;

@property (nonatomic, copy) NSString *pic;

@property (nonatomic, copy) NSString *likes;

@property (nonatomic, assign) BOOL islike;

@property (nonatomic, copy) NSString *share_url;

@property (nonatomic, copy) NSString *share_pic;

//@property (nonatomic, copy) NSString *imageHost;

@property (nonatomic, copy) NSString *user_avatr_host;
/*
 *  product array
 */
@property (nonatomic, strong) NSArray *product_list;



@end
