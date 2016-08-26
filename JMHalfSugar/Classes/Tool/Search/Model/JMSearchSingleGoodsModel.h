//
//  JMSearchSingleGoodsModel.h
//  JMHalfSugar
//
//  Created by Jimmy on 16/6/15.
//  Copyright © 2016年 HDCircles. All rights reserved.
//

#import <Foundation/Foundation.h>
//"id":"118891",
//"title":"美的 MK-HJ1761热水壶",
//"desc":"美的一款1.7L的热水壶，烧开一壶水大概需要4分钟。推荐点是它的三层防烫设计，水烧开后壶面温度只有43℃。外观材质为珠光注塑壶身，颜色是不好理解的西瓜糖蓝。内胆无缝一体，62°壶嘴能够保障倒水的时候不会滴到壶身。还有静音功能，烧水的时候比传统的热水壶声音要小一些。",
//"price":"99.0",
//"product_type":"",
//"platform":"2",
//"item_id":"523104090877",
//"url":"http://s.click.taobao.com/t?e=m%3D2%26s%3Dq5mzPvWr%2FzVw4vFB6t2Z2ueEDrYVVa64yK8Cckff7TVRAdhuF14FMQ93tfhCCPWT79%2FTFaMDK6QSCaKErieudzDk0PPeYwvvyUPcP7QvvKoJYf%2Fg8IP1YmPJLBziAmVvepoHwcTgu%2FDYSzBlYqkIBUBTg0ZOYCEC6As%2FrokO2ZOiZ%2BQMlGz6FQ%3D%3D&unid=bantangapp",
//"pic":"http://bt.img.17gwx.com/product1/11/88/c1BWbFhf/w450",
//"pics":[
//        "http://bt.img.17gwx.com/product1/11/88/c1BWbFhf/w450"
//        ],
//"islike":false,
//"likes":"1150"
@interface JMSearchSingleGoodsModel : NSObject
/*
 *  imageUrl
 */
@property(nonatomic,copy)NSString *productID;
@property (nonatomic, copy) NSString *productName;
@property (nonatomic, copy) NSString *detailText;
@property (nonatomic, copy) NSString *price;
@property (nonatomic, copy) NSString *imageUrl;
@property (nonatomic, copy) NSString *pic;
@property (nonatomic, copy) NSString *likeNumbers;
/*
 *  author
 */

@end
