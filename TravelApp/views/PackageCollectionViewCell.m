//
//  PackageCollectionViewCell.m
//  TravelApp
//
//  Created by qianfeng on 15/12/17.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "PackageCollectionViewCell.h"
#import "PackageModel.h"

@implementation PackageCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        // 城市图片
        _photo = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        _photo.image = [UIImage imageNamed:@"default_book_cover@2x.png"];
        [self.contentView addSubview:_photo];
    }
    return self;
}
// 刷新cell内容
- (void)updateCellWithApplication:(PackageModel *)model
{
    NSString * url = [NSString stringWithFormat:@"%@/260_390.jpg?%@",model.cover,model.cover_updatetime];
    
    [_photo setImageWithURL:[NSURL URLWithString:url]];
}


@end
