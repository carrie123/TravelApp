//
//  CountryCollectionCell.h
//  TravelApp
//
//  Created by qianfeng on 15/12/10.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HotCountryListModel;
@interface CountryCollectionCell : UICollectionViewCell
/**国家图片*/
@property (nonatomic,strong) UIImageView * imageV;
/**国家包含城市数量*/
@property (nonatomic,strong) UILabel * cityCount;
/**国家中文名字*/
@property (nonatomic,strong) UILabel * countryName;
/**国家英文名字*/
@property (nonatomic,strong) UILabel * countryName_en;

// 刷新cell
- (void)updateCellWithApplication:(HotCountryListModel *)model;


@end
