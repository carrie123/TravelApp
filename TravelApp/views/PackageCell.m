//
//  PackageCell.m
//  TravelApp
//
//  Created by qianfeng on 15/12/17.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "PackageCell.h"
#import "PackageModel.h"
#import "PackageCollectionViewCell.h"


@interface PackageCell ()
{
    UICollectionView * collectionView;
}
@end

@implementation PackageCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        // 设置cell的布局
        UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc]init];
        [flowLayout setItemSize:CGSizeMake(PackageCollectionCell_WIDTH, PackageCollectionCell_HEIGHT)]; // 设置cell的尺寸
        [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical]; // 设置其布局方向
        flowLayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10); // 设置其边界
        
        collectionView = [[UICollectionView alloc] initWithFrame:
                          CGRectMake(0,
                                     0,
                                     Screen_Width*0.8,
                                     PackageCollectionCell_HEIGHT)
                                            collectionViewLayout:flowLayout];
        collectionView.backgroundColor = [UIColor whiteColor];
        collectionView.autoresizesSubviews = NO;
        collectionView.dataSource = self;
        collectionView.delegate = self;
        [self.contentView addSubview:collectionView];
        
        // 注册cell
        [collectionView registerClass:[PackageCollectionViewCell class] forCellWithReuseIdentifier:@"PackageCollectionCell"];
        
    }
    return self;
}

// 刷新cell
- (void)updateCellWithApplication:(NSArray *)modelArr
{
    _modelArr = [NSArray arrayWithArray:modelArr];
    
    if(_modelArr.count%2 == 0)       // 双数个cell
    {
        collectionView.frame = CGRectMake(0,
                                          0,
                                          Screen_Width*0.8,
                                          PackageCollectionView_HEIGHTWith_DualCount(_modelArr.count));
    }
    else                                // 单数个cell
    {
        collectionView.frame = CGRectMake(0,0,Screen_Width*0.8,
        PackageCollectionView_HEIGHTWith_SingularCount(_modelArr.count));
    }
    
    
    [collectionView reloadData];
}
#pragma mark --- <UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSInteger num =  (_modelArr)?_modelArr.count:0;
    return num;
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
// 设置cell内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    PackageCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PackageCollectionCell" forIndexPath:indexPath];
    if(_modelArr)
    {
        [cell updateCellWithApplication:_modelArr[indexPath.row]];
    }
    return cell;
}

// 实现选中cell时的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    PackageModel * model = _modelArr[indexPath.row];
    
    // 给控制器发送通知，跳转锦囊详情页面
    [[NSNotificationCenter defaultCenter] postNotificationName:@"pushToPackDetailController" object:@[model.guide_id,model.file]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
