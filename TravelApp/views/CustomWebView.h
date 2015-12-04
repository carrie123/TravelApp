//
//  CustomWebView.h
//  TravelApp
//
//  Created by qianfeng on 15/11/30.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CustomWebViewDelegate <NSObject>

- (void)TapOnWebView;

@end

@interface CustomWebView : UIWebView <UIGestureRecognizerDelegate>

@property (nonatomic,assign) id <CustomWebViewDelegate> myDelegate;

@end
