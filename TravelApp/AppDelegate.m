//
//  AppDelegate.m
//  TravelApp
//
//  Created by qianfeng on 15/11/26.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "AppDelegate.h"
#import "RootViewController.h"
#import "IntroductionViewController.h" // 引导页

@interface AppDelegate ()<UIScrollViewDelegate>

@property (nonatomic, strong) IntroductionViewController * introductionView;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    [_window makeKeyAndVisible];
    
    // 引导页显示判断
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"everLaunched"])
    {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"everLaunched"];
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"firstLaunch"];
        
        // 引导页初始化
        NSArray *coverImageNames = @[@"1", @"2", @"3",@"4",@"5"];
        self.introductionView = [[IntroductionViewController alloc] initWithCoverImageNames:coverImageNames backgroundImageNames:nil];
        [self.window addSubview:self.introductionView.view];
        
        __weak AppDelegate *weakSelf = self;
        self.introductionView.didSelectedEnter = ^() {
            [weakSelf.introductionView.view removeFromSuperview];
            weakSelf.introductionView = nil;
            [weakSelf goMainPageWithApplication:application];
        };
    }
    else
    {
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"firstLaunch"];
        [self goMainPageWithApplication:application];
    }
    
    // 数据库初始化
//    [MagicalRecord setupCoreDataStackWithStoreNamed:@"MyDatabase.sqlite"];
    
//    // 注册app推送服务
//    if ([[[UIDevice currentDevice] systemVersion] floatValue] < 8.0)
//    {
//        [application registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge|UIRemoteNotificationTypeSound|UIRemoteNotificationTypeAlert)];
//    }
//    else
//    {
//        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:(UIRemoteNotificationTypeBadge|UIRemoteNotificationTypeSound|UIRemoteNotificationTypeAlert) categories:nil];
//        [application registerUserNotificationSettings:settings];
//        [application registerForRemoteNotifications];
//    }

    return YES;
}
// 进入主页
- (void)goMainPageWithApplication:(UIApplication *)application
{
    // 设置导航栏title颜色
    NSDictionary * textA = @{
                             NSFontAttributeName : [UIFont systemFontOfSize:18],
                             NSForegroundColorAttributeName : [UIColor whiteColor],
                             };
    [[UINavigationBar appearance] setTitleTextAttributes:textA];
    // 设置所有导航背景颜色 [UIColor colorWithRed:23/255.0 green:27/255.0 blue:38/255.0 alpha:0]
    [[UINavigationBar appearance] setBarTintColor:RGBR(255, 255, 255, 0)];
    // 1.设置状态栏字体颜色
    [application setStatusBarStyle:UIStatusBarStyleLightContent];
    // 2. 将Info.plist中添加一项 View controller-based status bar appearance 属性设为NO
    
    RootViewController * rootVC = [[RootViewController alloc] init];
    self.window.rootViewController = rootVC;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
