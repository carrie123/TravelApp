//
//  PackageCollectionViewCell.h
//  TravelApp
//
//  Created by qianfeng on 15/12/17.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PackageModel;

@interface PackageCollectionViewCell : UICollectionViewCell

/**
 *  锦囊图片
 */
@property (nonatomic, strong) UIImageView * photo;

// 刷新cell
- (void)updateCellWithApplication:(PackageModel *)model;

@end
