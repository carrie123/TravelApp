//
//  IconAndTextCell.h
//  TravelApp
//
//  Created by qianfeng on 15/12/17.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PackageDetailModel;

@interface IconAndTextCell : UITableViewCell
/**
 *  作者头像图片
 */
@property (nonatomic, strong) UIImageView * photo;
/**
 *  作者名字
 */
@property (nonatomic, strong) UILabel  * name;

// 刷新cell
- (void)updateCellWithApplication:(PackageDetailModel *)model;

@end
