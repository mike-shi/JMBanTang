//
//  UpdatePersonaInfo.h
//  MKBanTang
//
//  Created by mike on 16/8/19.
//  Copyright © 2016年 mike. All rights reserved.
//

#import <UIKit/UIKit.h>

@class UpdatePersonaInfo;

@protocol UpdatePersonaInfoDelegate <NSObject>

@optional

-(void)UpdatePersonaInfoDidUpdate:(UpdatePersonaInfo *)update Name:(NSString *)name Desc:(NSString *)desc;

@end

@interface UpdatePersonaInfo : UIViewController

@property(nonatomic,assign)id<UpdatePersonaInfoDelegate> delegate;

@property(nonatomic,copy)NSString *name;
@property(nonatomic,copy)NSString *desc;

@end
