//
//  LDRequestDependenceViewController.m
//  LittleDemo
//
//  Created by Lynn on 2018/7/30.
//  Copyright © 2018年 Lynn. All rights reserved.
//

#import "LDRequestDependenceViewController.h"


@interface LDRequestDependenceViewController ()<UITableViewDelegate, UITableViewDataSource>

@end

@implementation LDRequestDependenceViewController

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
//    NSMutableDictionary *mdict = self.dataSource[indexPath.row];
//    int index = [mdict objectForKey:ActionClass];
    switch (indexPath.row) {
        case 0:
            [self testOperation];
            break;
        case 1:
            [self testOnCallback];
            break;
        case 2:
            [self testDispatchGroup];
            break;
        case 3:
            [self testDispatchBattier];
            break;
        case 4:
             [self testDispatchSemaphore];
            break;
        default:
            break;
    }
}

#pragma mark -

- (void)getOperation:(NSString *)tag
{
    for (int i = 0; i < 2; i++) {
        [NSThread sleepForTimeInterval:2]; // 模拟耗时操作
        NSLog(@"%@---%@", tag, [NSThread currentThread]); // 打印当前线程
    }
}

- (void)testOperation
{
    // 1.创建队列
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    // 2.设置最大并发操作数
//    queue.maxConcurrentOperationCount = 1;
    // 3.添加操作
    // 使用 NSInvocationOperation 创建操作1
    NSInvocationOperation *op1 = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(getOperation:) object:@"op1"];
    
    // 使用 NSInvocationOperation 创建操作2
    NSInvocationOperation *op2 = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(getOperation:) object:@"op2"];
    
    // 使用 NSBlockOperation 创建操作3
    NSBlockOperation *op3 = [NSBlockOperation blockOperationWithBlock:^{
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2]; // 模拟耗时操作
            NSLog(@"3---%@", [NSThread currentThread]); // 打印当前线程
        }
    }];
    [op3 addExecutionBlock:^{
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2]; // 模拟耗时操作
            NSLog(@"4---%@", [NSThread currentThread]); // 打印当前线程
        }
    }];
    
    [op2 addDependency:op1];
    [op3 addDependency:op2];
    
    
    [queue addOperation:op1];
    [queue addOperation:op2];
    [queue addOperation:op3];
}


- (void)testOnCallback
{
    NSString *urlStr = [NSString stringWithFormat:@"http://%@:8888/get_operation",IP_ADDRESS]; ;
    
    urlStr = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *url = [NSURL URLWithString:urlStr];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURLSessionDataTask *sessionDataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (!data || data.length == 0){
            return;
        }
//        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingMutableLeaves) error:nil];
//        NSString *msg = [dict objectForKey:@"msg"];
//        NSString *sleep = [dict objectForKey:@"sleep"];
        NSLog(@"block中进行下一步, %@",[NSThread currentThread]);
        [self testOperation];
    }];
    [sessionDataTask resume];
    
}

- (void)testDispatchGroup
{
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_group_t group = dispatch_group_create();
    dispatch_group_async(group, queue, ^{
        NSLog(@"group1 -----");
        [self getOperation:@"group1 -----"];
    });
    dispatch_group_async(group, queue, ^{
        NSLog(@"group2 -----");
        [self getOperation:@"group2 -----"];
    });
    
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        NSLog(@"group3 ----- 最后执行");
        [self getOperation:@"group3 ----- 最后执行"];
    });
}

- (void)testDispatchBattier
{
    dispatch_queue_t queue = dispatch_queue_create("test", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(queue, ^{
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2]; // 模拟耗时操作
            NSLog(@"1---%@", [NSThread currentThread]); // 打印当前线程
        }
    });
    dispatch_async(queue, ^{
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2]; // 模拟耗时操作
            NSLog(@"2---%@", [NSThread currentThread]); // 打印当前线程
        }
    });
    dispatch_async(queue, ^{
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2]; // 模拟耗时操作
            NSLog(@"3---%@", [NSThread currentThread]); // 打印当前线程
        }
    });
    
    dispatch_barrier_async(queue, ^{
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2]; // 模拟耗时操作
            NSLog(@"4 - barrier ---%@", [NSThread currentThread]); // 打印当前线程
        }
    });
    
    /*
     dispatch_barrier_sync(queue, ^{
     for (int i = 0; i < 2; i++) {
     [NSThread sleepForTimeInterval:2]; // 模拟耗时操作
     NSLog(@"4 - barrier ---%@", [NSThread currentThread]); // 打印当前线程
     }
     });
     */
    
    for (int i = 0; i < 2; i++) {
        [NSThread sleepForTimeInterval:2]; // 模拟耗时操作
        NSLog(@"4 - 1---%@", [NSThread currentThread]); // 打印当前线程
    }
    
    dispatch_async(queue, ^{
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2]; // 模拟耗时操作
            NSLog(@"5---%@", [NSThread currentThread]); // 打印当前线程
        }
    });
    
}

- (void)testDispatchSemaphore
{
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        for (int i = 0; i < 2; i++) {
//            [NSThread sleepForTimeInterval:2]; // 模拟耗时操作
//            NSLog(@"1---%@", [NSThread currentThread]); // 打印当前线程
//        }
//        NSLog(@"1 --- END %@", [NSThread currentThread]); // 打印当前线程
//        dispatch_semaphore_signal(semaphore);
//    });
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2]; // 模拟耗时操作
            NSLog(@"2---%@", [NSThread currentThread]); // 打印当前线程
        }
    });
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2]; // 模拟耗时操作
            NSLog(@"1---%@", [NSThread currentThread]); // 打印当前线程
        }
        NSLog(@"1 --- END %@", [NSThread currentThread]); // 打印当前线程
        dispatch_semaphore_signal(semaphore);
    });
}

#pragma mark - initDataSouce
- (void)initDataSouce
{
    NSMutableDictionary *mdict1 = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                                  @"NSOperation 操作依赖和优先级",DescriptionString,
                                  @1, ActionClass,nil];
    NSMutableDictionary *mdict2 = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                                   @"上一个网络请求的响应回调中进行",DescriptionString,
                                   @2, ActionClass,nil];
    NSMutableDictionary *mdict3 = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                                   @"线程同步 - 组队列(dispatch_group)",DescriptionString,
                                   @3, ActionClass,nil];
    NSMutableDictionary *mdict4 = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                                   @"线程同步 - 任务阻塞(dispatch_barrier)",DescriptionString,
                                   @4, ActionClass,nil];
    NSMutableDictionary *mdict5 = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                                   @"线程同步 - 信号量机制(dispatch_semaphore)",DescriptionString,
                                   @5, ActionClass,nil];
    
    self.dataSource = [[NSMutableArray alloc] initWithObjects:
                       mdict1, mdict2, mdict3, mdict4, mdict5,
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
