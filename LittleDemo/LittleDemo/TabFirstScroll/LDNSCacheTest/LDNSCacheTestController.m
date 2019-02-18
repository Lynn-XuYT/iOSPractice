//
//  LDNSCacheTestController.m
//  LittleDemo
//
//  Created by lynn on 2019/2/18.
//  Copyright © 2019 Lynn. All rights reserved.
//

#import "LDNSCacheTestController.h"

@interface LDNSCacheTestController ()<NSCacheDelegate>
@property (nonatomic, strong) NSCache *cache;
@end

@implementation LDNSCacheTestController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //添加缓存数据
    for (int i = 0; i < 10; i++) {
        [self.cache setObject:[NSString stringWithFormat:@"hello %d",i] forKey:[NSString stringWithFormat:@"h%d",i]];
        NSLog(@"添加 %@",[NSString stringWithFormat:@"hello %d",i]);
    }
    
    //输出缓存中的数据
    for (int i = 0; i < 10; i++) {
        NSLog(@"%@",[self.cache objectForKey:[NSString stringWithFormat:@"h%d",i]]);
    }
    
}

- (NSCache *)cache {
    if (_cache == nil) {
        _cache = [[NSCache alloc] init];
        // 缓存中总共可以存储多少条
        _cache.countLimit = 5;
        // 缓存的数据总量为多少
        _cache.totalCostLimit = 1024 * 5;
        //设置NSCache的代理
        _cache.delegate = self;
    }
    return _cache;
}

- (void)cache:(NSCache *)cache willEvictObject:(id)obj
{
    NSLog(@"缓存移除  %@",obj);
}

// 触摸事件, 以便验证添加数据
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.cache removeAllObjects];
    
    //添加缓存数据
    for (int i = 0; i < 10; i++) {
        [self.cache setObject:[NSString stringWithFormat:@"hello %d",i] forKey:[NSString stringWithFormat:@"h%d",i]];
        //        NSLog(@"添加 %@",[NSString stringWithFormat:@"hello %d",i]);
    }
    
    //输出缓存中的数据
    for (int i = 0; i < 10; i++) {
        NSLog(@"touchesBegan - %@",[self.cache objectForKey:[NSString stringWithFormat:@"h%d",i]]);
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    //当收到内存警告，清除内存
    [self.cache removeAllObjects];
    //输出缓存中的数据
    for (int i = 0; i < 10; i++) {
        NSLog(@"didReceiveMemoryWarning - %@",[self.cache objectForKey:[NSString stringWithFormat:@"h%d",i]]);
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
