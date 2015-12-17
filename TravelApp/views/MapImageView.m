//
//  MapImageView.m
//  TravelApp
//
//  Created by qianfeng on 15/12/10.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "MapImageView.h"

@implementation MapImageView

- (instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        // 气泡图片
        UIImageView * bubbleImageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height * 7/10)];
        bubbleImageV.image = [UIImage imageNamed:@"ic_map_bubble@2x.png"];
        [self addSubview:bubbleImageV];
        
        // 气泡内的文字
        _areaName = [[UILabel alloc] initWithFrame:CGRectMake(1, 2, bubbleImageV.frame.size.width - 1 * 2, bubbleImageV.frame.size.height - 1*2 - 5)];
        _areaName.font = [UIFont systemFontOfSize:11];
        _areaName.textAlignment = NSTextAlignmentCenter;
        _areaName.textColor = RGBR(139, 139, 142, 1);
        [bubbleImageV addSubview:_areaName];
        
        // 原点图标
        CGFloat poiHeight = frame.size.height - frame.size.height * 8/10;
        UIImageView * poiImageV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"poi_point@2x.png"]];
        poiImageV.frame = CGRectMake(bubbleImageV.center.x - poiHeight/2, frame.size.height * 8/10, poiHeight, poiHeight);
        [self addSubview:poiImageV];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
