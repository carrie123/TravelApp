//
//  CountryCell.h
//  TravelApp
//
//  Created by qianfeng on 15/12/10.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CountryCell : UITableViewCell<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
/**接收传递过来的 热门国家数据*/
@property (nonatomic,strong) NSMutableArray * cellHotcountrylistArr;

// 刷新cell
- (void)updateCellWithApplication:(NSArray *)modelArr;


@end
