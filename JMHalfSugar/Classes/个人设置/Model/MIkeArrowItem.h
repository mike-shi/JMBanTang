//
//  MIkeArrowItem.h
//  
//
//  Created by mike on 16/3/27.
//
//

#import "MIkeItem.h"
#import <UIKit/UIKit.h>


@interface MIkeArrowItem : MIkeItem
@property(nonatomic,assign)Class arrowClass;

/**
 *  <#Description#>
 *
 *  @param icon       <#icon description#>
 *  @param name       <#name description#>
 *  @param arrowClass <#arrowClass description#>
 *
 *  @return <#return value description#>
 */
+(instancetype)iconWithIcon:(NSString *)icon Name:(NSString *)name arrowClass:(Class )arrowClass;
@end
