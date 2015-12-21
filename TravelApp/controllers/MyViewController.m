//
//  MyViewController.m
//  TravelApp
//
//  Created by qianfeng on 15/11/26.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "MyViewController.h"
#import "MyPackageViewController.h"
#import "PackageDB.h"
#import "OTCover.h"

static BOOL isTop = YES; // 判断视图是否在顶部

@interface MyViewController () <UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>

@property (nonatomic,strong) OTCover * OTCoverV;
/**
 *  顶部蒙版
 */
@property (nonatomic, strong) UIImageView * imageM;
/**
 *  右上设置按钮
 */
@property (nonatomic,strong) UIButton * setBtn;
@end

@implementation MyViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 图片伸缩三方库初始化
    _OTCoverV = [[OTCover alloc] initWithTableViewWithHeaderImage:[UIImage imageNamed:@"profileHeader.jpg"] withOTCoverHeight:240];
    _OTCoverV.tableView.delegate = self;
    _OTCoverV.tableView.dataSource = self;
    _OTCoverV.tableView.autoresizesSubviews = NO;
    _OTCoverV.tableView.tableFooterView = [[UIView alloc] init];
    [self.view addSubview:_OTCoverV];
    
    // 初始化蒙版
    _imageM = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, 64)];
    _imageM.backgroundColor = RGBR(255, 255, 255, 0);
    _imageM.userInteractionEnabled = YES;
    [self.view addSubview:_imageM];
    
    // 初始化蒙版上分享按钮
    _setBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _setBtn.frame = CGRectMake(Screen_Width - 30 - 5, 20 + 10, 24, 24);
    [_setBtn setImage:[UIImage imageNamed:@"ic_topbar_setting@2x"] forState:UIControlStateNormal];
    [_setBtn addTarget:self action:@selector(pressSetBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_imageM addSubview:_setBtn];
    
    
}
#pragma mark --- <UITableViewDataSource,UITableViewDelegate>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray * nameArr = @[@"我的行程",@"我的优惠",@"我的结伴",@"我的帖子",@"我的锦囊"];
    
    // 创建系统样式cell
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cellid"];
    if(!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellid"];
        cell.textLabel.font = [UIFont systemFontOfSize:15];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.text = nameArr[indexPath.row];
        cell.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"headerBottomIcon%ld@2x",indexPath.row+1]];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 4) // 我的锦囊
    {
        MyPackageViewController * myPackageVC = [[MyPackageViewController alloc] init];
        NSArray * allPackageArr = [PackageDB MR_findAll];
        myPackageVC.allPackageArr = [NSArray arrayWithArray:allPackageArr];
        [self.navigationController pushViewController:myPackageVC animated:YES];
    }
}

// 蒙版上分享按钮
- (void)pressSetBtn:(id)sender
{
    NSLog(@"跳转设置接口");
}
// web滚动时 根据 scrollView 的位置发送不同的通知
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // scrollView 向上推
    if(isTop && (scrollView.contentOffset.y > 44))
    {
        // 用动画过渡坐标的变化
        [UIView animateWithDuration:0.2 animations:^{
            //动画的内容
            self.imageM.backgroundColor = RGBR(255, 255, 255, 0.9);
        } completion:nil];
        [_setBtn setImage:[UIImage imageNamed:@"ic_topbar_setting_orange@2x"] forState:UIControlStateNormal];
        isTop = NO;
    }
    
    // scrollView 回到原点
    if(!isTop && (scrollView.contentOffset.y < 44))
    {
        // 用动画过渡坐标的变化
        [UIView animateWithDuration:0.2 animations:^{
            //动画的内容
            self.imageM.backgroundColor = RGBR(255, 255, 255, 0);
        } completion:nil];
        [_setBtn setImage:[UIImage imageNamed:@"ic_topbar_setting@2x"] forState:UIControlStateNormal];
        isTop = YES;
    }
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    self.navigationController.navigationBarHidden = YES;
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
