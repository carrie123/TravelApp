//
//  CatenateModel.h
//  TravelApp
//
//  Created by qianfeng on 15/11/30.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CatenateModel : NSObject
/**大洲中文名字*/
@property (nonatomic, copy) NSString *catename;
/**大洲英文名字*/
@property (nonatomic, copy) NSString *catename_en;
/**其它国家*/
@property (nonatomic, strong) NSMutableArray * countrylist;
/**热门国家*/
@property (nonatomic, strong) NSMutableArray * hotcountrylist;

// 初始化方法
- (instancetype)initWithDic:(NSDictionary *)dic;

// 工厂方法
+ (CatenateModel *)catenateModelWithDict:(NSDictionary *)dic;

@end
