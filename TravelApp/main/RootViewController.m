//
//  RootViewController.m
//  TravelApp
//
//  Created by qianfeng on 15/11/26.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "RootViewController.h"
#import "RecommendationViewController.h"
#import "DestinationViewController.h"
#import "PackageViewController.h"
#import "MyViewController.h"
#import "RDVTabBarItem.h"

@interface RootViewController ()

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 1.推荐
    RecommendationViewController * recommendationVC = [[RecommendationViewController alloc] init];
    UINavigationController * recommendationNav = [[UINavigationController alloc] initWithRootViewController:recommendationVC];
    
    // 2.目的地
    DestinationViewController * destinationVC = [[DestinationViewController alloc] init];
    UINavigationController * destinationNav = [[UINavigationController alloc] initWithRootViewController:destinationVC];
    
    // 3.锦囊
    PackageViewController * packageVC = [[PackageViewController alloc] init];
    UINavigationController * packageNav = [[UINavigationController alloc] initWithRootViewController:packageVC];
    
    // 4.游记
    MyViewController * myVC = [[MyViewController alloc] init];
    UINavigationController * myNav = [[UINavigationController alloc] initWithRootViewController:myVC];
    
    // 6.将子视图添加到tabBar中
    self.viewControllers = @[recommendationNav,destinationNav,packageNav,myNav];
    
    [self customizeTabBarForController:self];
}

- (void)customizeTabBarForController:(RDVTabBarController *)tabBarController
{
    // tabBar图片
    NSArray *tabBarItemImages = @[@"ic_1", @"ic_3", @"ic_4",@"ic_2"];
    
    // tabBar标题
    NSArray * titleArr = @[@"推荐",@"目的地",@"锦囊",@"我的"];
    
    
    // 让字体和图标颜色一起变
    NSDictionary *textAttributes_normal = nil;
    NSDictionary *textAttributes_selected = nil;
    
    // 设置字体颜色、字号
    if (NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_6_1)
    {
        textAttributes_normal = @{
                                  NSFontAttributeName: [UIFont systemFontOfSize:9],
                                  NSForegroundColorAttributeName: [UIColor colorWithRed:207/255.0 green:207/255.0 blue:207/255.0 alpha:1.0],
                                  };
        textAttributes_selected = @{
                                    NSFontAttributeName: [UIFont systemFontOfSize:9],
                                    NSForegroundColorAttributeName: [UIColor colorWithRed:253/255.0 green:139/255.0 blue:8/255.0 alpha:1.0],
                                    };
    }
    
    // 设置tabBar上按钮“选中”和“非选中”时的图片
    NSInteger index = 0;
    for (RDVTabBarItem *item in [[tabBarController tabBar] items])
    {
        item.unselectedTitleAttributes = textAttributes_normal;
        item.selectedTitleAttributes = textAttributes_selected;
        
        UIImage *selectedimage = [UIImage imageNamed:[NSString stringWithFormat:@"%@_press",[tabBarItemImages objectAtIndex:index]]];
        UIImage *unselectedimage = [UIImage imageNamed:[tabBarItemImages objectAtIndex:index]];
        
        [item setFinishedSelectedImage:selectedimage withFinishedUnselectedImage:unselectedimage];
        item.title = titleArr[index];
        index++;
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
