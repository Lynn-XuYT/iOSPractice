//
//  LDMainTabBarViewController.m
//  LittleDemo
//
//  Created by Lynn on 2018/3/12.
//  Copyright © 2018年 Lynn. All rights reserved.
//

#import "LDMainTabBarViewController.h"
#import "LDTabBarView.h"
#import "ViewController.h"
#import "LDScrollViewController.h"
#import "LDTabBarItem.h"
#import "PDMidViewController.h"
#import "LDTestSocketViewController.h"
#import "LittleDemo-Swift.h"
#import "LDCutomerTabBar.h"

@interface LDMainTabBarViewController ()<UITabBarControllerDelegate, LDTabBarViewDelegate>
@property (nonatomic, strong) LDTabBarView *customTabBarView;
@end

@implementation LDMainTabBarViewController

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.delegate = self;
    }
    return self;
}

- (void)loadView
{
    [super loadView];
    LDCutomerTabBar *tabBar = [LDCutomerTabBar new];
    [self setValue:tabBar forKey:@"tabBar"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.customTabBarView = [[LDTabBarView alloc] initWithFrame:self.tabBar.bounds];
    self.customTabBarView.delegate = self;
    self.customTabBarView.backgroundColor = [UIColor colorWithRed:249/ 255.0 green:249/ 255.0 blue:249/ 255.0 alpha:1];
    [self addSubViewControllers];

}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.tabBar addSubview:self.customTabBarView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)addSubViewControllers
{
    LDBaseNavigationController *vc1 = [[LDBaseNavigationController alloc] initWithRootViewController:[[LDScrollViewController alloc] init]];
    LDBaseNavigationController *vc2 = [[LDBaseNavigationController alloc] initWithRootViewController:[[ViewController alloc] init]];
    LDBaseNavigationController *vc3 = [[LDBaseNavigationController alloc] initWithRootViewController:[[ViewController alloc] init]];
    LDBaseNavigationController *vc4 = [[LDBaseNavigationController alloc] initWithRootViewController:[[LDTestSocketViewController alloc] init]];
    LDBaseNavigationController *vc5 = [[LDBaseNavigationController alloc] initWithRootViewController:[[LDFifthSwiftViewController alloc] init]];
    [self setViewControllers:@[vc1,vc2,vc3,vc4,vc5]];
    
    LDTabBarItem *item1 = [[LDTabBarItem alloc] initWithTitle:@"" imageNameNormal:@"icon1Normal.png" imageNameSelected:@"icon1.png"];
    LDTabBarItem *item2 = [[LDTabBarItem alloc] initWithTitle:@"" imageNameNormal:@"icon2Normal.png" imageNameSelected:@"icon2.png"];
    LDTabBarItem *item3 = [[LDTabBarItem alloc] initWithTitle:@"" imageNameNormal:@"iconbig.png" imageNameSelected:@"iconbig.png"];
    LDTabBarItem *item4 = [[LDTabBarItem alloc] initWithTitle:@"" imageNameNormal:@"icon3Normal.png" imageNameSelected:@"icon3.png"];
    LDTabBarItem *item5 = [[LDTabBarItem alloc] initWithTitle:@"" imageNameNormal:@"icon4Normal.png" imageNameSelected:@"icon4.png"];
    
    [self.customTabBarView setTabBarItems:@[item1,item2,item3,item4,item5]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITabBarControllerDelegate
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
//    viewController.title = @"test";
}

#pragma mark - DLTabBarViewDelegate
- (void)selectedAtIndex:(NSInteger)index
{
    if (index == 2)
    {
        LDBaseNavigationController *nav = [[LDBaseNavigationController alloc] initWithRootViewController:[PDMidViewController new]];
        [self presentViewController:nav animated:YES completion:nil];
    }
    else
    {
        [self setSelectedViewController:self.viewControllers[index]];
    }
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
