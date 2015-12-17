//
//  PackageDB.h
//  TravalApp
//
//  Created by qianfeng on 15/12/18.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
@class packageDetailModel;

@interface PackageDB : NSManagedObject
/**
 *  锦囊名字（name+锦囊）
 */
@property (nonatomic, retain) NSString * name;
/**
 *  大洲名
 */
@property (nonatomic, retain) NSString * category_title;
/**
 *  国家中文名
 */
@property (nonatomic, retain) NSString * country_name_cn;
/**
 *  封面图片Url http://static.qyer.com/upload/Guide_Info/17/e6/43 /670_420.jpg? 1443003741
 */
@property (nonatomic, retain) NSString * cover;
/**
 *  封面图片更新时间
 */
@property (nonatomic, retain) NSString * cover_updatetime;
/**
 *  zip地址(转化文件路径用)
 */
@property (nonatomic, retain) NSString * file;

/**
 *  初始化模型
 */
- (void)updateWithPackageDetailModel:(packageDetailModel *)model;

@end
