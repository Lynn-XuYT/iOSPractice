//
//  LDFileListViewController.m
//  LittleDemo
//
//  Created by Lynn on 2018/3/11.
//  Copyright © 2018年 Lynn. All rights reserved.
//

#import "LDFileListViewController.h"
#define IP_ADDRESS @"192.168.0.184"

@interface LDFileListViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;
@end

@implementation LDFileListViewController


- (void)loadView
{
    [super loadView];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.frame];
    //    tableView.backgroundColor = [UIColor yellowColor];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:tableView];
    self.tableView = tableView;
    self.dataSource = [NSMutableArray new];
    [self downloadFileList];
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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TableViewCell"];

    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"TableViewCell"];
    }
    cell.textLabel.text = self.dataSource[indexPath.row];;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self downloadFile:self.dataSource[indexPath.row]];
//    Class cls = [dict objectForKey:ActionClass];
//    [self.navigationController pushViewController:[[cls alloc] init] animated:YES];
}

- (void)downloadFileList
{
    
    NSString *urlStr = [NSString stringWithFormat:@"http://%@:8888/get_fileList",IP_ADDRESS]; ;
    
    urlStr = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *url = [NSURL URLWithString:urlStr];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURLSessionDataTask *sessionDataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSLog(@"从服务器获取到数据");
        /*
         对从服务器获取到的数据data进行相应的处理：
         */
        if (!data || data.length == 0)
        {
            
            return;
        }
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingMutableLeaves) error:nil];
        NSArray *array = [dict objectForKey:@"msg"];
        for (NSString *str in array) {
            NSString *strTmp = [str substringFromIndex:2];
            [self.dataSource addObject:strTmp];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
        NSLog(@"%@",dict);
    }];
    // 最后一步，执行任务（resume也是继续执行）:
    [sessionDataTask resume];
    
}

- (void)downloadFile:(NSString *)filename
{
    
    NSString *urlStr = [NSString stringWithFormat:@"http://%@:8888/get_file?fname=%@",IP_ADDRESS,filename];
    
    urlStr = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *url = [NSURL URLWithString:urlStr];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURLSessionDownloadTask *downloadTask = [session downloadTaskWithRequest:request completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (!error) {
            
            NSError *saveError;
            
            NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
            
            NSTimeInterval time = [[NSDate date] timeIntervalSince1970]*1000;
            NSString * uniqueString = [NSString stringWithFormat:@"%ld",(long)time];
            NSString *savePath = [cachePath stringByAppendingPathComponent:uniqueString];
            
            NSURL *saveUrl = [NSURL fileURLWithPath:savePath];
            
            //把下载的内容从cache复制到document下
            [[NSFileManager defaultManager] copyItemAtURL:location toURL:saveUrl error:&saveError];
            
            
            if (!saveError) {
                
                NSLog(@"save success");
                dispatch_async(dispatch_get_main_queue(), ^{
                    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"save success" message:[NSString stringWithFormat:@"保存路径：%@",saveUrl] preferredStyle:UIAlertControllerStyleAlert];
                    UIAlertAction *actionCancle = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                        [alertController dismissViewControllerAnimated:YES completion:nil];
                    }];
                    UIAlertAction *actionOK = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                        [alertController dismissViewControllerAnimated:YES completion:nil];
                    }];
                    [alertController addAction:actionCancle];
                    [alertController addAction:actionOK];
                    [self presentViewController:alertController animated:YES completion:nil];
                });
            }
        }
    }];
    
    [downloadTask resume];
    
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
