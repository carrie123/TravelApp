//
//  NextStationCell.m
//  TravelApp
//
//  Created by qianfeng on 15/11/30.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "NextStationCell.h"
#import "PlaceModel.h"

@interface NextStationCell ()

@property(nonatomic,strong) UIScrollView * scroll;
@property(nonatomic,strong) NSMutableArray * placeArr; // 保存传递过来的数据

@end

@implementation NextStationCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.selectionStyle = UITableViewCellSelectionStyleNone; // 消除选中效果
        
        // 父视图
        UIView * superView = self.contentView;
        
        // scroll 适配
        _scroll = [[UIScrollView alloc]init];
        [self.contentView addSubview:_scroll];
        [_scroll mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(superView.mas_left).offset(0);
            make.top.equalTo(superView.mas_top).offset(0);
            make.width.equalTo(superView);
            make.height.equalTo(superView);
        }];
        
        _scroll.bounces = YES;
        _scroll.showsHorizontalScrollIndicator = NO;
        _scroll.showsVerticalScrollIndicator = NO;
        _scroll.contentSize = CGSizeMake(superView.frame.size.width, superView.frame.size.height);
        _scroll.contentOffset = CGPointMake(0, 0);
        //        _scroll.delegate = self;
        _scroll.tag = 100;
        [superView addSubview:_scroll];
        
    }
    return self;
}

// 刷新Cell方法 （需要数据）
- (void)updateCellWithApplication:(NSArray *)modelArr
{
    CGFloat cell_width = Screen_Width * 2 / 3;
    CGFloat cell_height = (Screen_Height / 6) - 10;
    
    _placeArr = [NSMutableArray arrayWithArray:modelArr];
    // 设置滚动视图大小
    self.scroll.contentSize = CGSizeMake(modelArr.count * cell_width + 10 * (modelArr.count + 1), self.contentView.frame.size.height);
    // 设置滚动试图
    if(modelArr)
    {
        for(int i = 0;i < modelArr.count; i++)
        {
            // 取出模型
            PlaceModel * model = modelArr[i];
            // 为每个图片添加单击手势
            UITapGestureRecognizer * imagTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
            // 设置滚动视图图片
            UIImageView * imageV = [[UIImageView alloc]init];
            imageV.frame = CGRectMake(10 + i*10 + i*cell_width, 0, cell_width, cell_height);
            imageV.userInteractionEnabled = YES;
            imageV.tag = 10 + i;
            [imageV addGestureRecognizer:imagTap];
            [_scroll addSubview:imageV];
            
            [imageV setImageWithURL:[NSURL URLWithString:model.photo]placeholderImage:[UIImage imageNamed:@"default_sale_bg_750_420@2x.png"]];
            
            // 蒙版
            UIImageView * imageM = [[UIImageView alloc] initWithFrame:CGRectMake(0, imageV.frame.size.height - 20, imageV.frame.size.width, 20)];
            imageM.backgroundColor = RGBR(100, 100, 100, 0.4);
            [imageV addSubview:imageM];
            
            // 创建小图标
            UIImageView * poiImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ic_bottomNav_local_select@2x.png"]];
            poiImage.frame = CGRectMake(5, (imageM.frame.size.height - 18)/2, 18, 18);
            [imageM addSubview:poiImage];
            
            // 创建文字label
            UILabel * titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(30,(imageM.frame.size.height - 18)/2,100,20)];
            titleLabel.font = [UIFont systemFontOfSize:12];
            titleLabel.textColor = RGBR(255, 255, 255, 1);
            titleLabel.text = model.title;
            [imageM addSubview:titleLabel];
        }
    }
}
// 点击手势响应动作
- (void)tapAction:(UITapGestureRecognizer *)tap
{
    // 获取被点击试图
    UIImageView * currentTapImage = (UIImageView *)tap.view;
    for(int i = 0; i <_placeArr.count; i ++)
    {
        PlaceModel * model = _placeArr[i];
        if(currentTapImage.tag - 10 == i)
        {
            if([self.myDelegate respondsToSelector:@selector(pressAdvURL:)])
            {
                [self.myDelegate pressAdvURL:model.url];
            }
        }
    }
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
