//
//  FileModel.h
//  TravelApp
//
//  Created by qianfeng on 15/11/30.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FileModel : NSObject
/**锦囊下载地址*/
@property (nonatomic,copy)NSString * file;
/**锦囊文件大小*/
@property (nonatomic,copy)NSNumber * size;
/**已下载大小*/
@property (nonatomic,copy)NSNumber * downloadSize;
/**是否完成下载*/
@property (nonatomic,assign)BOOL isFinished;

// 初始化方法
- (instancetype)initWithDic:(NSDictionary *)dic;

// 工厂方法
+ (FileModel *)fileModelWithDict:(NSDictionary *)dic;

/**获取Zip文件下载后本地地址*/
- (NSString *)localPath;
@end
