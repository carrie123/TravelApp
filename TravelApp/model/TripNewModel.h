//
//  TripNewModel.h
//  TravelApp
//
//  Created by qianfeng on 15/11/30.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TripNewModel : NSObject
/**作者头像图片URL*/
//@property (nonatomic, strong) NSString * avatar;
/**游记封面图片Url*/
@property (nonatomic, copy) NSString * photo;
/**帖子回复人数*/
@property (nonatomic, copy) NSString * replys;
/**帖子浏览次数*/
@property (nonatomic, copy) NSString * views;
/**
 *  标题
 */
@property (nonatomic, copy) NSString * title;
/**
 *  作者名字
 */
@property (nonatomic, copy) NSString * username;
/**
 *  帖子Url
 */
@property (nonatomic, copy) NSString * view_url;

// 初始化方法
- (instancetype)initWithDic:(NSDictionary *)dic;

// 工厂方法
+ (TripNewModel *)tripNewModelWithDict:(NSDictionary *)dic;


@end
