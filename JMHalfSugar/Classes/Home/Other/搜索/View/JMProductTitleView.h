//
//  JMProductTitleView.h
//  JMHalfSugar
//
//  Created by Jimmy on 16/6/16.
//  Copyright © 2016年 HDCircles. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JMListDetailProductModel;

@interface JMProductTitleView : UIView
@property (nonatomic, strong) JMListDetailProductModel *model;
@property (nonatomic, assign) CGFloat contentOffsetY;
@end
