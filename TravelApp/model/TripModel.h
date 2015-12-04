//
//  TripModel.h
//  TravelApp
//
//  Created by qianfeng on 15/11/30.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TripModel : NSObject
/**图片地址*/
@property (nonatomic,copy) NSString * photo;
/**图片地址*/
@property (nonatomic,copy) NSString * title;
/**游记网页*/
@property (nonatomic,copy) NSString * view_url;
/**作者名字*/
@property (nonatomic,copy) NSString * username;
/**浏览次数*/
@property (nonatomic,copy) NSString * views;
/**回帖个数*/
@property (nonatomic,copy) NSString * replys;

// 初始化方法
- (instancetype)initWithDic:(NSDictionary *)dic;

// 工厂方法
+ (TripModel *)tripModelWithDict:(NSDictionary *)dic;

@end
