//
//  CatenateModel.m
//  TravelApp
//
//  Created by qianfeng on 15/11/30.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "CatenateModel.h"
#import "CountryListModel.h"
#import "HotCountryListModel.h"

@implementation CatenateModel
// 为与关键字重复的成员变量赋值
- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
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
        _catename = dic[@"catename"];
        
        _catename_en = dic[@"catename_en"];
        
        // 初始化国家列表
        NSArray * countrylist_Arr = dic[@"countrylist"];
        _countrylist = [NSMutableArray array]; // 创建可变数组，储存数据模型
        // 转模型
        [countrylist_Arr enumerateObjectsUsingBlock:^(NSDictionary * dic, NSUInteger idx, BOOL *stop) {
            CountryListModel * model = [CountryListModel countryListModelWithDict:dic]; // 创建数据模型
            [_countrylist addObject:model]; // 将数据模型添加到数组中
        }];
        
        // 初始化热门国家
        NSArray * hotcountrylist_Arr = dic[@"hotcountrylist"];
        _hotcountrylist = [NSMutableArray array]; // 创建可变数组，储存数据模型
        // 转模型
        [hotcountrylist_Arr enumerateObjectsUsingBlock:^(NSDictionary * dic, NSUInteger idx, BOOL *stop) {
            HotCountryListModel * model = [HotCountryListModel hotCountryListModelWithDict:dic]; // 创建数据模型
            [_hotcountrylist addObject:model]; // 将数据模型添加到数组中
        }];
    }
    return self;
}

// 工厂方法
+ (CatenateModel *)catenateModelWithDict:(NSDictionary *)dic
{
    CatenateModel * model = [[self alloc] initWithDic:dic];
    return  model;
}

@end
