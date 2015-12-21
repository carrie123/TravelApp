//
//  IconAndTextCell.m
//  TravelApp
//
//  Created by qianfeng on 15/12/17.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "IconAndTextCell.h"
#import "PackageDetailModel.h"

@implementation IconAndTextCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        // 计算cell尺寸
        CGFloat cellHeight = 44;
        // 头像图片
        _photo = [[UIImageView alloc] initWithFrame:CGRectMake(10, 0, cellHeight - 5*2, cellHeight - 5*2)];
        _photo.image = [UIImage imageNamed:@"default_user_icon_03@2x"];
        _photo.layer.masksToBounds = YES;
        _photo.layer.cornerRadius = (cellHeight - 5*2)/2;
        [self.contentView addSubview:_photo];
        
        // 作者名字
        _name = [[UILabel alloc] initWithFrame:CGRectMake(10 + cellHeight, 0, Screen_Width/2, cellHeight)];
        _name.font = [UIFont systemFontOfSize:13];
        [self.contentView addSubview:_name];
        
    }
    return self;
}
// 刷新cell内容 author_name; author_icon;
- (void)updateCellWithApplication:(PackageDetailModel *)model
{
    [_photo setImageWithURL:[NSURL URLWithString:model.author_icon]];
    _name.text = model.author_name;
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
