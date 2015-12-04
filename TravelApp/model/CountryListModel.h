//
//  CountryListModel.h
//  TravelApp
//
//  Created by qianfeng on 15/11/30.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CountryListModel : NSObject
/**国家名字*/
@property (nonatomic, copy) NSString *catename;
/**未知属性*/
@property (nonatomic, copy) NSString * flag;
/**城市ID（详细页请求参数）*/
@property (nonatomic, copy) NSString * pid;

// 初始化方法
- (instancetype)initWithDic:(NSDictionary *)dic;

// 工厂方法
+ (CountryListModel *)countryListModelWithDict:(NSDictionary *)dic;
@end
