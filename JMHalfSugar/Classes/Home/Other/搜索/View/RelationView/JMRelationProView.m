//
//  JMRelationProView.m
//  JMHalfSugar
//
//  Created by mike on 16/8/25.
//  Copyright © 2016年 HDCircles. All rights reserved.
//

#import "JMRelationProView.h"
#import "JMRelationProCell.h"
#import "JMSearchSingleGoodsModel.h"

@interface JMRelationProView()<UICollectionViewDataSource,UICollectionViewDelegate>
@property(nonatomic,strong)UICollectionView *collectionView;

@end
@implementation JMRelationProView
static NSString *ID = @"Procell";
-(id)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, KScreenWith, 20)];
        [self addSubview:label];
        
        label.text = @"相关推荐";
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor blackColor];
        label.font = [UIFont systemFontOfSize:13];

        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
        flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        flowLayout.minimumInteritemSpacing = 10.0f;
        flowLayout.minimumLineSpacing = 10.0f;
        flowLayout.itemSize = CGSizeMake(154, 200);
        flowLayout.sectionInset = UIEdgeInsetsMake(10, 20, 10, 10);

//        CGFloat collH = (JMDeviceWidth/2+60 )*self.modelArr.count/2 ;
//        NSLog(@"%f",collH);
        
        
        UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 20, KScreenWith, 1030) collectionViewLayout:flowLayout];
        [self addSubview:collectionView];
        _collectionView = collectionView;
        collectionView.backgroundColor = [UIColor whiteColor];
        collectionView.delegate = self;
        collectionView.dataSource = self;
        
        //        _tableView.tableFooterView = collectionView;
        
        [self.collectionView reloadData];
        
        UINib *xib = [UINib nibWithNibName:@"JMRelationProCell" bundle:nil];
        
        [self.collectionView registerNib:xib forCellWithReuseIdentifier:ID];


        _collectionView.scrollEnabled = NO;
    }
    
    
    return self;
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return _modelArr.count;
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    JMRelationProCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    
//        cell.backgroundColor = HWRandomColor;
    cell.goodsModel = self.modelArr[indexPath.row];
    
    return cell;
    
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

    JMSearchSingleGoodsModel *model = self.modelArr[indexPath.row];
    
    NSString *proID = model.productID;
    
    if ([self.delegate respondsToSelector:@selector(JMRelationProViewDidClick:proID:)]) {
        
        [self.delegate JMRelationProViewDidClick:self proID:proID];
    }

}

@end
