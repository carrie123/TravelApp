//
//  ScrollTableViewCell.m
//  TravelApp
//
//  Created by qianfeng on 15/11/30.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "ScrollTableViewCell.h"
#import "AdvDetailViewController.h"

@implementation ScrollTableViewCell
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
        
        _scroll.bounces = NO;
        _scroll.showsHorizontalScrollIndicator = NO;
        _scroll.showsVerticalScrollIndicator = NO;
        _scroll.contentSize = CGSizeMake(superView.frame.size.width, superView.frame.size.height);
        _scroll.contentOffset = CGPointMake(Screen_Width, 0);
        _scroll.delegate = self;
        _scroll.pagingEnabled = YES;
        _scroll.tag = 100;
        [superView addSubview:_scroll];
        
        // 分页控件适配
        CGFloat cellHeight = Screen_Width*0.3;
        _page = [[UIPageControl alloc] initWithFrame:CGRectMake(0, cellHeight - 20, Screen_Width/3, 20)];
        [self.contentView addSubview:_page];
        _page.pageIndicatorTintColor = [UIColor blackColor];
        _page.currentPageIndicatorTintColor = RGBR(253, 139, 8, 1);
        _page.numberOfPages = 1;
        _page.currentPage = 0;
        [_page addTarget:self action:@selector(pageChanged:) forControlEvents:UIControlEventValueChanged];
        
        // 定时翻页
        [NSTimer scheduledTimerWithTimeInterval:4 target:self selector:@selector(changePage) userInfo:nil repeats:YES];
    }
    return self;
}

// 刷新Cell方法 （需要数据）
- (void)updateCellWithApplication:(NSArray *)modelArr
{
    _advArr = [NSMutableArray arrayWithArray:modelArr];
    // 设置滚动视图大小
    self.scroll.contentSize = CGSizeMake((modelArr.count + 2) * Screen_Width, self.contentView.frame.size.height);
    // 设置分页控件数量
    self.page.numberOfPages = modelArr.count;
    self.page.center = CGPointMake(Screen_Width/2, self.scroll.bounds.size.height - 10);
    
    // 设置滚动试图
    UIImageView * lastV;
    if(modelArr)
    {
        for(int i = 0;i < modelArr.count + 2; i++)
        {
            // 为每个图片添加单击手势
            UITapGestureRecognizer * imagTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
            // 设置滚动视图图片
            UIImageView * imageView = [[UIImageView alloc]init];
            imageView.userInteractionEnabled = YES;
            [imageView addGestureRecognizer:imagTap];
            [_scroll addSubview:imageView];
            
            
            [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(lastV ? lastV.mas_right : @0);
                make.top.equalTo(self.scroll.mas_top);
                make.width.equalTo(self.scroll);
                make.height.equalTo(self.scroll);
            }];
            
            NSInteger pageNUM = i;
            if(i == 0)
            {
                pageNUM = modelArr.count - 1;
                imageView.tag = modelArr.count - 1;
            }
            else if (i == modelArr.count + 1)
            {
                pageNUM = 0;
                imageView.tag = modelArr.count - 1;
            }
            else
            {
                pageNUM = i - 1;
                imageView.tag = 10 + i;
            }
            
            lastV = imageView;
            // 设置图片
            NSURL * url = [NSURL URLWithString: [modelArr[pageNUM] objectForKey:@"photo"]];
            [imageView setImageWithURL:url placeholderImage:[UIImage imageNamed:@"default_sale_bg_750_420@2x.png"]];
        }
    }
}
// 点击手势响应动作
- (void)tapAction:(UITapGestureRecognizer *)tap
{
    // 获取被点击试图
    UIImageView * currentTapImage = (UIImageView *)tap.view;
    for(int i = 0; i <_advArr.count; i ++)
    {
        if(currentTapImage.tag - 10 == i)
        {
            if([self.myDelegate respondsToSelector:@selector(pressAdvURL:)])
            {
                [self.myDelegate pressAdvURL:[_advArr[i] objectForKey:@"url"]];
            }
        }
    }
}
// page控件变化动作
-(void)pageChanged:(id)sender
{
    //    UIPageControl * pageC = (UIPageControl *)sender;
}

// scrollView换页时动作
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    // 循环滚动 7-1 2 3 4 5 6 7-1   all-9
    if(scrollView.contentOffset.x == 0)
    {
        scrollView.contentOffset = CGPointMake((_advArr.count + 2 - 2) * Screen_Width, 0);
        self.page.currentPage = _advArr.count;
    }
    else if(scrollView.contentOffset.x == (_advArr.count + 2 - 1) * Screen_Width)
    {
        scrollView.contentOffset = CGPointMake(Screen_Width, 0);
        self.page.currentPage = 0;
    }
    int page = scrollView.contentOffset.x / self.contentView.frame.size.width;
    self.page.currentPage = page - 1;
    
}
// 定时翻页
- (void)changePage
{
    CGPoint newPoint = _scroll.contentOffset;
    newPoint = CGPointMake(newPoint.x + Screen_Width, newPoint.y);
    
    [UIView animateWithDuration:1.5 animations:^{
        
        _scroll.contentOffset = newPoint;
        self.page.currentPage = self.page.currentPage + 1;
        
    }completion:^(BOOL finished) {
        
        if(_scroll.contentOffset.x == (_advArr.count + 2 - 1) * Screen_Width)
        {
            _scroll.contentOffset = CGPointMake(Screen_Width, 0);
            self.page.currentPage = 0;
        }
    }];
    
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
