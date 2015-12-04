//
//  CountryDetailModel.h
//  TravelApp
//
//  Created by qianfeng on 15/11/30.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CountryDetailModel : NSObject
/**国家中文名字*/
@property (nonatomic, copy) NSString * chinesename;
/**国家英文名字*/
@property (nonatomic, copy) NSString * englishname;
/**热门城市*/
@property (nonatomic, strong) NSMutableArray * hot_city;
/**折扣信息 (有数据，没有展示)*/
//@property (nonatomic, strong) NSMutableArray * discount_new;
/**游记*/
@property (nonatomic, strong) NSMutableArray * trip_new;
/**Top照片*/
@property (nonatomic, strong) NSMutableArray * photos;
/**城市ID*/
@property (nonatomic, copy) NSString * city_id;

// 初始化方法
- (instancetype)initWithDic:(NSDictionary *)dic;

// 工厂方法
+ (CountryDetailModel *)countryDetailModelWithDict:(NSDictionary *)dic;

@end
