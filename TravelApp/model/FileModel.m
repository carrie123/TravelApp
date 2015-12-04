//
//  FileModel.m
//  TravelApp
//
//  Created by qianfeng on 15/11/30.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "FileModel.h"
#import "NSString+Hashing.h"

@implementation FileModel
// 为与关键字重复的成员变量赋值
- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

// 防止外界访问不存在的属性时崩溃
- (id)valueForUndefinedKey:(NSString *)key
{
    return nil; // 属性不存在时返回nil
}

// 初始化方法
- (instancetype)initWithDic:(NSDictionary *)dic
{
    if(self = [super init])
    {
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}

// 工厂方法
+ (FileModel *)fileModelWithDict:(NSDictionary *)dic
{
    FileModel * model = [[self alloc] initWithDic:dic];
    return  model;
}
/**
 *  获取Zip文件下载后本地地址
 */
-(NSString *)localPath
{
    NSString *path = NSHomeDirectory();
    NSString *fileName = [self.file MD5Hash];
    path = [path stringByAppendingPathComponent:[NSString stringWithFormat:@"Documents/zip/%@",fileName]];
    return path;
}
@end
