//
//  PDMidViewController.m
//  LittleDemo
//
//  Created by Lynn on 2018/3/14.
//  Copyright © 2018年 Lynn. All rights reserved.
//

#import "PDMidViewController.h"
#import <objc/runtime.h>
#import "LDMyClass+Category2.h"
#import "LDMyClass+Category1.h"
#import "LDMyClass.h"
@interface PDMidViewController ()

@end

@implementation PDMidViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"弹出控制器";
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancleAction)];
    
    UIBarButtonItem *person = [[UIBarButtonItem alloc] init];
    Class class = [UIBarButtonItem class];
    Class a = object_getClass(person);
    Class b = object_getClass(class);//元类
    Class c = objc_getMetaClass(object_getClassName(person));//b与c一样都是元类
    BOOL aBOOL = class_isMetaClass(a);//NO
    BOOL bBOOL = class_isMetaClass(b);//YES
    
    
    LDMyClass *myclass = [[LDMyClass alloc] init];
    [myclass printName];
    myclass.name = @"category";
    NSLog(@"myclass.name - %@", myclass.name);
}

- (void)cancleAction
{
    [self dismissViewControllerAnimated:YES completion:nil];
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
