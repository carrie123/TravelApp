//
//  PackageViewController.m
//  TravelApp
//
//  Created by qianfeng on 15/11/26.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "PackageViewController.h"
#import "PackageModel.h"
#import "PackageCell.h"
#import "PackageDetailViewController.h"


@interface PackageViewController ()<UITableViewDataSource,UITableViewDelegate,MBProgressHUDDelegate>
{
    UITableView * _tableView;
    UIScrollView * _scrollView;
    NSDictionary * _category_Dic;
    NSDictionary * _categoryName_Dic;
    MBProgressHUD * _HUD;

}
@end

@implementation PackageViewController

{
    NSString * currentCategoryName;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = RGBR(247, 247, 247, 1);
    
    currentCategoryName = @"专题";
    
    // 初始化 tableView
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(Screen_Width*0.2, -20, Screen_Width*0.8,Screen_Height - TAB_TAB_HEIGHT + 20) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.autoresizesSubviews = NO;
    _tableView.showsHorizontalScrollIndicator = NO;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.tableFooterView = [[UIView alloc] init]; // 数据刷新之前，隐藏页面中的表格
    [self.view addSubview:_tableView];
    
    // 初始化指示器
    _HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    [self.navigationController.view addSubview:_HUD];
    _HUD.delegate = self;
    
    // 初始化 scrollView
    NSArray * nameArr = @[@"专题",@"中国内地",@"亚洲",@"欧洲",@"北美洲",@"南美洲",@"大洋洲",@"非洲"];
    CGFloat Btn_Height = ((Screen_Height - TAB_TAB_HEIGHT + 20)/7)*1.02;
    CGFloat Btn_Width = Screen_Width*0.2;
    
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width*0.2, Screen_Height - TAB_TAB_HEIGHT + 20)];
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.contentSize = CGSizeMake(Screen_Width*0.2, Btn_Height * nameArr.count);
    _scrollView.contentOffset = CGPointMake(0, 0);
    [self.view addSubview:_scrollView];
    
    UIButton * lastBtn = nil;
    for(int i = 0; i < 8; i ++)
    {
        UIButton * myBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        myBtn.frame = CGRectMake(0, lastBtn ? lastBtn.center.y + Btn_Height/2 : 0, Btn_Width, Btn_Height);
        myBtn.tag = i + 10;
        myBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        [myBtn setTitle:nameArr[i] forState:UIControlStateNormal];
        myBtn.backgroundColor = RGBR(247, 247, 247, 1);
        [_scrollView addSubview:myBtn];
        lastBtn = myBtn;
        if(i == 0)
        {
            [myBtn setTitleColor:RGBR(139, 139, 142, 1) forState:UIControlStateNormal];
            myBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        }
        else
        {
            [myBtn setTitleColor:RGBR(139, 139, 142, 1) forState:UIControlStateNormal];
        }
        [myBtn addTarget:self action:@selector(pressBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    // 注册cell
    [_tableView registerClass:[PackageCell class] forCellReuseIdentifier:@"PackageCell"];
    
    // 请求数据POST
    [self loadData];
    
    // 监听点击锦囊发送的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pushToPackDetail:) name:@"pushToPackDetailController" object:nil];
}
// 实现通知中的方法
- (void)pushToPackDetail:(NSNotification *)info
{
    PackageDetailViewController * packageDetailVC = [[PackageDetailViewController alloc] init];
    packageDetailVC.guide_id = [info.object firstObject]; // 锦囊ID
    packageDetailVC.fileDownPath = [info.object lastObject]; // 锦囊Zip文件下载地址
    [self.navigationController pushViewController:packageDetailVC animated:YES];
}
// 加载数据
- (void)loadData
{
    [_HUD show:YES];
    [DownLoadDataSource getPackagePageData:^(NSDictionary * model_Dic,NSDictionary * name_Dic, NSError *err) {
        [_HUD hide:YES];
        if(model_Dic&&name_Dic)
        {
            // 初始化数据
            _category_Dic = model_Dic;
            _categoryName_Dic = name_Dic;
            // 刷新
            [_tableView reloadData];
        }
        else
        {
            UIAlertView * a = [[UIAlertView alloc] initWithTitle:@"提示" message:@"数据下载失败" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [a show];
            NSLog(@"最新页---数据下载失败");
            a = nil;
        }
    }];
}
// 左侧大洲点击事件
- (void)pressBtn:(id)sender
{
    UIButton * btn = (UIButton *)sender;
    currentCategoryName = btn.titleLabel.text; // 改变 currentCategoryName 值，刷新tableView时有用
    for(int i = 0; i < 7; i ++) // 遍历所有Btn，改变被点击按钮颜色和字体大小
    {
        UIButton * myBtn = (UIButton *)[self.view viewWithTag:i +10];
        if(btn.tag == myBtn.tag)
        {
            [myBtn setTitleColor:RGBR(139, 139, 142, 1) forState:UIControlStateNormal];
            myBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        }
        else
        {
            [myBtn setTitleColor:RGBR(139, 139, 142, 1) forState:UIControlStateNormal];
            myBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        }
    }
    [_tableView reloadData];
}
// 设置头视图高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20;
}
// 设置头视图内容
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UILabel * l = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 20)];
    l.font = [UIFont systemFontOfSize:15];
    l.textColor = RGBR(139, 139, 142, 1);
    l.backgroundColor = [UIColor whiteColor];
    if([currentCategoryName isEqualToString:@"专题"])
    {
        l.text = @"  专题锦囊";
    }
    else if ([currentCategoryName isEqualToString:@"中国内地"])
    {
        l.text = @"  中国内地";
    }
    else
    {
        if(_categoryName_Dic)
        {
            NSArray *nameArr = [_categoryName_Dic objectForKey:currentCategoryName];
            l.text = [NSString stringWithFormat:@"  %@",nameArr[section]];
        }
    }
    return l;
}
#pragma mark --- <UITableViewDataSource,UITableViewDelegate>
// 每个分区cell个数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
// 设置cell内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PackageCell * packCell = [tableView dequeueReusableCellWithIdentifier:@"PackageCell"];
    if(_category_Dic)
    {
        // 获取当前分区所有 国家模型
        [packCell updateCellWithApplication: [self getCurrentModelArr:indexPath]];
    }
    return packCell;
}

