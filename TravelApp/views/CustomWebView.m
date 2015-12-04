//
//  CustomWebView.m
//  TravelApp
//
//  Created by qianfeng on 15/11/30.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "CustomWebView.h"

static BOOL isTop; // 判断是否在页顶
@interface CustomWebView ()
/**
 *  webView单击手势
 */
@property(nonatomic,strong) UITapGestureRecognizer * tap;

@end
@implementation CustomWebView
- (instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        _tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapWebView:)];
        _tap.delegate = self;
        [self.scrollView addGestureRecognizer:_tap];
        isTop = YES;
    }
    return self;
}
#pragma mark --- <UIGestureRecognizerDelegate> 协议中的方法 想要自定义手势必须实现此方法 用来判断是否为webView自带手势
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    if (gestureRecognizer == self.tap)
    {
        return YES;
    }
    return NO;
}
// 单击webView时回到控制器响应方法
- (void)tapWebView:(UITapGestureRecognizer *)tap
{
    if([self.myDelegate respondsToSelector:@selector(TapOnWebView)])
    {
        [self.myDelegate TapOnWebView];
    }
}
// web滚动时 根据 scrollView 的位置发送不同的通知
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // webView向上推
    if((isTop == YES)&&(scrollView.contentOffset.y > 0))
    {
        isTop = NO;
        // 发送通知
        [[NSNotificationCenter defaultCenter] postNotificationName:@"Go" object:nil];
        
    }
    // webView回到原点
    if((isTop == NO)&&(scrollView.contentOffset.y == 0))
    {
        isTop = YES;
        // 发送通知
        [[NSNotificationCenter defaultCenter] postNotificationName:@"Back" object:nil];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
