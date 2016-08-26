//
//  MikeLaberlItem.m
//  
//
//  Created by mike on 16/3/30.
//
//

#import "MikeLaberlItem.h"
#import "ILSaveTool.h"


@implementation MikeLaberlItem
//- (void)setText:(NSString *)text
//{
//    _text = text;
//    
//    [ILSaveTool setObject:text forKey:self.text];
//}
//
//- (void)setName:(NSString *)name
//
//{
//    [super setName:name];
//    
//    _text = [ILSaveTool objectForKey:self.name];
//}
+(instancetype)iconWithIcon:(NSString *)icon Name:(NSString *)name arrowClass:(Class )arrowClass{
    MikeLaberlItem *item=[super iconWithIcon:icon Name:name];
    item.arrowClass=arrowClass;
    return item;
    
}

@end
