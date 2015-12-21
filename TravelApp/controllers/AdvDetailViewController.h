//
//  AdvDetailViewController.h
//  TravelApp
//
//  Created by qianfeng on 15/11/30.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomWebView.h"
#import "RDVTabBarController.h"



@interface AdvDetailViewController : UIViewController<CustomWebViewDelegate>

@property(nonatomic,copy) NSString * newsURL;
/**
 *  存放下载操作的队列
 */
@property (nonatomic, strong) NSOperationQueue *queue;
/**
 *  自定义WebView
 */
@property (nonatomic, strong) CustomWebView * webView;
/**
 *  顶部蒙版
 */
@property (nonatomic, strong) UIImageView * imageV;
/**
 *  蒙版中心的图片
 */
@property (nonatomic,strong) UIImageView * centerImage;
@end
