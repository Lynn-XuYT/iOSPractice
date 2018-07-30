//
//  AppDelegate.m
//  LittleDemo
//
//  Created by Lynn on 2018/3/8.
//  Copyright © 2018年 Lynn. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "DLMainTabBarViewController.h"
#import "DLScrollViewController.h"
#import "FPSDisplay.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
     [FPSDisplay shareFPSDisplay];
//    //创建窗口对象
//    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
//    //创建窗口的根控制器，并且赋值
//    UINavigationController *rootVc = [[UINavigationController alloc] initWithRootViewController:[[ViewController alloc]init]];
//    self.window.rootViewController = rootVc;
//    //显示窗口
//    [self.window makeKeyAndVisible];
    
//    UINavigationController *vc1 = [[UINavigationController alloc] initWithRootViewController:[[DLScrollViewController alloc] initWithTittle:nil/*@"主页"*/ imageName:@"icon1.png"]];
//    UINavigationController *vc2 = [[UINavigationController alloc] initWithRootViewController:[[ViewController alloc] initWithTittle:nil/*@"title"*/ imageName:@"icon2.png"]];
//    UINavigationController *vc3 = [[UINavigationController alloc] initWithRootViewController:[[ViewController alloc] initWithTittle:nil/*@"我的"*/ imageName:@"icon3.png"]];
    DLMainTabBarViewController *tabBarController = [[DLMainTabBarViewController alloc] init];
//    [tabBarController setViewControllers:@[vc1,vc2,vc3]];
    self.window.rootViewController = tabBarController;
    //显示窗口
    [self.window makeKeyAndVisible];
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
