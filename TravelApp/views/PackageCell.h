//
//  PackageCell.h
//  TravelApp
//
//  Created by qianfeng on 15/12/17.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PackageCell : UITableViewCell<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
/**
 *  接收传递过来的 城市 数据
 */
@property (nonatomic,strong) NSArray * modelArr;

// 刷新cell
- (void)updateCellWithApplication:(NSArray *)modelArr;

@end
