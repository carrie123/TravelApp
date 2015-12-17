//
//  MapCell.h
//  TravelApp
//
//  Created by qianfeng on 15/12/10.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MapCellDelegate <NSObject>

- (void)pressPosition:(POSITION_NUM)position;

@end

@interface MapCell : UITableViewCell

@property (nonatomic,weak) id <MapCellDelegate> delegate;

@end
