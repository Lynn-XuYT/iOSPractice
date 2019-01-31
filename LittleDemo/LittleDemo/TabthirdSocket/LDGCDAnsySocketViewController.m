//
//  LDGCDAnsySocketViewController.m
//  LittleDemo
//
//  Created by Lynn on 2018/5/25.
//  Copyright © 2018年 Lynn. All rights reserved.
//

#import "LDGCDAnsySocketViewController.h"
#import "LDSocketManager.h"

@interface LDGCDAnsySocketViewController ()
@property (nonatomic, strong) UITextView *textView;
@end

@implementation LDGCDAnsySocketViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
//    [[LDSocketManager shareInstance] socketConnectHost:@"10.73.27.63" onPort:8890];
    [[LDSocketManager shareInstance] socketConnectHost:@"10.73.50.55" onPort:8890];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(statusMsg:) name:@"statusMsg" object:nil];
    
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(10, 60, SCREEN_WIDTH - 20, 60)];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 30, CGRectGetHeight(bgView.frame))];
    label.text = @"IP : ";
    label.textColor = [UIColor blueColor];
    [bgView addSubview:label];
    
    
    UITextField *textField= [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(label.frame), 0, CGRectGetWidth(bgView.frame) - CGRectGetWidth(label.frame), CGRectGetHeight(bgView.frame))];
    textField.delegate = self;
    textField.textColor = [UIColor yellowColor];
    textField.enabled = YES;
    [bgView addSubview:textField];
    textField.text = @"10.73.27.52";
    
    [self.view addSubview:bgView];
    
    
    self.textView = [[UITextView alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(bgView.frame) + 10, CGRectGetWidth(bgView.frame), SCREEN_HEIGHT - CGRectGetMaxY(bgView.frame) - 30)];
    self.textView .textColor = [UIColor blackColor];
    self.textView .layer.borderWidth = 0.5;
    [self.view addSubview:self.textView];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[LDSocketManager shareInstance] cutOffSocket];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)statusMsg:(id)noti
{
    NSNotification *notification = (NSNotification *)noti;
    NSString *msg = [notification.object objectForKey:@"key"];
    if (self.textView.text == 0) {
        self.textView.text = [NSString stringWithFormat:@"%@\n",msg];
    }
    else
    {
        self.textView.text = [NSString stringWithFormat:@"%@\n%@",self.textView.text,msg];
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
