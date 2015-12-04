//
//  CityDetailModel.h
//  TravelApp
//
//  Created by qianfeng on 15/11/30.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CityDetailModel : NSObject
/**国家中文名字*/
@property (nonatomic, copy) NSString * chinesename;
/**国家英文名字*/
@property (nonatomic, copy) NSString * englishname;
/**游记*/
@property (nonatomic, strong) NSMutableArray * trip_new;
/**Top照片*/
@property (nonatomic, strong) NSMutableArray * photos;
/**国家ID*/
@property (nonatomic, copy) NSString * country_id;
/**城市ID*/
@property (nonatomic, copy) NSString * city_id;

// 初始化方法
- (instancetype)initWithDic:(NSDictionary *)dic;

// 工厂方法
+ (CityDetailModel *)cityDetailModelWithDict:(NSDictionary *)dic;


@end
