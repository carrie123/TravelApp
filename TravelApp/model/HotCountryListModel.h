//
//  HotCountryListModel.h
//  TravelApp
//
//  Created by qianfeng on 15/11/30.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HotCountryListModel : NSObject
/**国家中文名字*/
@property (nonatomic, copy) NSString *catename;
/**国家英文名字*/
@property (nonatomic, copy) NSString * catename_en;
/**所含城市数量*/
@property (nonatomic, copy) NSString * count;
/**未知属性*/
@property (nonatomic, copy) NSString * flag;
/**未知属性*/
@property (nonatomic, copy) NSString * label;
/**图片Url*/
@property (nonatomic, copy) NSString * photo;
/**城市ID（详细页请求参数）*/
@property (nonatomic, copy) NSString * pid;

// 初始化方法
- (instancetype)initWithDic:(NSDictionary *)dic;

// 工厂方法
+ (HotCountryListModel *)hotCountryListModelWithDict:(NSDictionary *)dic;
@end
