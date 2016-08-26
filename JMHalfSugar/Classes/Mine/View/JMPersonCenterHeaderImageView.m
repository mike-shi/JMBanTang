//
//  JMPersonCenterHeaderImageView.m
//  JMHalfSugar
//
//  Created by Jimmy on 16/6/30.
//  Copyright © 2016年 HDCircles. All rights reserved.
//

#import "JMPersonCenterHeaderImageView.h"
#import "JMImageOperationCenter.h"
#import "JMDoubleLabel.h"
@interface JMPersonCenterHeaderImageView ()
@property (nonatomic, weak)UIButton *headerButton;
@property (nonatomic, strong)UIImage *avatarImage;
@property (nonatomic, weak)UILabel *nameLabel;
@property (nonatomic, weak)UILabel *bioLable;
@property (nonatomic, weak)JMDoubleLabel *achievementLabel;
@property (nonatomic, weak)JMDoubleLabel *goodSelectedLabel;
@property (nonatomic, weak)JMDoubleLabel *praiseLabel;
@end
@implementation JMPersonCenterHeaderImageView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.avatarImage = [UIImage imageNamed:@"jugg"];
        [self initializedSubviews];
    }
    return self;
}
#pragma mark - initialized subviews
- (void)initializedSubviews
{
    //
//    UIImage *image = [JMImageOperationCenter headerImageOperationWithImage:_avatarImage borderColor:[UIColor whiteColor] andBorderWidth:2.0];
    UIButton *headerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    headerBtn.frame = CGRectMake(JMDeviceWidth/2-40, 50, 80, 80);
    [headerBtn setImage:[UIImage imageNamed:@"jugg"] forState:UIControlStateNormal];
    [headerBtn setImage:[UIImage imageNamed:@"jugg"] forState:UIControlStateHighlighted];
    headerBtn.imageView.layer.cornerRadius = 40.0;
    headerBtn.imageView.layer.masksToBounds = YES;
    
    [headerBtn addTarget:self action:@selector(clickedAvataImage:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:headerBtn];
    _headerButton = headerBtn;
    //
    UILabel *nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_headerButton.frame)+13, JMDeviceWidth, 15)];
    nameLabel.font = [UIFont systemFontOfSize:15 weight:4];
    nameLabel.textColor = [UIColor whiteColor];
    nameLabel.text = @"主宰";
    nameLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:nameLabel];
    self.nameLabel = nameLabel;
    //
    UILabel *bioLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_nameLabel.frame)+13, JMDeviceWidth, 15)];
    bioLabel.font = [UIFont systemFontOfSize:13 weight:3];
    bioLabel.textColor = [UIColor whiteColor];
    bioLabel.text = @"我的剑更快！";
    bioLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:bioLabel];
    self.bioLable = bioLabel;
    
    //
//    CGFloat margin = (JMDeviceWidth-3*50-64)/2;
//    //achievement
//    JMDoubleLabel *achLabel = [[JMDoubleLabel alloc]initWithFrame:CGRectMake(32, CGRectGetMaxY(self.bioLable.frame)+15, 50, 45) topTitle:@"99" andBottomTitle:@"成就"];
//    [self addSubview:achLabel];
//    self.achievementLabel = achLabel;
//    //good selected
//    JMDoubleLabel *gselectedLabel = [[JMDoubleLabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_achievementLabel.frame)+margin, CGRectGetMaxY(self.bioLable.frame)+15, 50, 45) topTitle:@"998" andBottomTitle:@"上精选"];
//    [self addSubview:gselectedLabel];
//    self.goodSelectedLabel = gselectedLabel;
//    //praise
//    JMDoubleLabel *praiseLabel = [[JMDoubleLabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_goodSelectedLabel.frame)+margin, CGRectGetMaxY(self.bioLable.frame)+15, 50, 45) topTitle:@"1990" andBottomTitle:@"打賞"];
//    [self addSubview:praiseLabel];
//    self.praiseLabel = praiseLabel;
}
#pragma mark - event
- (void)clickedAvataImage:(UIButton *)btn
{
//    NSLog(@"avatar");
    clickedImage();
}
- (void)changePersonInfo:(UIImage *)image Name:(NSString *)name Desc:(NSString *)desc
{
    self.avatarImage = image;
    [self.headerButton setImage:self.avatarImage forState:UIControlStateNormal];
    [self.headerButton setImage:self.avatarImage forState:UIControlStateHighlighted];
    
    self.nameLabel.text = name;
    
    self.bioLable.text = desc;
    
    
}
@end
