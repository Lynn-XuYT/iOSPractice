 //
//  DLScrollViewController.m
//  LittleDemo
//
//  Created by Lynn on 2018/3/12.
//  Copyright © 2018年 Lynn. All rights reserved.
//

#import "DLScrollViewController.h"
#import "LDScrollContainerViewController.h"
#import "DLToolMenu.h"

#define statusBarHeight [[UIApplication sharedApplication] statusBarFrame].size.height
@interface DLScrollViewController ()<DLToolMenuDelegate,UIScrollViewDelegate>

@property(nonatomic, strong) NSMutableArray *controllers;
@property(nonatomic, strong) UIScrollView *scrollView;
@property(nonatomic, strong) DLToolMenu *menu;
@end

@implementation DLScrollViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"滚动视图";
    // Do any additional setup after loading the view.
    
    self.controllers = [[NSMutableArray alloc] init];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    if (!self.menu)
    {
        CGFloat height =  ((UINavigationController *)self.parentViewController).navigationBar.frame.size.height;
        DLToolMenu *menu = [[DLToolMenu alloc] initWithFrame:CGRectMake(0, statusBarHeight + height, CGRectGetWidth(self.view.frame), 40)];
        menu.toolMenuDelegate = self;
        [self.view addSubview:menu];
        self.menu = menu;
        
        UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(menu.frame), CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame) - CGRectGetMaxY(menu.frame))];
        
        scrollView.pagingEnabled = YES;
        scrollView.delegate = self;
        [self.view addSubview:scrollView];
        self.scrollView = scrollView;
        
        NSArray *colorArray = @[[UIColor redColor],[UIColor yellowColor],[UIColor blueColor],[UIColor purpleColor],[UIColor cyanColor]];
        NSMutableArray *marray = [NSMutableArray array];
        for (int i = 0; i < 10; i++) {
            LDScrollContainerViewController *controller = [[LDScrollContainerViewController alloc] init];
            controller.index = i;
            controller.superController = self;
            controller.title = [NSString stringWithFormat:@"title - %d",i];
            controller.view.backgroundColor = colorArray[i % 5];
            controller.view.frame = CGRectMake( CGRectGetWidth(scrollView.frame) * i, 0,CGRectGetWidth(scrollView.frame), CGRectGetHeight(scrollView.frame));
            [scrollView addSubview:controller.view];
            [marray addObject:controller];
        }
        
        [self.controllers addObjectsFromArray:marray];
        self.scrollView.contentSize = CGSizeMake(CGRectGetWidth(self.view.frame) * marray.count, CGRectGetHeight(self.view.frame) - CGRectGetMaxY(menu.frame));
        self.menu.dataSource = marray;
    }
}


#pragma mark - DLToolMenuDelegate
- (void)selectAtIndex:(NSInteger)index
{
    [self.scrollView scrollRectToVisible:CGRectMake(CGRectGetWidth(self.scrollView.frame) * index, 0, CGRectGetWidth(self.scrollView.frame), CGRectGetHeight(self.scrollView.frame)) animated:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.menu moveAction:scrollView.contentOffset.x / (CGRectGetWidth(self.scrollView.frame)* self.controllers.count)];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    
}

@end
