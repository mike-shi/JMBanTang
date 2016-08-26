//
//  JMRelationView.h
//  JMHalfSugar
//
//  Created by mike on 16/8/25.
//  Copyright © 2016年 HDCircles. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JMSearchRelationModel,JMRelationView;


@protocol JMRelationViewDelegate <NSObject>

@optional

-(void)JMRelationViewDidClick:(JMRelationView *)proView proID:(NSString *)ID Image:(NSString *)imageName;

@end

@interface JMRelationView : UIView

@property(nonatomic,strong)NSArray *modelArr;

@property(nonatomic,assign)id<JMRelationViewDelegate> delegate;

@end
