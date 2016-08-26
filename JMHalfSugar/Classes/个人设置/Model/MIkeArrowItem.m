//
//  MIkeArrowItem.m
//  
//
//  Created by mike on 16/3/27.
//
//

#import "MIkeArrowItem.h"

@implementation MIkeArrowItem
+(instancetype)iconWithIcon:(NSString *)icon Name:(NSString *)name arrowClass:(Class )arrowClass{
    MIkeArrowItem *item=[super iconWithIcon:icon Name:name];
    item.arrowClass=arrowClass;
    return item;
    
}
@end
