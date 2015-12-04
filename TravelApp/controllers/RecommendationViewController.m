//
//  RecommendationViewController.m
//  TravelApp
//
//  Created by qianfeng on 15/11/26.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "RecommendationViewController.h"
#import "ScrollTableViewCell.h"
#import "TripModel.h"
#import "NextStationCell.h"
#import "TripTableViewCell.h"

#import "AdvDetailViewController.h"

static BOOL isTop = YES;

@interface RecommendationViewController ()<UITableViewDataSource,UITableViewDelegate,MBProgressHUDDelegate,ScrollTableViewCellDelegate,NextStationCellDelegate>
{
    NSMutableArray * _resultArray; //存放返回的所有数据
    NSMutableArray * _adArray; //存放广告数据
    NSMutableArray * _placeArray; //存放下一站数据
    NSMutableArray * _tripArray; //存放邮件数据
}
@property (nonatomic, retain) UITableView * tableView;
/***顶部蒙板*/
@property (nonatomic,strong) UIImageView * imageM;
/***顶部标题*/
@property (nonatomic,strong) UIImageView * imageTop;
/**指示器*/
@property (nonatomic,strong) MBProgressHUD * HUD;

@end

@implementation RecommendationViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    self.navigationController.navigationBarHidden = YES;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,-20, Screen_Width,Screen_Height - TAB_TAB_HEIGHT + 20) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.autoresizesSubviews = NO;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.tableFooterView = [[UIView alloc] init]; // 数据刷新之前，隐藏页面中的表格
    [self.view addSubview:_tableView];
    
    // 初始化指示器
    _HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    [self.navigationController.view addSubview:_HUD];
    _HUD.delegate = self;
    
    // 创建顶部蒙版
    _imageM = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, 64)];
    _imageM.backgroundColor = RGBR(255, 255, 255, 0);
    [self.view addSubview:_imageM];
    // 创建顶部图标
    _imageTop = [[UIImageView alloc] initWithFrame:CGRectMake(_imageM.center.x - 25/2, 20 + (44 - 25)/2, 25, 25)];
    _imageTop.image = [UIImage imageNamed:@"fit_ptr_icon_fg@2x.png"];
    _imageTop.hidden = YES;
    [self.view addSubview:_imageTop];
    
    // 注册 Cell
    [_tableView registerClass:[ScrollTableViewCell class] forCellReuseIdentifier:@"ScrollTableViewCell"];
    [_tableView registerClass:[NextStationCell class] forCellReuseIdentifier:@"NextStationScrollCell"];
    [_tableView registerClass:[TripTableViewCell class] forCellReuseIdentifier:@"tripTableViewCell"];
    
    [self loadData]; // 请求数据
}

// 加载数据
- (void)loadData
{
    [_HUD show:YES];
    [DownLoadDataSource getRecomPageData:^(NSArray * arr, NSError *err) {
        [_HUD hide:YES];
        if(arr)
        {
            _resultArray = [NSMutableArray arrayWithArray:arr];
            _adArray = arr[0];
            _placeArray = arr[1];
            _tripArray = arr[2];
            [self.tableView reloadData];
        }
        else
        {
            UIAlertView * a = [[UIAlertView alloc] initWithTitle:@"提示" message:@"数据下载失败" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            // [a show];
            NSLog(@"最新页---数据下载失败");
            a = nil;
        }
    }];
}

#pragma mark --- 实现<UITableViewDataSource,UITableViewDelegate>协议中方法
- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}
// 设置cell数量
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section == 0) // 广告
    {
        return 1;
    }
    else if (section == 1) // 发现下一站
    {
        return 2;
    }
    else                    // 热门游记
    {
        return _tripArray.count + 1;
    }
}
// 设置行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 0)
    {
        return Screen_Height*0.3; // 广告cell高度是屏幕高度的1/3
    }
    else if (indexPath.section == 1) // 发现下一站
    {
        if(indexPath.row == 0)
        {
            return 35;
        }
        else
        {
            return (Screen_Height / 6); // (SCREEN_HEIGHT / 5)*4 + 5*3
        }
    }
    else                            // 游记
    {
        if(indexPath.row == 0)
        {
            return 35;
        }
        return 80;
    }
}
// 设置头视图
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if(section == 0)
    {
        return 0;
    }
    return 10;
}
// 设置cell内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellID = @"cellid";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if(!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.textLabel.text = [NSString stringWithFormat:@"%ld",indexPath.row];
        cell.textLabel.textColor = RGBR(139, 139, 142, 1);
        cell.textLabel.font = [UIFont systemFontOfSize:15];
    }
    
    // 设置不同分区内容
    if(indexPath.section == 0)      // 广告
    {
        ScrollTableViewCell * scrollTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"ScrollTableViewCell"];
        scrollTableViewCell.selectionStyle = UITableViewCellSelectionStyleNone;
        scrollTableViewCell.myDelegate = self;
        [scrollTableViewCell updateCellWithApplication:_adArray];
        return  scrollTableViewCell;
    }
    else if(indexPath.section == 1) // 发现下一站
    {
        if(indexPath.row == 0)
        {
            cell.textLabel.text = @"发现下一站";
            return cell;
        }
        else
        {
            NextStationCell * nextStationCell = [tableView dequeueReusableCellWithIdentifier:@"NextStationScrollCell"];
            nextStationCell.selectionStyle = UITableViewCellSelectionStyleNone;
            nextStationCell.myDelegate = self;
            [nextStationCell updateCellWithApplication:_placeArray];
            return  nextStationCell;
        }
    }
    else                            // 热门游记
    {
        if(indexPath.row == 0)
        {
            cell.textLabel.text = @"热门游记";
            return cell;
        }
        else
        {
            TripTableViewCell * tripCell = [tableView dequeueReusableCellWithIdentifier:@"tripTableViewCell"];
            tripCell.selectionStyle = UITableViewCellSelectionStyleNone;
            [tripCell updateCellWithApplication:_tripArray[indexPath.row - 1]];
            return tripCell;
        }
    }
}
// 选中cell时 实现的方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if((indexPath.section == 2) && (indexPath.row != 0))
    {
        AdvDetailViewController * advVC = [[AdvDetailViewController alloc] init];
        TripModel * model = _tripArray[indexPath.row - 1];
        advVC.newsURL = model.view_url;
        [self.navigationController pushViewController:advVC animated:YES];
    }
}
#pragma mark --- 实现<ScrollTableViewCellDelegate,NextStationCellDelegate>协议中方法
- (void)pressAdvURL:(NSString *)advURL
{
    AdvDetailViewController * advVC = [[AdvDetailViewController alloc] init];
    advVC.newsURL = advURL;
    [self.navigationController pushViewController:advVC animated:YES];
}

// web滚动时 根据 scrollView 的位置发送不同的通知
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // webView向上推
    if(isTop && (scrollView.contentOffset.y > 44))
    {
        // 用动画过渡坐标的变化
        [UIView animateWithDuration:0.2 animations:^{
            //动画的内容
            self.imageM.backgroundColor = RGBR(255, 255, 255, 0.7);
        } completion:nil];
        isTop = NO;
        _imageTop.hidden = NO;
    }
    // webView回到原点
    if(!isTop && (scrollView.contentOffset.y < 44))
    {
        // 用动画过渡坐标的变化
        [UIView animateWithDuration:0.2 animations:^{
            //动画的内容
            self.imageM.backgroundColor = RGBR(255, 255, 255, 0.0);
        } completion:nil];
        isTop = YES;
        _imageTop.hidden = YES;
        
    }
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
