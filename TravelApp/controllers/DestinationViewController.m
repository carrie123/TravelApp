//
//  DestinationViewController.m
//  TravelApp
//
//  Created by qianfeng on 15/11/26.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "DestinationViewController.h"
#import "CountryCell.h"
#import "CatenateModel.h"
#import "CountryListModel.h"
#import "HotCountryListModel.h"
#import "CountryDetailViewController.h"
#import "MapCell.h"
#import "DownLoadDataSource.h"

static NSInteger P_NUM = 1; // 保存选择国家的序号

@interface DestinationViewController ()<UITableViewDataSource,UITableViewDelegate,MBProgressHUDDelegate,MapCellDelegate>

@end

@implementation DestinationViewController
{
    NSMutableArray * _catenateModelArr; // 大洲
    CatenateModel * _catenateModel; // 大洲数据
    NSMutableArray * _hotcountrylistArr; // 热门国家
    NSMutableArray * _countrylistArr; // 其他国家
    MBProgressHUD * _HUD;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,-20, Screen_Width,Screen_Height - TAB_TAB_HEIGHT + 20) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.autoresizesSubviews = NO;
    _tableView.tableFooterView = [[UIView alloc] init]; // 数据刷新之前，隐藏页面中的表格
    [self.view addSubview:_tableView];
    
    // 初始化指示器
    _HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    [self.navigationController.view addSubview:_HUD];
    _HUD.delegate = self;
    
    // 注册 Cell
    [_tableView registerClass:[MapCell class] forCellReuseIdentifier:@"MapCell"];
    [_tableView registerClass:[CountryCell class] forCellReuseIdentifier:@"countryCell"];
    
    // 请求数据POST
    [self loadData];
    
    // 接受选中热门城市cell时的跳转通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pushToCountryDetailVC:) name:@"pushToCountryDetailController" object:nil];
}
// 实现通知中的方法
- (void)pushToCountryDetailVC:(NSNotification *)info
{
    CountryDetailViewController * countryDetailVC = [[CountryDetailViewController alloc] init];
    countryDetailVC.countryID = info.object;
    [self.navigationController pushViewController:countryDetailVC animated:YES];
}
// 加载数据
- (void)loadData
{
    [_HUD show:YES];
    [DownLoadDataSource postDestinationPageData:^(NSArray * catename_ModelArr, NSError *err) {
        [_HUD hide:YES];
        if(catename_ModelArr)
        {
            _catenateModelArr = [NSMutableArray arrayWithArray:catename_ModelArr];
            _catenateModel = catename_ModelArr[P_NUM];
            _hotcountrylistArr = [NSMutableArray arrayWithArray:_catenateModel.hotcountrylist];
            _countrylistArr = [NSMutableArray arrayWithArray:_catenateModel.countrylist];
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
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    self.navigationController.navigationBarHidden = YES;
}

#pragma mark -- <MapCellDelegate>
-(void)pressPosition:(POSITION_NUM)position
{
    // 根据选择的国家气泡刷新数据
    P_NUM = position;
    _catenateModel = _catenateModelArr[P_NUM];
    _hotcountrylistArr = [NSMutableArray arrayWithArray:_catenateModel.hotcountrylist];
    _countrylistArr = [NSMutableArray arrayWithArray:_catenateModel.countrylist];
    
    [_tableView reloadData];
}


#pragma mark --- <UITableViewDataSource,UITableViewDelegate>
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section == 0)
    {
        return 1;
    }
    else if (section == 1)
    {
        return 2;
    }
    else
    {
        return _countrylistArr.count + 1;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * str = @"cellid";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:str];
    if(!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    // @[@“热门”,@"亚洲",@"欧洲",@"北美洲",@"南美洲",@"大洋洲",@"非洲",@"南极洲"];
    NSArray * nameArr1 = @[@"热门目的地",@"亚洲目的地",@"欧洲目的地",@"北美洲目的地",@"南美目的地",@"大洋洲目的地",@"非洲目的地",@"南极洲目的地"];
    NSArray * nameArr2 = @[@"热门其他目的地",@"亚洲其他目的地",@"欧洲其他目的地",@"北美洲其他目的地",@"南美其他目的地",@"大洋洲其他目的地",@"非洲其他目的地",@"南极洲其他目的地"];
    
    if(indexPath.section == 0)
    {
        MapCell * mapCell = [tableView dequeueReusableCellWithIdentifier:@"MapCell"];
        mapCell.delegate = self;
        if(!_catenateModelArr)
        {
            mapCell.userInteractionEnabled = NO;
        }
        else
        {
            mapCell.userInteractionEnabled = YES;
        }
        return mapCell;
    }
    else if (indexPath.section == 1)
    {
        if(indexPath.row == 0)
        {
            cell.textLabel.text = nameArr1[P_NUM];
            cell.accessoryType = UITableViewCellAccessoryNone;
            return cell;
        }
        else
        {
            CountryCell * conCell = [tableView dequeueReusableCellWithIdentifier:@"countryCell"];
            if(_hotcountrylistArr)
            {
                [conCell updateCellWithApplication: _hotcountrylistArr];
            }
            return conCell;
        }
    }
    else
    {
        if(indexPath.row == 0)
        {
            cell.textLabel.text = nameArr2[P_NUM];
            cell.accessoryType = UITableViewCellAccessoryNone;
            return cell;
        }
        else
        {
            CountryListModel * model = _countrylistArr[indexPath.row - 1];
            cell.textLabel.text = model.catename;
            cell.textLabel.font = [UIFont systemFontOfSize:15];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            return cell;
        }
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 0)
    {
        return Screen_Width * 0.6;
    }
    else if (indexPath.section == 1)
    {
        if(indexPath.row == 0)
        {
            return 44;
        }
        else
        {
            if(_hotcountrylistArr)
            {
                if(_hotcountrylistArr.count%2 == 0) // 双数个cell
                {
                    return CollectionView_HEIGHTWith_DualCount(_hotcountrylistArr.count);
                }
                else                                // 单数个cell
                {
                    return CollectionView_HEIGHTWith_SingularCount(_hotcountrylistArr.count);
                }
            }
            else
            {
                return 0;
            }
        }
    }
    else
    {
        if(indexPath.row == 0)
        {
            return 44;
        }
        else
        {
            return 44;
        }
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 点击其他城市cell跳转动作
    if((indexPath.section == 2)&&(indexPath.row != 0))
    {
        CountryListModel * model = _countrylistArr[indexPath.row - 1];
        CountryDetailViewController * countryDetailVC = [[CountryDetailViewController alloc] init];
        countryDetailVC.countryID = model.pid;
        [self.navigationController pushViewController:countryDetailVC animated:YES];
    }
}
- (void)dealloc
{
    // 下面的方法是可以移除Children中所有通知
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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
