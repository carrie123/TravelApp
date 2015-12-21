//
//  PackageDetailViewController.m
//  TravelApp
//
//  Created by qianfeng on 15/12/17.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "PackageDetailViewController.h"
#import "ZipArchive.h"
#import "NSString+Hashing.h"
#import "UILabel+AdjustFontSizeToLable.h"
#import "packageDetailModel.h"
#import "OTCover.h" // 图片伸缩
#import "AdjustLableCell.h"
#import "IconAndTextCell.h"
#import "RDVTabBarController.h"
#import "UMSocial.h"
#import "FileModel.h"
#import "FileDownLoad.h"
#import "PackageReadViewController.h"
#import "PackageDB.h"

static BOOL isTop = YES; // 判断视图是否在顶部

@interface PackageDetailViewController ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate,UMSocialUIDelegate>
{
    OTCover * _OTCoverV;
    UIImageView * _imageM; // 顶部蒙版
    PackageDetailModel * _packageDetailModel; // 保存请求下来的锦囊详细模型
    UILabel * _titleLabel; // Top标题
    UIButton * _downBtn; // 下载按钮
    FileModel * _fileModel; // 保存请求下来的锦囊model
    NSInteger _downFlag; // 标记锦囊下载状态 0--立即下载 1--继续下载 2--立即阅读
}

@end

