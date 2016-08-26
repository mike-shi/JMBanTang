//
//  JMRelationProView.h
//  JMHalfSugar
//
//  Created by mike on 16/8/25.
//  Copyright © 2016年 HDCircles. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JMSearchSingleGoodsModel,JMRelationProView;

@protocol JMRelationProViewDelagate <NSObject>

@optional

-(void)JMRelationProViewDidClick:(JMRelationProView *)proView proID:(NSString *)ID;

@end


@interface JMRelationProView : UIView

@property(nonatomic,strong)NSArray *modelArr;

@property(nonatomic,assign)id<JMRelationProViewDelagate> delegate;

@end
