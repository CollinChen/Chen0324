//
//  AppDelegate.m
//  InterestedTourist
//
//  Created by qianfeng on 15/11/8.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "AppDelegate.h"

//4个视图控制器头文件
#import "ChoiceViewController.h"
#import "DestinationViewController.h"
#import "SpecialPriceViewController.h"
#import "MineViewController.h"

#import "MainViewController.h"


@interface AppDelegate ()
{
    ChoiceViewController * _choiceVC;
    DestinationViewController * _desVC;
    SpecialPriceViewController * _SpeVC;
    MineViewController * _MineVC;
}
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [self createWindow];
    
    [self createViewController];
    
    
    
    return YES;
}

- (void)setStatusBarColor{
    
    [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleLightContent];
    
}


//创建视图控制器
- (void)createViewController{
    
    //精选视图控制器
    _choiceVC = [[ChoiceViewController alloc]init];
    UINavigationController * choiceNavc = [[UINavigationController alloc]initWithRootViewController:_choiceVC];
    UITabBarItem * choiceItem = [[UITabBarItem alloc]initWithTitle:nil image:[UIImage imageNamed:@"homePage"] selectedImage:[UIImage imageNamed:@"homePage1"]];
    choiceNavc.tabBarItem = choiceItem;
    //目的地视图控制器
    _desVC = [[DestinationViewController alloc]init];
    UINavigationController * desNavc = [[UINavigationController alloc]initWithRootViewController:_desVC];
    UITabBarItem * desItems = [[UITabBarItem alloc]initWithTitle:nil image:[UIImage imageNamed:@"discover"] selectedImage:[UIImage imageNamed:@"discover1"]];
    desNavc.tabBarItem = desItems;
    //抢特价视图控制器
    _SpeVC = [[SpecialPriceViewController alloc]init];
    UINavigationController * SpeNavc = [[UINavigationController alloc]initWithRootViewController:_SpeVC];
    UITabBarItem * SpeItems = [[UITabBarItem alloc]initWithTitle:nil image:[UIImage imageNamed:@"message"] selectedImage:[UIImage imageNamed:@"message1"]];
    SpeNavc.tabBarItem = SpeItems;
    //我的视图控制器
    _MineVC = [[MineViewController alloc]init];
    UINavigationController * MineNavc = [[UINavigationController alloc]initWithRootViewController:_MineVC];
    UITabBarItem * MineItem = [[UITabBarItem alloc]initWithTitle:nil image:[UIImage imageNamed:@"meTarItem"] selectedImage:[UIImage imageNamed:@"meTarItem1"]];
    MineNavc.tabBarItem = MineItem;
    
    //创建TabBarController
    
    MainViewController * TabBar = [[MainViewController alloc]init];
    TabBar.viewControllers = @[choiceNavc,desNavc,SpeNavc,MineNavc];
    
    
    
    
    //设置窗口的根视图控制器为TabBar
    self.window.rootViewController = TabBar;
    
    
    
}


//创建窗口
- (void)createWindow{
    
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    
    [self setStatusBarColor];
    
    
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
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
