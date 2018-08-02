//
//  LDBaseViewController.m
//  LittleDemo
//
//  Created by Lynn on 2018/8/2.
//  Copyright © 2018年 Lynn. All rights reserved.
//

#import "LDBaseViewController.h"

@interface LDBaseViewController ()

@end

@implementation LDBaseViewController

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
    
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - initDataSouce
- (void)initDataSouce
{
    
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
