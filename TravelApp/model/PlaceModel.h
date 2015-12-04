//
//  PlaceModel.h
//  TravelApp
//
//  Created by qianfeng on 15/11/30.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PlaceModel : NSObject
/**内容网页地址*/
@property (nonatomic,copy) NSString * url;
/**图片地址*/
@property (nonatomic,copy) NSString * photo;
/**标题*/
@property (nonatomic,copy) NSString * title;
/**目的地个数*/
@property (nonatomic,copy) NSString * label;

// 初始化方法
- (instancetype)initWithDic:(NSDictionary *)dic;
// 工厂方法
+ (PlaceModel *)placeModelWithDict:(NSDictionary *)dic;

@end
