//
//  CountryCell.m
//  TravelApp
//
//  Created by qianfeng on 15/12/10.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "CountryCell.h"
#import "HotCountryListModel.h"
#import "CountryCollectionCell.h"

@interface CountryCell ()
{
    UICollectionView * _collectionView;
}
@end

@implementation CountryCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        
        // 计算cell尺寸
        CGFloat cellHeight = CollectionCell_WIDTH * 1.4;
        // 设置cell的布局
        UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc]init];
        [flowLayout setItemSize:CGSizeMake(CollectionCell_WIDTH, cellHeight)]; // 设置cell的尺寸
        [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical]; // 设置其布局方向
        flowLayout.sectionInset = UIEdgeInsetsMake(15, 15, 15, 15); // 设置其边界
        
        _collectionView = [[UICollectionView alloc] initWithFrame:
                          CGRectMake(0,0,Screen_Width,0) collectionViewLayout:flowLayout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.autoresizesSubviews = NO;
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        [self.contentView addSubview:_collectionView];
        
        // 注册cell
        [_collectionView registerClass:[CountryCollectionCell class] forCellWithReuseIdentifier:@"CountryCollectionCell"];
        
    }
    return self;
}

// 刷新cell
- (void)updateCellWithApplication:(NSArray *)modelArr
{
    _cellHotcountrylistArr = [NSMutableArray arrayWithArray:modelArr];
    if(_cellHotcountrylistArr.count % 2 == 0)
    {
        _collectionView.frame = CGRectMake(0,0,Screen_Width,
    CollectionView_HEIGHTWith_DualCount(_cellHotcountrylistArr.count));
    }
    else
    {
        _collectionView.frame = CGRectMake(0,0,Screen_Width,
                                          CollectionView_HEIGHTWith_SingularCount(_cellHotcountrylistArr.count));
    }
    [_collectionView reloadData];
}
#pragma mark --- <UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSInteger num =  (_cellHotcountrylistArr)?_cellHotcountrylistArr.count:0;
    return num;
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
// 设置cell内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CountryCollectionCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CountryCollectionCell" forIndexPath:indexPath];
    if(_cellHotcountrylistArr)
    {
        [cell updateCellWithApplication:_cellHotcountrylistArr[indexPath.row]];
    }
    return cell;
}
// 实现选中cell时的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    HotCountryListModel * model = _cellHotcountrylistArr[indexPath.row];
    NSString * hotcountryID = model.pid;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"pushToCountryDetailController" object:hotcountryID];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
