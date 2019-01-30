//
//  DLMainTabBarViewController.m
//  LittleDemo
//
//  Created by Lynn on 2018/3/12.
//  Copyright © 2018年 Lynn. All rights reserved.
//

#import "DLMainTabBarViewController.h"
#import "DLTabBarView.h"
#import "ViewController.h"
#import "DLScrollViewController.h"
#import "DLTabBarItem.h"
#import "PDMidViewController.h"
#import "DLTestSocketViewController.h"
#import "LittleDemo-Swift.h"

@interface DLMainTabBarViewController ()<UITabBarControllerDelegate, DLTabBarViewDelegate>
@property (nonatomic, strong) DLTabBarView *customTabBarView;
@end

@implementation DLMainTabBarViewController

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.delegate = self;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.customTabBarView = [[DLTabBarView alloc] initWithFrame:self.tabBar.bounds];
    self.customTabBarView.delegate = self;
    self.customTabBarView.backgroundColor = [UIColor colorWithRed:249/ 255.0 green:249/ 255.0 blue:249/ 255.0 alpha:1];
    [self addSubViewControllers];

}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    // 删除自动创建的tabBarButton
    for (UIView *view in self.tabBar.subviews) {
        // 打印tabBar上所有控件
//        NSLog(@"%@",self.tabBar.subviews);
        // 移除tabBar上所有的子控件
        [view removeFromSuperview];
    }
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
//    UINavigationController *vc1 = [[UINavigationController alloc] initWithRootViewController:[[DLScrollViewController alloc] initWithTittle:nil/*@"主页"*/ imageName:@"icon1.png"]];
//    UINavigationController *vc2 = [[UINavigationController alloc] initWithRootViewController:[[ViewController alloc] initWithTittle:nil/*@"title"*/ imageName:@"icon2.png"]];
//    UINavigationController *vc3 = [[UINavigationController alloc] initWithRootViewController:[[ViewController alloc] initWithTittle:nil/*@"我的"*/ imageName:@"icon3.png"]];
//    UINavigationController *vc3 = [[UINavigationController alloc] initWithRootViewController:[[ViewController alloc] initWithTittle:nil/*@"我的"*/ imageName:@"icon3.png"]];
    UINavigationController *vc1 = [[UINavigationController alloc] initWithRootViewController:[[DLScrollViewController alloc] init]];
    UINavigationController *vc2 = [[UINavigationController alloc] initWithRootViewController:[[ViewController alloc] init]];
    UINavigationController *vc3 = [[UINavigationController alloc] initWithRootViewController:[[ViewController alloc] init]];
    UINavigationController *vc4 = [[UINavigationController alloc] initWithRootViewController:[[DLTestSocketViewController alloc] init]];
    UINavigationController *vc5 = [[UINavigationController alloc] initWithRootViewController:[[LDFifthSwiftViewController alloc] init]];
    [self setViewControllers:@[vc1,vc2,vc3,vc4,vc5]];
    
//    CGFloat width = CGRectGetWidth(self.customTabBarView.frame)/ 5;
//    CGFloat height = CGRectGetHeight(self.customTabBarView.frame);
//    CGRect frame1 = CGRectMake(0, 0, width, height);
    DLTabBarItem *item1 = [[DLTabBarItem alloc] initWithTitle:@"" imageNameNormal:@"icon1Normal.png" imageNameSelected:@"icon1.png"];
//    CGRect frame2 = CGRectMake(width, 0, width, height);
    DLTabBarItem *item2 = [[DLTabBarItem alloc] initWithTitle:@"" imageNameNormal:@"icon2Normal.png" imageNameSelected:@"icon2.png"];
//    CGRect frame3 = CGRectMake(width * 2, 0, width, height);
    DLTabBarItem *item3 = [[DLTabBarItem alloc] initWithTitle:@"" imageNameNormal:@"iconbig.png" imageNameSelected:@"iconbig.png"];
//    CGRect frame4 = CGRectMake(width * 3, 0, width, height);
    DLTabBarItem *item4 = [[DLTabBarItem alloc] initWithTitle:@"" imageNameNormal:@"icon3Normal.png" imageNameSelected:@"icon3.png"];
//    CGRect frame5 = CGRectMake(width * 4, 0, width, height);
    DLTabBarItem *item5 = [[DLTabBarItem alloc] initWithTitle:@"" imageNameNormal:@"icon4Normal.png" imageNameSelected:@"icon4.png"];
    
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
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:[PDMidViewController new]];
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
