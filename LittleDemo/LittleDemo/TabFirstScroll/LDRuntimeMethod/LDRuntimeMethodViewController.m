//
//  LDRuntimeMethodViewController.m
//  LittleDemo
//
//  Created by Lynn on 2018/8/2.
//  Copyright © 2018年 Lynn. All rights reserved.
//

#import "LDRuntimeMethodViewController.h"
#import "LDRuntimeMethodImpController.h"

@interface LDRuntimeMethodViewController ()<UITableViewDelegate, UITableViewDataSource>

@end

@implementation LDRuntimeMethodViewController

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
    NSString *reuseID = @"LDRequestDependence";
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
    int type = [[mdict objectForKey:ActionValue] intValue];
    LDRuntimeMethodImpController *vc = [[LDRuntimeMethodImpController alloc] initWithType:type];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - initDataSouce
- (void)initDataSouce
{
    NSMutableDictionary *mdict1 = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                                   @"更改属性值",DescriptionString,
                                   @1, ActionValue,nil];
    NSMutableDictionary *mdict2 = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                                   @"动态添加属性",DescriptionString,
                                   @2, ActionValue,nil];
    NSMutableDictionary *mdict3 = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                                   @"动态添加方法",DescriptionString,
                                   @3, ActionValue,nil];
    NSMutableDictionary *mdict4 = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                                   @"交换方法的实现",DescriptionString,
                                   @4, ActionValue,nil];
    NSMutableDictionary *mdict5 = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                                   @"拦截并替换方法",DescriptionString,
                                   @5, ActionValue,nil];
    NSMutableDictionary *mdict6 = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                                   @"在方法上增加额外功能",DescriptionString,
                                   @6, ActionValue,nil];
    NSMutableDictionary *mdict7 = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                                   @"归档解档",DescriptionString,
                                   @7, ActionValue,nil];
    NSMutableDictionary *mdict8 = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                                   @"字典转模型",DescriptionString,
                                   @8, ActionValue,nil];
    
    self.dataSource = [[NSMutableArray alloc] initWithObjects:
                       mdict1, mdict2, mdict3, mdict4, mdict5, mdict6, mdict7, mdict8,
                       nil];
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
