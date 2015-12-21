//
//  AdjustLableCell.m
//  TravelApp
//
//  Created by qianfeng on 15/12/17.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "AdjustLableCell.h"
#import "UILabel+AdjustFontSizeToLable.h"

@implementation AdjustLableCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        _myLabel = [[UILabel alloc] init];
        _myLabel.textColor = RGBR(139, 139, 142, 1);
        [self.contentView addSubview:_myLabel];
    }
    return self;
}

// 根据文本内容重新计算cell高度
-(void)setMyLabelText:(NSString *)text
{
    // 文本赋值
    _myLabel.text = text;
    
    // 设置显示最大行数
    self.myLabel.numberOfLines = 100;
    self.myLabel.font = [UIFont systemFontOfSize:13];
    
    // 设置画布大小
    CGSize size = CGSizeMake(Screen_Width - 20, 1000);
    
    // 根据信息进行绘图
    CGRect cellNewSize = [self.myLabel.text boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:13]} context:nil];
    
    // 重新设置label的高度
    self.myLabel.frame = CGRectMake(10, 0, cellNewSize.size.width, cellNewSize.size.height);
    
    // 设置cell的frame
    self.frame = CGRectMake(0, 0, Screen_Width, cellNewSize.size.height);
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
