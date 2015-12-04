//
//  NextStationCell.h
//  TravelApp
//
//  Created by qianfeng on 15/11/30.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol NextStationCellDelegate <NSObject>

- (void)pressAdvURL:(NSString *)advURL;

@end

@interface NextStationCell : UITableViewCell

@property (nonatomic,assign) id <NextStationCellDelegate> myDelegate;

// 刷新cell
- (void)updateCellWithApplication:(NSArray *)modelArr;

@end
