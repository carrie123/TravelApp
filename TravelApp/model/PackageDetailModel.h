//
//  PackageDetailModel.h
//  TravelApp
//
//  Created by qianfeng on 15/11/30.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PackageDetailModel : NSObject
//@property (nonatomic,copy)NSString *id;
/**大洲编号*/
@property (nonatomic,copy)NSString * category_id;
/**大洲名*/
@property (nonatomic,copy)NSString * category_title;
/**国家编号*/
@property (nonatomic,copy)NSString * country_id;
/**国家中文名*/
@property (nonatomic,copy)NSString * country_name_cn;
/**锦囊名字（name+锦囊）*/
@property (nonatomic,copy)NSString * name;
/**封面图片Url http://static.qyer.com/upload/Guide_Info/17/e6/43 /670_420.jpg? 1443003741*/
@property (nonatomic,copy)NSString * cover;
/**封面图片更新时间*/
@property (nonatomic,copy)NSString * cover_updatetime;
/**锦囊下载次数*/
@property (nonatomic,copy)NSNumber * download;
/**锦囊文件（PDF格式）*/
@property (nonatomic,copy)NSString * file;
/**作者名字*/
@property (nonatomic,copy)NSString * author_name;
/**作者头像图片Url*/
@property (nonatomic,copy)NSString * author_icon;
/**作者ID*/
@property (nonatomic,copy)NSString * author_id;
/**作者简介*/
@property (nonatomic,copy)NSString * author_intro;
/**锦囊简介*/
@property (nonatomic,copy)NSString * briefinfo;
/**锦囊文件大小*/
@property (nonatomic,copy)NSNumber * size;
/**下载锦囊模型*/
@property (nonatomic,copy)NSDictionary * mobile_guide;

// 初始化方法
- (instancetype)initWithDic:(NSDictionary *)dic;

// 工厂方法
+ (PackageDetailModel *)packageDetailModelWithDict:(NSDictionary *)dic;

@end
