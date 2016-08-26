//
//  UIImage+Extension.h
//  01-QQ
//
//  Created by XinYou on 15-3-4.
//  Copyright (c) 2015年 vxinyou. All rights reserved.
//

#import <UIKit/UIKit.h>

// 给UIImage这个类添加分类，让UIImage这个类增加一个对图片进行拉伸的方法
@interface UIImage (Extension)
+ (UIImage *)resizableImage:(NSString *)name;
@end
