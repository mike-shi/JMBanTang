//
//  JLMessageFrame.h
//  01-QQ
//
//  Created by XinYou on 15-3-3.
//  Copyright (c) 2015年 vxinyou. All rights reserved.
//

// 正文的字体
#define JLTextFont [UIFont systemFontOfSize:15]

// 正文的内边距
#define JLTextPadding 20

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class JLMessage;

@interface JLMessageFrame : NSObject
/**
 *  头像的frame
 */
@property (nonatomic, assign, readonly) CGRect iconF;
/**
 *  时间的frame
 */
@property (nonatomic, assign, readonly) CGRect timeF;
/**
 *  文本信息的frame
 */
@property (nonatomic, assign, readonly) CGRect textF;
/**
 *  cell的高度
 */
@property (nonatomic, assign, readonly) CGFloat cellHeight;
/**
 *  数据模型
 */
@property (nonatomic, strong) JLMessage *message;

@end
