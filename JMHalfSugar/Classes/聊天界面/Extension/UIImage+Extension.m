//
//  UIImage+Extension.m
//  01-QQ
//
//  Created by XinYou on 15-3-4.
//  Copyright (c) 2015年 vxinyou. All rights reserved.
//

#import "UIImage+Extension.h"

@implementation UIImage (Extension)

/**
 *  返回一张可以随意拉伸，但四个角不变形的图片
 *
 *  @param name 图片名字
 */
+ (UIImage *)resizableImage:(NSString *)name{

    UIImage *resPic = [UIImage imageNamed:name];
    
    CGFloat w = resPic.size.width * 0.5;
    CGFloat h = resPic.size.height * 0.5;
    
    UIImage *desPic = [resPic resizableImageWithCapInsets:UIEdgeInsetsMake(h, w, h, w)];
    
    return desPic;
}

@end
