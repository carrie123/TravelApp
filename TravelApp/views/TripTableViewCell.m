//
//  TripTableViewCell.m
//  TravelApp
//
//  Created by qianfeng on 15/11/30.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "TripTableViewCell.h"
#import "TripModel.h"
#import "TripNewModel.h"

@implementation TripTableViewCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.selectionStyle = UITableViewCellSelectionStyleNone; // 消除选中效果
        
        // 为cell内容添加约束
        CGFloat cellHeight = 80; // 约定好的cell高度
        CGFloat cellWidth = Screen_Width; // 和屏幕等宽
        // imageV
        _photo = [[UIImageView alloc] init];
        _photo.frame = CGRectMake(5, 5, (cellHeight - 5*2)*1.4, cellHeight - 5*2);
        [self.contentView addSubview:_photo];
        
        // 标题
        _title = [[UILabel alloc] initWithFrame:CGRectMake(5 + _photo.frame.size.width + 10, 6, cellWidth - (5 + _photo.frame.size.width + 10) -5, 35)];
        _title.numberOfLines = 0;
        _title.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:_title];
        
        // 作者名字
        _username = [[UILabel alloc] initWithFrame:CGRectMake(5 + _photo.frame.size.width + 10, _title.center.y + _title.frame.size.height/2, cellWidth - (5 + _photo.frame.size.width + 10) -5, 20)];
        _username.font = [UIFont systemFontOfSize:11];
        _username.textColor = RGBR(139, 139, 142, 1.0);
        [self.contentView addSubview:_username];
        
        // 浏览图标
        _viewsV = [[UIImageView alloc] initWithFrame:CGRectMake(5 + _photo.frame.size.width + 10, _username.center.y + _username.frame.size.height/2, 13, 13)];
        _viewsV.image = [UIImage imageNamed:@"home-icon-look-normal@3x.png"];
        [self.contentView addSubview:_viewsV];
        
        // 浏览次数
        _viewsText = [[UILabel alloc] initWithFrame:CGRectMake(_viewsV.center.x + _viewsV.frame.size.width/2 + 5, _username.center.y + _username.frame.size.height/2 + 2, 35, 10)];
        _viewsText.font = [UIFont systemFontOfSize:10];
        [self.contentView addSubview:_viewsText];
        
        // 回复图标
        _replysV = [[UIImageView alloc] initWithFrame:CGRectMake(_viewsText.center.x + _viewsText.frame.size.width/2 + 10, _username.center.y + _username.frame.size.height/2, 12, 12)];
        _replysV.image = [UIImage imageNamed:@"home-icon-answer-normal@3x.png"];
        [self.contentView addSubview:_replysV];
        
        // 回复次数
        _replys = [[UILabel alloc] initWithFrame:CGRectMake(_replysV.center.x + _replysV.frame.size.width/2 + 5, _username.center.y + _username.frame.size.height/2 + 2, 35, 10)];
        _replys.font = [UIFont systemFontOfSize:10];
        [self.contentView addSubview:_replys];
    }
    return self;
}
// 刷新Cell内容
- (void)updateCellWithApplication:(id)model
{
    if([model isKindOfClass:[TripModel class]])
    {
        TripModel * trip_model = (TripModel *)model;
        [self.photo setImageWithURL:[NSURL URLWithString:trip_model.photo] placeholderImage:[UIImage imageNamed:@"default_sale_bg_small@2x.png"]];
        self.title.text = trip_model.title;
        self.username.text = trip_model.username;
        self.viewsText.text = [NSString stringWithFormat:@"%@",trip_model.views];
        self.replys.text = trip_model.replys;
    }
    else
    {
        TripNewModel * tripNew_model = (TripNewModel *)model;
        [self.photo setImageWithURL:[NSURL URLWithString:tripNew_model.photo] placeholderImage:[UIImage imageNamed:@"default_sale_bg_small@2x.png"]];
        self.title.text = tripNew_model.title;
        self.username.text = tripNew_model.username;
        self.viewsText.text = [NSString stringWithFormat:@"%@",tripNew_model.views];
        self.replys.text = tripNew_model.replys;
    }
    
}


@end
