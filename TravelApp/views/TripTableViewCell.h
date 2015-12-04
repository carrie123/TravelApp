//
//  TripTableViewCell.h
//  TravelApp
//
//  Created by qianfeng on 15/11/30.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TripModel.h"

@interface TripTableViewCell : UITableViewCell
/**
 *  图片
 */
@property (nonatomic,strong) UIImageView * photo;
/**
 *  标题
 */
@property (nonatomic,strong) UILabel * title;
/**
 *  游记网页
 */
@property (nonatomic,strong) NSString * view_url;
/**
 *  作者名字
 */
@property (nonatomic,strong) UILabel * username;
/**
 *  浏览次数
 */
@property (nonatomic,strong) UILabel * viewsText;
/**
 *  浏览次数图片
 */
@property (nonatomic,strong) UIImageView * viewsV;
/**
 *  回帖个数
 */
@property (nonatomic,strong) UILabel * replys;
/**
 *  回帖个数图片
 */
@property (nonatomic,strong) UIImageView * replysV;

// 刷新cell
- (void)updateCellWithApplication:(TripModel *)model;


@end
