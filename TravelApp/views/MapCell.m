//
//  MapCell.m
//  TravelApp
//
//  Created by qianfeng on 15/12/10.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "MapCell.h"
#import "MapImageView.h"
@implementation MapCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        // 添加地图背景
        UIImageView * mapBackgroundImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"map@2x.png"]];
        mapBackgroundImage.frame = CGRectMake(0, 0, Screen_Width, Screen_Width * 0.6);
        [self.contentView addSubview:mapBackgroundImage];
        
        // 创建气泡标签 @“热门”,@"亚洲",@"欧洲",@"北美洲",@"南美洲",@"大洋洲",@"非洲",@"南极洲"
        CGFloat mapWidth = mapBackgroundImage.frame.size.width;
        CGFloat mapHeight = mapBackgroundImage.frame.size.height;
        NSArray * nameArr = @[@"热门",@"亚洲",@"欧洲",@"北美洲",@"南美洲",@"大洋洲",@"非洲",@"南极洲"];
        
        NSValue * bmz = [NSValue valueWithCGRect:CGRectMake(mapWidth * 0.13, mapHeight * 0.1, mapWidth * 0.12,mapWidth * 0.12)];
        NSValue * oz = [NSValue valueWithCGRect:CGRectMake(mapWidth * 0.59, mapHeight * 0.07, mapWidth * 0.12,mapWidth * 0.12)];
        NSValue * yz = [NSValue valueWithCGRect:CGRectMake(mapWidth * 0.73, mapHeight * 0.1, mapWidth * 0.12,mapWidth * 0.12)];
        NSValue * nmz = [NSValue valueWithCGRect:CGRectMake(mapWidth * 0.25, mapHeight * 0.45, mapWidth * 0.12,mapWidth * 0.12)];
        NSValue * fz = [NSValue valueWithCGRect:CGRectMake(mapWidth * 0.5, mapHeight * 0.4, mapWidth * 0.12,mapWidth * 0.12)];
        NSValue * dyz = [NSValue valueWithCGRect:CGRectMake(mapWidth * 0.81, mapHeight * 0.47, mapWidth * 0.12,mapWidth * 0.12)];
        NSValue * njz = [NSValue valueWithCGRect:CGRectMake(mapWidth * 0.6, mapHeight * 0.75, mapWidth * 0.12,mapWidth * 0.12)];
        NSArray * positionArr = @[yz,yz,oz,bmz,nmz,dyz,fz,njz]; // 标签坐标
        for(int i = 1; i < 8; i ++)
        {
            UITapGestureRecognizer * imageTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
            MapImageView * mapImage = [[MapImageView alloc] initWithFrame:[positionArr[i] CGRectValue]];
            mapImage.areaName.text = nameArr[i];
            mapImage.userInteractionEnabled = YES;
            mapImage.areaName.font = [UIFont boldSystemFontOfSize:10];
            [mapImage addGestureRecognizer:imageTap];
            mapImage.tag = 10 + i;
            [self.contentView addSubview:mapImage];
            if(i == 1) // 默认显示亚洲，改变字体颜色
            {
                mapImage.areaName.textColor = [UIColor blackColor];
            }
        }
    }
    return self;
}
// 点击手势响应动作
- (void)tapAction:(UITapGestureRecognizer *)tap
{
    // 获取被点击试图
    MapImageView * currentTapImage = (MapImageView *)tap.view;
    // 遍历小图标，改变标题颜色
    for(int i = 0; i < 8; i ++)
    {
        MapImageView * image = (MapImageView *)[self viewWithTag:10 + i];
        if(currentTapImage == image)
        {
            image.areaName.textColor = [UIColor blackColor];
            image.areaName.font = [UIFont boldSystemFontOfSize:11];
            if([self.delegate respondsToSelector:@selector(pressPosition:)])
            {
                [self.delegate pressPosition:i];
            }
        }
        else
        {
            image.areaName.textColor = RGBR(139, 139, 142, 1);
            image.areaName.font = [UIFont boldSystemFontOfSize:10];
        }
    }
    
    
}


@end
