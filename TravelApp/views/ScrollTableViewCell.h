//
//  ScrollTableViewCell.h
//  TravelApp
//
//  Created by qianfeng on 15/11/30.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ScrollTableViewCellDelegate <NSObject>

- (void)pressAdvURL:(NSString *)advURL;

@end

@interface ScrollTableViewCell : UITableViewCell<UIScrollViewDelegate>

@property (nonatomic,assign) id <ScrollTableViewCellDelegate> myDelegate;
@property(nonatomic,strong) UIScrollView * scroll;
@property(nonatomic,strong) UIPageControl * page;
@property(nonatomic,strong) NSMutableArray * advArr; // 保存传递过来的数据

// 刷新cell
- (void)updateCellWithApplication:(NSArray *)modelArr;

@end
