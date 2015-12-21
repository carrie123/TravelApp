//
//  AdjustLableCell.h
//  TravelApp
//
//  Created by qianfeng on 15/12/17.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AdjustLableCell : UITableViewCell
/**
 *  文字
 */
@property (nonatomic, strong) UILabel * myLabel;

// 根据文本内容重新计算cell高度
-(void)setMyLabelText:(NSString *)text;
@end
