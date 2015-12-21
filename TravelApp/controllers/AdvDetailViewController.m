//
//  AdvDetailViewController.m
//  TravelApp
//
//  Created by qianfeng on 15/11/30.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "AdvDetailViewController.h"


static BOOL isShowWebView;

@interface AdvDetailViewController ()

@end

@implementation AdvDetailViewController

#pragma mark --- lazy
- (NSOperationQueue *)queue
{
    if (!_queue)
    {
        self.queue = [[NSOperationQueue alloc] init];
    }
    return _queue;
}

- (void)viewDidLoad
{
    isShowWebView = NO;
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.view.userInteractionEnabled = YES;
    UITapGestureRecognizer * webViewTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pressWebView:)];
    
    // 初始化webView
    _webView = [[CustomWebView alloc] initWithFrame:CGRectMake(0,64, Screen_Width,Screen_Height)];
    _webView.backgroundColor = [UIColor redColor];
    _webView.scrollView.bounces = NO;
    _webView.scrollView.contentOffset = CGPointMake(0, 0);
    [_webView.scrollView addGestureRecognizer:webViewTap];
    [self.view addSubview:_webView];
    _webView.myDelegate = self;
    
    // 初始化title
    _imageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, 64)];
    _imageV.backgroundColor = RGBR(255, 255, 255, 0.9);
    _imageV.userInteractionEnabled = YES;
    [self.view addSubview:_imageV];
    
    // 初始化title上返回按钮
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(5, 20 + 5, 30, 30);
    [btn setImage:[UIImage imageNamed:@"ic_topbar_back@2x.png"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(pressBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_imageV addSubview:btn];
    
    // 初始化title上分享按钮
    UIButton * shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    shareBtn.frame = CGRectMake(Screen_Width - 30 - 5, 20 + 10, 24, 24);
    [shareBtn setImage:[UIImage imageNamed:@"icon_share@2x"] forState:UIControlStateNormal];
    [shareBtn addTarget:self action:@selector(pressShareBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_imageV addSubview:shareBtn];
    
    // 初始化中心图片 centerImage
    _centerImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 25, 25)];
    _centerImage.center = CGPointMake(_imageV.center.x, _imageV.center.y+10);
    _centerImage.image = [UIImage imageNamed:@"fit_ptr_icon_fg@2x.png"];
    [_imageV addSubview:_centerImage];
    
    // 异步下载网页信息
    __weak typeof(self) weakSelf = self;
    NSBlockOperation * operation = [NSBlockOperation blockOperationWithBlock:^{
        NSURLRequest *request=[NSURLRequest requestWithURL:[NSURL URLWithString:self.newsURL]];
        // 回到主线程刷新webView
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            [weakSelf.webView loadRequest:request];
        }];
    }];
    // 添加操作到队列中
    [self.queue addOperation:operation];
    
    // 接收滚动webView时触发的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeGo) name:@"Go" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeBack) name:@"Back" object:nil];
}
// 蒙版上分享按钮
- (void)pressShareBtn:(id)sender
{
//    
//    [UMSocialSnsService presentSnsIconSheetView:self
//                                         appKey:@"5604aa97e0f55ac707002370"
//                                      shareText:[NSString stringWithFormat:@"%@\n‘信息提供来自于 爱旅游APP’",self.newsURL]
//                                     shareImage:nil
//                                shareToSnsNames:[NSArray arrayWithObjects:UMShareToSina,nil]
//                                       delegate:self];
}
- (void)TapOnWebView
{
    if(self.webView.scrollView.contentOffset.y != 0)
    {
        if(isShowWebView == NO)
        {
            // 用动画过渡坐标的变化
            [UIView animateWithDuration:0.4 animations:^{
                //动画的内容
                [self.imageV setAlpha:0.9];
            } completion:nil];
            isShowWebView = YES;
        }
        else
        {
            // 用动画过渡坐标的变化
            [UIView animateWithDuration:0.4 animations:^{
                //动画的内容
                [self.imageV setAlpha:0.0];
            } completion:nil];
            isShowWebView = NO;
        }
    }
}
- (void)pressWebView:(UITapGestureRecognizer *)tap
{
    // 用动画过渡坐标的变化
    [UIView animateWithDuration:0.1 animations:^{
        //动画的内容
        [self.imageV setAlpha:0.9];
    } completion:nil];
}
- (void)pressBtn:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark --- 实现通知中方法（在到达临界点时改变webView坐标）
- (void)changeGo
{
    // 用动画过渡坐标的变化
    [UIView animateWithDuration:0.1 animations:^{
        //动画的内容
        _webView.frame = CGRectMake(0, 0, Screen_Width, Screen_Height);
        [self.imageV setAlpha:0.0];
    } completion:nil];
}
- (void)changeBack
{
    // 用动画过渡坐标的变化
    [UIView animateWithDuration:0.2 animations:^{
        //动画的内容
        _webView.frame = CGRectMake(0, 64, Screen_Width, Screen_Height);
        [self.imageV setAlpha:0.9];
    } completion:nil];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];;
    [[self rdv_tabBarController] setTabBarHidden:YES animated:YES]; // 界面显示时隐藏底部tabBAr
}
// 当页面消失时跳转回首页
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
    [self.rdv_tabBarController setTabBarHidden:NO animated:YES]; // 界面显示时隐藏底部tabBAr
    // 还原相关属性
    _webView.frame = CGRectMake(0, 64, Screen_Width, Screen_Height);
    [self.imageV setAlpha:0.9];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
