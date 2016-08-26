//
//  NSString+Extension.h
//  01-QQ
//
//  Created by XinYou on 15-3-3.
//  Copyright (c) 2015年 vxinyou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

// 给NSString这个类添加一个分类，让NSString这个类增加一个计算字符串尺寸的方法
@interface NSString (Extension)

/**
 *  返回字符串所占用的尺寸
 *
 *  @param font    字符串的字体
 *  @param maxSize 字符串的最大尺寸
 */
- (CGSize)sizeWithFont:(UIFont*)font maxSize:(CGSize)maxSize;

@end
