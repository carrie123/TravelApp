//
//  OTCover.h
//  OTMediumCover
//
//  Created by yechunxiao on 14-9-21.
//  Copyright (c) 2014年 yechunxiao. All rights reserved.
//

#import <UIKit/UIKit.h>
//#define OTCoverViewHeight 200

@interface OTCover : UIView

@property (nonatomic, strong) UIScrollView* scrollView;
@property (nonatomic, strong) UIView* scrollContentView;
@property (nonatomic, strong) UIImageView* headerImageView;
@property (nonatomic, strong) UITableView* tableView;
/**
 *  显示文件大小和下载次数信息
 */
@property (nonatomic, strong) UILabel * textLabel;

- (OTCover*)initWithTableViewWithHeaderImage:(UIImage*)headerImage withOTCoverHeight:(CGFloat)height;
- (OTCover*)initWithScrollViewWithHeaderImage:(UIImage*)headerImage withOTCoverHeight:(CGFloat)height withScrollContentViewHeight:(CGFloat)height;
- (void)setHeaderImage:(UIImage *)headerImage;

@end

@interface UIImage (Blur)
-(UIImage *)boxblurImageWithBlur:(CGFloat)blur;
@end

// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com
