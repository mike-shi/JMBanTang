//
//  JMPersonCenterHeaderImageView.h
//  JMHalfSugar
//
//  Created by Jimmy on 16/6/30.
//  Copyright © 2016年 HDCircles. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JMPersonCenterHeaderImageView : UIView
{
   @public void (^clickedImage)(void);
}
- (void)changePersonInfo:(UIImage *)image Name:(NSString *)name Desc:(NSString *)desc;
@end
