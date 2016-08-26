//
//  JMRelationView.m
//  JMHalfSugar
//
//  Created by mike on 16/8/25.
//  Copyright © 2016年 HDCircles. All rights reserved.
//

#import "JMRelationView.h"
#import "MIkeFlow.h"
#import "JMSearchRelationModel.h"
#import "JMSearchTopicCell.h"
//#import "JMSearchRelationModel.h"

@interface JMRelationView ()<UICollectionViewDataSource,UICollectionViewDelegate>
@property(nonatomic,strong)UICollectionView *collectionView;
@end

@implementation JMRelationView
static NSString *ID = @"cell";
-(id)initWithFrame:(CGRect)frame{

    if (self = [super initWithFrame:frame]) {
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, KScreenWith, 20)];
        [self addSubview:label];
      
        label.text = @"相关清单";
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor blackColor];
        label.font = [UIFont systemFontOfSize:13];
        
        
        MIkeFlow *flow = [[MIkeFlow alloc]init];
        
        UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 20, KScreenWith, 100) collectionViewLayout:flow];
        [self addSubview:collectionView];
        _collectionView = collectionView;
        collectionView.backgroundColor = [UIColor whiteColor];
        collectionView.delegate = self;
        collectionView.dataSource = self;
        
//        _tableView.tableFooterView = collectionView;
        
        [self.collectionView reloadData];
   
        UINib *xib = [UINib nibWithNibName:@"JMSearchTopicCell" bundle:nil];
        
        [self.collectionView registerNib:xib forCellWithReuseIdentifier:ID];
        
    }
    
    return self;
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return _modelArr.count;
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    JMSearchTopicCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    
    //    cell.backgroundColor = HWRandomColor;
    cell.model = self.modelArr[indexPath.row];
    
    return cell;
    
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

    JMSearchRelationModel *model = self.modelArr[indexPath.row];
    
    if ([self.delegate respondsToSelector:@selector(JMRelationViewDidClick:proID:Image:)]) {
        [self.delegate JMRelationViewDidClick:self proID:model.topicID Image:model.pic];
    }

}
@end
