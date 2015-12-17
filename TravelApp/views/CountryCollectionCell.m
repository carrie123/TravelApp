//
//  CountryCollectionCell.m
//  TravelApp
//
//  Created by qianfeng on 15/12/10.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "CountryCollectionCell.h"
#import "HotCountryListModel.h"

@implementation CountryCollectionCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        // 图片
        _imageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        _imageV.image = [UIImage imageNamed:@"default_book_cover@2x.png"];
        _imageV.layer.cornerRadius = 8;
        [self.contentView addSubview:_imageV];
        
        // 右上蒙版
        UIImageView * imageM = [[UIImageView alloc] initWithFrame:CGRectMake(frame.size.width - (10 + (frame.size.width * 0.35)), 10, frame.size.width * 0.35, frame.size.width * 0.3)];
        imageM.backgroundColor = RGBR(0, 0, 0, 0.3);
        imageM.layer.cornerRadius = 8;
        [self.contentView addSubview:imageM];
        
        // 城市数量
        _cityCount = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, imageM.frame.size.width, imageM.frame.size.height * 3/5)];
        _cityCount.textAlignment = NSTextAlignmentCenter;
        _cityCount.font = [UIFont systemFontOfSize:21];
        _cityCount.textColor = [UIColor whiteColor];
        [imageM addSubview:_cityCount];
        
        // 城市文字
        UILabel * city = [[UILabel alloc] initWithFrame:CGRectMake(0, _cityCount.center.y + _cityCount.frame.size.height/2 - 3, imageM.frame.size.width, imageM.frame.size.height * 2/5)];
        city.textAlignment = NSTextAlignmentCenter;
        city.font = [UIFont systemFontOfSize:15];
        city.textColor = [UIColor whiteColor];
        city.text = @"城市";
        [imageM addSubview:city];
        
        // 城市名字CH
        _countryName = [[UILabel alloc] initWithFrame:CGRectMake(10, frame.size.height * 0.77, frame.size.width*0.6, frame.size.height * 0.12)];
        _countryName.font = [UIFont systemFontOfSize:18];
        _countryName.textColor = [UIColor whiteColor];
        [self.contentView addSubview:_countryName];
        
        // 城市名字EN
        _countryName_en = [[UILabel alloc] initWithFrame:CGRectMake(10, frame.size.height * 0.89, frame.size.width*0.6, frame.size.height * 0.1)];
        _countryName_en.font = [UIFont systemFontOfSize:13];
        _countryName_en.textColor = [UIColor whiteColor];
        [self.contentView addSubview:_countryName_en];
    }
    return self;
}
// 刷新cell
- (void)updateCellWithApplication:(HotCountryListModel *)model
{
    [_imageV setImageWithURL:[NSURL URLWithString:model.photo]];
    _cityCount.text = model.count;
    _countryName.text = model.catename;
    _countryName_en.text = model.catename_en;
}


@end
