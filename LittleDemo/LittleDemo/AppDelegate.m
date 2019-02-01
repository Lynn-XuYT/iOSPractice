//
//  AppDelegate.m
//  LittleDemo
//
//  Created by Lynn on 2018/3/8.
//  Copyright © 2018年 Lynn. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "LDMainTabBarViewController.h"
#import "LDScrollViewController.h"
#import "FPSDisplay.h"
#import "LittleDemo-Swift.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
     [FPSDisplay shareFPSDisplay];
    LDMainTabBarViewController *tabBarController = [[LDMainTabBarViewController alloc] init];
    self.window.rootViewController = tabBarController;
    //显示窗口
    [self.window makeKeyAndVisible];
    
//    //第三方应用打开本应用启动
//    if(launchOptions[UIApplicationLaunchOptionsURLKey] != nil){
//        [self application:application handleOpenURL:launchOptions[UIApplicationLaunchOptionsURLKey]];
//    }
    return YES;
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options
{
    NSLog(@"URL scheme:%@", [url scheme]);
    //参数
    NSLog(@"URL host:%@", [url host]);
    NSLog(@"URL query:%@", [url query]);
    
    
    UIAlertView *alertView=[[UIAlertView alloc] initWithTitle:[url host] message:[url query] delegate:self cancelButtonTitle:nil otherButtonTitles:@"分享完成", nil];
    
    [alertView show];
    
    NSURLComponents *urlComponents = [NSURLComponents componentsWithURL:url resolvingAgainstBaseURL:NO];
    //url中参数的key value
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    for (NSURLQueryItem *item in urlComponents.queryItems) {
        [parameter setValue:item.value forKey:item.name];
    }
    return YES;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    //返回URL scheme = wsl123456的主应用
    NSURL * url = [NSURL URLWithString:@"openurlfirst://success"];
    [[UIApplication sharedApplication] openURL:url options:nil completionHandler:^(BOOL success) {
    }];
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
