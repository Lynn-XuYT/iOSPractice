//
//  LDScrollContainerViewController.m
//  LittleDemo
//
//  Created by Lynn on 2018/7/30.
//  Copyright © 2018年 Lynn. All rights reserved.
//

#import "LDScrollContainerViewController.h"
#import "LDRequestDependenceViewController.h"

#define DescriptionString   @"DescriptionString"
#define ActionClass         @"ActionClass"

@interface LDScrollContainerViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *dataSource;
@end

@implementation LDScrollContainerViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initDataSouce];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.frame];
    tableView.dataSource = self;
    tableView.delegate = self;
    [self.view addSubview:tableView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *reuseID = [NSString stringWithFormat:@"page%d",self.index];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuseID];
    }
    NSMutableDictionary *mdict = self.dataSource[indexPath.row];
    cell.textLabel.text = [mdict objectForKey:DescriptionString];
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSMutableDictionary *mdict = self.dataSource[indexPath.row];
    NSString *action = [mdict objectForKey:ActionClass];
    Class cls = NSClassFromString(action);
    UIViewController *controller = [[cls alloc] init];
    controller.hidesBottomBarWhenPushed = YES;
    [self.superController.navigationController pushViewController:controller animated:YES];
    
}

#pragma mark - initDataSouce
- (void)initDataSouce
{
    NSMutableDictionary *mdict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                                  @"解决网络请求的依赖关系",DescriptionString,
                                  @"LDRequestDependenceViewController",ActionClass,nil];
    self.dataSource = [[NSMutableArray alloc] initWithObjects:
                       mdict,
                       nil];
}

@end
