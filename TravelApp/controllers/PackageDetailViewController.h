//
//  PackageDetailViewController.h
//  TravelApp
//
//  Created by qianfeng on 15/12/17.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PackageDetailViewController : UIViewController
/**接收锦囊ID*/
@property (nonatomic,copy) NSString * guide_id;
/**
 *  接受传递过来的锦囊下载地址
 */
@property (nonatomic,strong) NSString * fileDownPath;

@end
