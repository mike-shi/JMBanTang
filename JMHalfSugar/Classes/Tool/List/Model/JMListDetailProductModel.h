//
//  JMListDetailProductModel.h
//  JMHalfSugar
//
//  Created by Jimmy on 16/6/15.
//  Copyright © 2016年 HDCircles. All rights reserved.
//

#import <Foundation/Foundation.h>
@class JMPictureModel,JMLikeListModel;

//"id":"189821",
//"title":"Sleep Science 记忆棉护腰靠垫",
//"desc":"对于需要伏案的学生党、上班族而言，长期久坐不动，现在腰部没有支撑的话，根本坐不住。于是，铛铛铛铛神器诞生——乳胶腰枕！释放腰椎压力，缓解工作疲劳，提高工作效率，呵护腰椎健康。一个软硬适中，厚薄适中，贴合身体曲线腰枕你值得拥有！	",
//"price":"169.0",
//"product_type":"",
//"platform":"4",
//"item_id":"",
//"url":"https://www.amazon.cn/dp/B00940NJDW?tag=bantangmodernfamily-23&t=bantangmodernfamily-23",
//"pic":"http://bt.img.17gwx.com/product1/18/98/c1lXbFNf/w600",
//"pics":[
//        {
//            "url":"http://bt.img.17gwx.com/product1/18/98/c1lXbFNf/w600",
//            "width":"900",
//            "height":"900"
//        }
//        ],
//"islike":false,
//"likes":"1584",
//"thumbnail_pic":"http://bt.img.17gwx.com/product1/18/98/c1lXbFNf/200x200"


@interface JMListDetailProductModel : NSObject
/*
 *  商品id
 */
@property (nonatomic, copy) NSString *productID;
/*
 *  topic _id
 */
@property (nonatomic, copy) NSString *topic_id;
/*
 *  商品图片数组
 */
@property (nonatomic, strong) NSArray<JMPictureModel *> *pics;

@property (nonatomic, strong) NSArray<JMPictureModel *> *pic;

@property (nonatomic, copy) NSString *title;
/*
 *  详情描述
 */
@property (nonatomic, copy) NSString *desc;
/*
 *  价格
 */
@property (nonatomic, copy) NSString *price;

@property (nonatomic, copy) NSString *platform;


@property(nonatomic,copy)NSString *url;

@property(nonatomic,copy)NSString *thumbnail_pic;


@end
