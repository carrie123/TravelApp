//
//  HotCityModel.h
//  TravelApp
//
//  Created by qianfeng on 15/11/30.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HotCityModel : NSObject
/**城市ID*/
@property (nonatomic, copy) NSString * city_ID;
/**城市名字*/
@property (nonatomic, copy) NSString * name;
/**城市图片*/
@property (nonatomic, copy) NSString * photo;

// 初始化方法
- (instancetype)initWithDic:(NSDictionary *)dic;

// 工厂方法
+ (HotCityModel *)hotCityModelWithDict:(NSDictionary *)dic;

@end
