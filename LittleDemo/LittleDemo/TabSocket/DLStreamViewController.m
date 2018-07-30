//
//  DLStreamViewController.m
//  LittleDemo
//
//  Created by Lynn on 2018/5/25.
//  Copyright © 2018年 Lynn. All rights reserved.
//

#import "DLStreamViewController.h"
#import "DLStreamManager.h"

@interface DLStreamViewController ()

@end

@implementation DLStreamViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];

    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(40, 140, 40, 40)];
    btn.backgroundColor = [UIColor redColor];
    [btn addTarget:self action:@selector(ontouched) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:btn];
    
}
- (void)ontouched
{
    
    [DLStreamManager shareInstance] ;
//    NSString * str = @"hahahh";
//    NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
//    [_ouput write:data.bytes maxLength:data.length];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
