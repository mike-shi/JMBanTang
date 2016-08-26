//
//  MIkeItem.h
//  
//
//  Created by mike on 16/3/26.
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void(^MikeITemOption)();
 
@interface MIkeItem : NSObject
@property(nonatomic,copy)NSString *name;
@property(nonatomic,copy)NSString *icon;

@property(nonatomic,strong)MikeITemOption option;

+(instancetype)iconWithIcon:(NSString *)icon Name:(NSString *)name;
@end
