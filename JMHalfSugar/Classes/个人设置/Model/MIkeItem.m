//
//  MIkeItem.m
//  
//
//  Created by mike on 16/3/26.
//
//

#import "MIkeItem.h"

@implementation MIkeItem
+(instancetype)iconWithIcon:(NSString *)icon Name:(NSString *)name{


//    MIkeItem *item=[[self alloc]init];
//    item.name=name;
//    item.icon=icon;
////    NSLog(@"%@",item);
 
    
    MIkeItem *item=[[self alloc]init];
   
        item.name=name;
        item.icon=icon;

          return item;
}
@end
