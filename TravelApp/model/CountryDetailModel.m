//
//  CountryDetailModel.m
//  TravelApp
//
//  Created by qianfeng on 15/11/30.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "CountryDetailModel.h"
#import "HotCityModel.h"
#import "TripNewModel.h"

@implementation CountryDetailModel
// 为与关键字重复的成员变量赋值
- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if([key isEqualToString:@"id"])
    {
        _city_id = value;
    }
    if([key isEqualToString:@"new_trip"])
    {
        _trip_new = value;
    }
}

// 防止外界访问不存在的属性时崩溃
- (id)valueForUndefinedKey:(NSString *)key
{
    return nil; // 属性不存在时返回nil
}

// 初始化方法
- (instancetype)initWithDic:(NSDictionary *)dic
{
    if(self = [super init])
    {
        _chinesename = dic[@"chinesename"];
        _englishname = dic[@"englishname"];
        _photos = dic[@"photos"];
        _city_id = dic[@"id"];
        
        // 初始化 热门城市
        NSArray * hot_city_Arr = dic[@"hot_city"];
        _hot_city = [NSMutableArray array]; // 创建可变数组，储存数据模型
        // 转模型
        [hot_city_Arr enumerateObjectsUsingBlock:^(NSDictionary * dic, NSUInteger idx, BOOL *stop) {
            HotCityModel * model = [HotCityModel hotCityModelWithDict:dic]; // 创建数据模型
            [_hot_city addObject:model]; // 将数据模型添加到数组中
        }];
        
        // 初始化 游记
        NSArray * tripNew_Arr = dic[@"new_trip"];
        _trip_new = [NSMutableArray array]; // 创建可变数组，储存数据模型
        // 转模型
        [tripNew_Arr enumerateObjectsUsingBlock:^(NSDictionary * dic, NSUInteger idx, BOOL *stop) {
            TripNewModel * model = [TripNewModel tripNewModelWithDict:dic]; // 创建数据模型
            [_trip_new addObject:model]; // 将数据模型添加到数组中
        }];
    }
    return self;
}

// 工厂方法
+ (CountryDetailModel *)countryDetailModelWithDict:(NSDictionary *)dic
{
    CountryDetailModel * model = [[self alloc] initWithDic:dic];
    return  model;
}


@end
