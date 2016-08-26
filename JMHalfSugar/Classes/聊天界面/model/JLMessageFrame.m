//
//  JLMessageFrame.m
//  01-QQ
//
//  Created by XinYou on 15-3-3.
//  Copyright (c) 2015年 vxinyou. All rights reserved.
//

#import "JLMessageFrame.h"
#import "JLMessage.h"
#import "NSString+Extension.h"

@implementation JLMessageFrame

- (void)setMessage:(JLMessage *)message{
    // 固定写法
    _message = message;
    
    // 间距
    CGFloat padding = 10;

    // 屏幕的宽度
    CGFloat screenW = [UIScreen mainScreen].bounds.size.width;
    
    // 1,时间
    if (message.hideTime == NO) {// 显示时间
        CGFloat timeX = 0;
        CGFloat timeY = 0;
        CGFloat timeW = screenW;
        CGFloat timeH = 40;
        _timeF = CGRectMake(timeX, timeY, timeW, timeH);
    }
    
    // 2,头像
    CGFloat iconY = CGRectGetMaxY(_timeF) + padding;
    CGFloat iconW = 40;
    CGFloat iconH = 40;
    CGFloat iconX;
    if (message.type == JLMessageTypeOtherToMe) {// 别人发给自己
        
        iconX = padding;
        
    } else {// 自己发给别人
    
        iconX = screenW - padding - iconW;
    }
    _iconF = CGRectMake(iconX, iconY, iconW, iconH);
    
    // 3,正文
    CGFloat textY = iconY;
    // 文本信息的最大尺寸
    CGSize textMaxSize = CGSizeMake(200, MAXFLOAT);
    // 文本信息的真实尺寸
    CGSize textRealSize = [message.text sizeWithFont:JLTextFont maxSize:textMaxSize];
    // 按钮最终的真实尺寸(按钮的内部有个Label用于显示文本，默认情况，Lable填充满按钮
    // 如果想让Lable中的文字跟按钮有一定的边距。。。)
    CGSize textBtnSize = CGSizeMake(textRealSize.width + JLTextPadding * 2, textRealSize.height + JLTextPadding * 2);
    
    CGFloat textX;
    if (message.type == JLMessageTypeOtherToMe) {// 别人发给自己
        textX = CGRectGetMaxX(_iconF) + padding;
    }else{
        textX = iconX - padding - textBtnSize.width;
    }
//    _textF = CGRectMake(textX, textY, textBtnSize.width, textBtnSize.height);
    _textF = (CGRect){{textX, textY}, textBtnSize};// 两种写法是一样的
 
    // 4,cell的高度
    CGFloat textMaxY = CGRectGetMaxY(_textF);
    CGFloat iconMaxY = CGRectGetMaxY(_iconF);
    _cellHeight = MAX(textMaxY, iconMaxY) + padding;
}

@end