@implementation PackageDetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // 图片伸缩三方库初始化
    _OTCoverV = [[OTCover alloc] initWithTableViewWithHeaderImage:[UIImage imageNamed:@"default_sale_bg_750_420@2x"] withOTCoverHeight:240];
    _OTCoverV.tableView.delegate = self;
    _OTCoverV.tableView.dataSource = self;
    _OTCoverV.tableView.autoresizesSubviews = NO;
    _OTCoverV.tableView.tableFooterView = [[UIView alloc] init];
    _OTCoverV.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_OTCoverV];
    
    // 初始化蒙版
    _imageM = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, 64)];
    _imageM.backgroundColor = RGBR(255, 255, 255, 0);
    _imageM.userInteractionEnabled = YES;
    [self.view addSubview:_imageM];
    
    // 初始化蒙版上返回按钮
    UIButton * backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(5, 20 + 5, 30, 30);
    [backBtn setImage:[UIImage imageNamed:@"ic_topbar_back@2x.png"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(pressBackBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_imageM addSubview:backBtn];
    
    // 初始化蒙版上分享按钮
    UIButton * shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    shareBtn.frame = CGRectMake(Screen_Width - 30 - 5, 20 + 10, 24, 24);
    [shareBtn setImage:[UIImage imageNamed:@"icon_share@2x"] forState:UIControlStateNormal];
    [shareBtn addTarget:self action:@selector(pressShareBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_imageM addSubview:shareBtn];
    
    // 初始化蒙版中央标题
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(_imageM.center.x - 100, 20 + 7, 200, 30)];
    _titleLabel.font = [UIFont systemFontOfSize:17];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.hidden = YES;
    [_imageM addSubview:_titleLabel];
    
    // 初始化线
    UIView * lineV = [[UIView alloc] initWithFrame:CGRectMake(0, Screen_Height - 40.0, Screen_Width, 0.5)];
    lineV.backgroundColor = RGBR(139, 139, 142, 1);
    [self.view addSubview:lineV];
    
    // 初始化下载按钮
    _downBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_downBtn setTitleColor:RGBR(139, 139, 142, 1) forState:UIControlStateNormal];
    _downBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    _downBtn.backgroundColor = [UIColor whiteColor];
    _downBtn.frame = CGRectMake(0, Screen_Height - 39.5, Screen_Width, 39.5);
    [_downBtn addTarget:self action:@selector(pressDownBtn:) forControlEvents:UIControlEventTouchUpInside];
    _downBtn.hidden = YES; // 锦囊文件下载状态未知时，先隐藏底部按钮
    [self.view addSubview:_downBtn];
    
    // 注册cell
    [_OTCoverV.tableView registerClass:[AdjustLableCell class] forCellReuseIdentifier:@"AdjustLableCell"];
    [_OTCoverV.tableView registerClass:[IconAndTextCell class] forCellReuseIdentifier:@"IconAndTextCell"];
    
    // 沙盒下创建文件夹
    // 压缩包位置
    [[NSFileManager defaultManager] createDirectoryAtPath:[NSString stringWithFormat:@"%@/Documents/zip",NSHomeDirectory()] withIntermediateDirectories:YES attributes:nil error:nil];
    // 解压缩后位置
    [[NSFileManager defaultManager] createDirectoryAtPath:[NSString stringWithFormat:@"%@/Documents/unZipFile",NSHomeDirectory()] withIntermediateDirectories:YES attributes:nil error:nil];
    
    // 请求数据
    [self loadData];
}
#pragma mark --- <UITableViewDataSource,UITableViewDelegate>
// cell个数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section == 0)
    {
        return 2;
    }
    else
    {
        return 3;
    }
}
// 分区数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
// 设置cell内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray * nameArr = @[@"简介",@"锦囊作者"];
    
    // 创建系统样式cell
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cellid"];
    if(!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellid"];
        cell.textLabel.font = [UIFont systemFontOfSize:15];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    // 取出自定义cell
    AdjustLableCell * adjustCell = [tableView dequeueReusableCellWithIdentifier:@"AdjustLableCell"];
    adjustCell.selectionStyle = UITableViewCellSelectionStyleNone;
    IconAndTextCell * iconCell = [tableView dequeueReusableCellWithIdentifier:@"IconAndTextCell"];
    iconCell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if(indexPath.section == 0)
    {
        if(indexPath.row == 0)
        {
            cell.textLabel.text = nameArr[0];
            return cell;
        }
        else
        {
            if(_packageDetailModel)
            {
                [adjustCell setMyLabelText:_packageDetailModel.briefinfo];
                return adjustCell;
            }
        }
    }
    else
    {
        if(indexPath.row == 0)
        {
            cell.textLabel.text = nameArr[1];
            return cell;
        }
        else if(indexPath.row == 1)
        {
            if(_packageDetailModel)
            {
                [iconCell updateCellWithApplication:_packageDetailModel];
                return iconCell;
            }
        }
        else
        {
            if(_packageDetailModel)
            {
                [adjustCell setMyLabelText:_packageDetailModel.author_intro];
                return adjustCell;
            }
        }
    }
    return cell;
}
// cell高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if((indexPath.section == 0)&&(indexPath.row == 1)) // 锦囊简介 需要自适应高度
    {
        if(_packageDetailModel)
        {
            // 调用初始化cell内容方法，计算出当前cell的高度
            AdjustLableCell * adjustCell = (AdjustLableCell *)[self tableView:tableView cellForRowAtIndexPath:indexPath];
            
            return adjustCell.frame.size.height;
        }
    }
    else if(indexPath.section == 1)
    {
        if(indexPath.row == 1)
        {
            return 44;
        }
        else if(indexPath.row == 2) // 作者简介 需要自适应高度
        {
            AdjustLableCell * adjustCell = (AdjustLableCell *)[self tableView:tableView cellForRowAtIndexPath:indexPath];
            return adjustCell.frame.size.height;
        }
    }
    return 44;
}
// 下载数据
- (void)loadData
{
    [DownLoadDataSource getPackageDetailData:^(PackageDetailModel * model, NSError *err) {
        
        _packageDetailModel = model;
        
        // 设置图片上的title
        _OTCoverV.textLabel.text = [NSString stringWithFormat:@"大小: %@  下载: %@",model.size,model.download];
        // 设置顶部标题
        _titleLabel.text = _packageDetailModel.name;
        
        // 异步设置顶部图片
        NSBlockOperation *operation = [NSBlockOperation blockOperationWithBlock:^{
            NSString * imageUrl = [NSString stringWithFormat:@"%@/670_420.jpg?%@",model.cover,model.cover_updatetime];
            NSURL *url = [NSURL URLWithString:imageUrl];
            NSData *data = [NSData dataWithContentsOfURL:url]; // 下载
            UIImage *image = [UIImage imageWithData:data]; // NSData -> UIImage
            
            // 回到主线程
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                [_OTCoverV setHeaderImage:image];
                // 刷新 tableView
                [_OTCoverV.tableView reloadData];
            }];
        }];
        NSOperationQueue *queue = [[NSOperationQueue alloc] init];
        [queue addOperation:operation];
        
        //创建锦囊Model
        _fileModel =  [FileModel fileModelWithDict:_packageDetailModel.mobile_guide];
        _fileModel.downloadSize = [NSNumber numberWithInt:0];
        _fileModel.isFinished = NO;
        
        // 通过读取本地文件大小判断锦囊下载进度 _downFlag 0--立即下载 1--继续下载 2--立即阅读
        // 获取本地路径下的锦囊文件
        //        NSString * str = [self localPath];
        NSFileHandle * _fileHandle = [NSFileHandle fileHandleForReadingAtPath:[self localPath]];
        if(_fileHandle == nil) // 锦囊文件不存在
        {
            _downFlag = 0;
            [_downBtn setTitle:@"立即下载" forState:UIControlStateNormal];
        }
        else                   // 锦囊文件已存在
        {
            // 将节点跳到文件的末尾
            [_fileHandle seekToEndOfFile];
            
            // offsetInFile 获取当前文件的偏移量
            _fileModel.downloadSize = [NSNumber numberWithLongLong:[_fileHandle offsetInFile]];
            
            // 计算当前已下载进度
            CGFloat progress = [_fileModel.downloadSize longLongValue]/1.0f/[_fileModel.size longLongValue];
            if (progress >= 1)
            {
                _downFlag = 2;
                [_downBtn setTitle:@"立即阅读" forState:UIControlStateNormal];
            }
            else
            {
                _downFlag = 1;
                [_downBtn setTitle:@"继续下载" forState:UIControlStateNormal];
            }
        }
        _downBtn.hidden = NO; // 设置完状态后显示按钮
        
    } withGuideId:_guide_id];
}
// 点击下载按钮
- (void)pressDownBtn:(UIButton *)bth
{
    if((_downFlag == 0)||(_downFlag == 1)) // 未下载或者未完全下载
    {
        MRProgressOverlayView *progressView = [MRProgressOverlayView new];
        progressView.mode = MRProgressOverlayViewModeDeterminateCircular;
        progressView.progress = 0.6;
        [self.view addSubview:progressView];
        
        // 初始化断点续传模块
        FileDownLoad * fD = [[FileDownLoad alloc] initWithModel:_fileModel];
        
        [fD requestFromUrlreceiveDataBlock:^(FileDownLoad *fd) {
            
            CGFloat progress = [fd.model.downloadSize longLongValue]/1.0f/[fd.model.size longLongValue];
            NSLog(@"%@",[NSString stringWithFormat:@"%.2f%@",progress*100,@"%"]);
            
        } finished:^(FileDownLoad *fd) {
            
            NSLog(@"文件下载完成，地址：%@",fd.model.localPath);
            // 解压锦囊
            ZipArchive *zipFile = [[ZipArchive alloc]init];
            if([zipFile UnzipOpenFile:_fileModel.localPath])  // 解压成功
            {
                NSLog(@"YES");
                _downFlag = 2;
                [_downBtn setTitle:@"立即阅读" forState:UIControlStateNormal];
                [self savePackageData]; // 锦囊成功下载并解压后进行数据存储
            }
            else                                             // 解压失败
            {
                UIAlertView * alertV = [[UIAlertView alloc] initWithTitle:@"提示" message:@"下载锦囊失败，请尝试重新下载" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alertV show];
                alertV = nil;
            }
            
            // NSString *savePath = NSHomeDirectory();
            [zipFile UnzipFileTo:[NSHomeDirectory() stringByAppendingString:[NSString stringWithFormat:@"/Documents/unZipFile/%@",[_fileModel.file MD5Hash]]] overWrite:YES];
            [zipFile UnzipCloseFile];
            
        } failed:^(FileDownLoad *fd) {
            
            NSLog(@"下载失败");
            
        }];
    }
    else // 已下载
    {
        PackageReadViewController * readVC = [[PackageReadViewController alloc] init];
        readVC.fileUrl = _fileModel.file;
        [self.navigationController pushViewController:readVC animated:YES];
    }
}
// 成功下载锦囊并解压后进行数据存储
- (void)savePackageData
{
    PackageDB * packageModel = [PackageDB MR_createEntity];
    [packageModel updateWithPackageDetailModel:_packageDetailModel];
    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
    
}
// 蒙版上返回按钮
- (void)pressBackBtn:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
// 蒙版上分享按钮
- (void)pressShareBtn:(id)sender
{
    // 异步设置顶部图片
    NSBlockOperation *operation = [NSBlockOperation blockOperationWithBlock:^{
        NSString * imageUrl = [NSString stringWithFormat:@"%@/670_420.jpg?%@",_packageDetailModel.cover,_packageDetailModel.cover_updatetime];
        NSURL *url = [NSURL URLWithString:imageUrl];
        NSData *data = [NSData dataWithContentsOfURL:url]; // 下载
        UIImage *image = [UIImage imageWithData:data]; // NSData -> UIImage
        
        // 回到主线程
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            [UMSocialSnsService presentSnsIconSheetView:self
                                                 appKey:@"5604aa97e0f55ac707002370"
                                              shareText:_packageDetailModel.name
                                             shareImage:image
                                        shareToSnsNames:[NSArray arrayWithObjects:UMShareToSina,nil]
                                               delegate:self];
        }];
    }];
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [queue addOperation:operation];
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
            _imageM.backgroundColor =RGBR(255, 255, 255, 0.9);
        } completion:nil];
        isTop = NO;
        _titleLabel.hidden = NO; // 向上推动显示标题
    }
    
    // scrollView 回到原点
    if(!isTop && (scrollView.contentOffset.y < 44))
    {
        // 用动画过渡坐标的变化
        [UIView animateWithDuration:0.2 animations:^{
            //动画的内容
            _imageM.backgroundColor = RGBR(255, 255, 255, 0);
        } completion:nil];
        isTop = YES;
        _titleLabel.hidden = YES; // 返回顶部隐藏标题
    }
}
// 将出现
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [[self rdv_tabBarController] setTabBarHidden:YES animated:YES]; // 界面显示时隐藏底部tabBAr
}
// 将消失
-(void)viewWillDisappear:(BOOL)animated
{
    [self.rdv_tabBarController setTabBarHidden:NO animated:YES]; // 界面显示时隐藏底部tabBAr
    [super viewWillDisappear:YES];
}
// 跳转时如出现崩溃需要打开
//- (void)viewWillDisappear:(BOOL)animated
//{
//    _OTCoverV.tableView.delegate = nil;
//    _OTCoverV.tableView.dataSource = nil;
//}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 *  获取Zip文件下载后本地地址
 */
-(NSString *)localPath
{
    NSString * path = NSHomeDirectory();
    NSString * fileName = [_fileDownPath MD5Hash];
    path = [path stringByAppendingPathComponent:[NSString stringWithFormat:@"Documents/zip/%@",fileName]];
    return path;
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
