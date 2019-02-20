//
//  LDListViewController.m
//  LittleDemo
//
//  Created by lynn on 2019/2/19.
//  Copyright © 2019 Lynn. All rights reserved.
//

#import "LDListViewController.h"
#import "LDItemCell.h"
#import "LDListViewModel.h"

@interface LDListViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) LDListViewModel *listViewModel;
@end

@implementation LDListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    [tableView registerClass:[LDItemCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:tableView];
    
    self.listViewModel = [LDListViewModel new];
    
    [self.listViewModel loadAllDataCompleteBlock:^{
        [tableView reloadData];
    }];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.listViewModel.tweets.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LDItemViewModel *itemViewModel = self.listViewModel.tweets[indexPath.row];
    return itemViewModel.viewHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identify = @"cell";
    LDItemCell *cell = [tableView dequeueReusableCellWithIdentifier:identify forIndexPath:indexPath];
    if (!cell) {
        cell = [[LDItemCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
    }
    cell.viewModel = self.listViewModel.tweets[indexPath.row];
    return cell;
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