- (NSArray *)getCurrentModelArr:(NSIndexPath *)indexPath
{
    NSArray * modelArr = [NSArray array];
    if([currentCategoryName isEqualToString:@"专题"] )
    {
        modelArr = [_category_Dic objectForKey:@"专题"];
        return modelArr;
    }
    else if ([currentCategoryName isEqualToString:@"中国内地"])
    {
        modelArr = [_category_Dic objectForKey:@"中国内地"];
        return modelArr;
    }
    else
    {
        NSString * countryName = [_categoryName_Dic objectForKey:currentCategoryName][indexPath.section];
        NSArray * countryArr = [_category_Dic objectForKey:currentCategoryName];
        for (NSDictionary * contryDic in countryArr)
        {
            if([contryDic objectForKey:countryName])
            {
                modelArr = [contryDic objectForKey:countryName];
                return modelArr;
            }
        }
        return 0;
    }
    
}
// 分区个数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if([currentCategoryName isEqualToString:@"专题"]||[currentCategoryName isEqualToString:@"中国内地"])
    {
        return 1;
    }
    else
    {
        if(_categoryName_Dic)
        {
            return [[_categoryName_Dic objectForKey:currentCategoryName] count];
        }
        return 0;
    }
}
// 设置cell高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSArray * modelArr = [self getCurrentModelArr:indexPath];
    
    if(modelArr.count%2 == 0)       // 双数个cell
    {
        return  PackageCollectionView_HEIGHTWith_DualCount(modelArr.count);
    }
    else                                // 单数个cell
    {
        return PackageCollectionView_HEIGHTWith_SingularCount(modelArr.count);
    }
}
- (void)dealloc
{
    // 下面的方法是可以移除Children中所有通知
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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
