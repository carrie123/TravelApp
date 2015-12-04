//
//  PackageModel.h
//  TravelApp
//
//  Created by qianfeng on 15/11/30.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PackageModel : NSObject
/**锦囊ID*/
@property (nonatomic,copy)NSString * guide_id;
/**国家内景点名字（中文）*/
@property (nonatomic,copy)NSString * guide_cnname;
/**国家内景点名字（英文）*/
@property (nonatomic,copy)NSString * guide_enname;
/**所属大洲ID*/
@property (nonatomic,copy)NSString * category_id;
/**所属大洲名字*/
@property (nonatomic,copy)NSString * category_title;
/**所属国家ID*/
@property (nonatomic,copy)NSString * country_id;
/**所属国家名字（中文）*/
@property (nonatomic,copy)NSString * country_name_cn;
/**所属国家名字（英文）*/
@property (nonatomic,copy)NSString * country_name_en;
/**图片Url（需拼接） [NSString stringWithFormat:@"%@/260_390.jpg?%@",model.cover,model.cover_updatetime]*/
@property (nonatomic,copy)NSString * cover;
/**锦囊封面更新时间（拼接锦囊封面Url用）*/
@property (nonatomic,copy)NSString * cover_updatetime;
/**锦囊下载次数*/
@property (nonatomic,copy)NSNumber * download;
/**锦囊文件大小*/
@property (nonatomic,copy)NSNumber * size;
/**锦囊更新时间*/
@property (nonatomic,copy)NSString * update_time;
/**锦囊文件下载地址（Zip格式）*/
@property (nonatomic,copy)NSString * file;

// 初始化方法
- (instancetype)initWithDic:(NSDictionary *)dic;

// 工厂方法
+ (PackageModel *)packageModelWithDict:(NSDictionary *)dic;


@end
