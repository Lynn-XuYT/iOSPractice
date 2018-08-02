//
//  ViewController.m
//  LittleDemo
//
//  Created by Lynn on 2018/3/8.
//  Copyright © 2018年 Lynn. All rights reserved.
//

#import "ViewController.h"
#import "LDCommonCell.h"
#import "LDDownloadAndUploadViewController.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, assign) int testInt;
@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.title = @"上传下载";
    // Do any additional setup after loading the view, typically from a nib.
    self.dataSource = [self getDataSource];
    
    self.view.backgroundColor = [UIColor whiteColor];
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.frame];
//    tableView.backgroundColor = [UIColor yellowColor];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:tableView];
    
    UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"test.png"]];
    imgView.frame = CGRectMake(100, 100, 100, 100);
    [tableView addSubview:imgView];
    
    NSString *str = nil;
    NSLog(@"kkkkk ------ %s", str.UTF8String);
    
    __block int h = -1;
    self.testInt = 2;
    NSMutableArray *arry = [NSMutableArray new];
    void (^blk)(void) = ^{
        NSLog(@"testInt = %d",self.testInt);
        [arry addObject:@(1)];
        NSLog(@"[blk] array count = %d", arry.count);
        h = -2;
    };
    
    self.testInt = 4;
    [arry addObject:@(2)];
    blk();
    NSLog(@"array count = %d", arry.count);
    NSLog(@"h = %d", h);
    
    __block int a = 0;
    NSLog(@"定义前：%p", &a);         //栈区
    void (^foo)(void) = ^{
        a = 1;
        NSLog(@"block内部：%p", &a);    //堆区
    };
    NSLog(@"定义后：%p", &a);         //堆区
    foo();
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LDCommonCell *cell = [tableView dequeueReusableCellWithIdentifier:@"commoncell"];
    
    if (!cell)
    {
        cell = [[LDCommonCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"commoncell"];
    }
    NSMutableDictionary *dict = self.dataSource[indexPath.row];
    [cell setData:[dict objectForKey:DescriptionString]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSMutableDictionary *dict = self.dataSource[indexPath.row];
    Class cls = [dict objectForKey:ActionClass];
    UIViewController * vc = [[cls alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
    
}

#pragma mark - datasource
- (NSMutableArray *)getDataSource
{
    NSMutableArray *marray = [NSMutableArray array];
    NSMutableDictionary *mdict = [NSMutableDictionary dictionary];
    [mdict setObject:@"----- $ 上传下载 $ -----" forKey:DescriptionString];
    [mdict setObject:[LDDownloadAndUploadViewController class] forKey:ActionClass];
    [marray addObject:mdict];
    return marray;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
