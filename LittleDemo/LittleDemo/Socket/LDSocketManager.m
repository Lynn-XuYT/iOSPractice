//
//  LDSocketManager.m
//  LittleDemo
//
//  Created by Lynn on 2018/3/15.
//  Copyright © 2018年 Lynn. All rights reserved.
//

#import "LDSocketManager.h"

enum{
    SocketOfflineByLost,// 掉线，默认为0
    SocketOfflineByUser,// 用户主动断开
};

@interface LDSocketManager()<GCDAsyncSocketDelegate>

@end

@implementation LDSocketManager

+ (instancetype)shareInstance
{
    static LDSocketManager *sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[LDSocketManager alloc] init];
    });
    return sharedInstance;
}

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        dispatch_queue_t queue = dispatch_queue_create("并发队列", DISPATCH_QUEUE_CONCURRENT);
        self.socket = [[GCDAsyncSocket alloc] initWithDelegate:self delegateQueue:queue];
    }
    return self;
}
// socket 连接
- (void)socketConnectHost:(NSString *)socketHost onPort:(uint16_t)socketPort
{
    [self cutOffSocket];
    self.socketHost = socketHost;
    self.socketPort = socketPort;
    if (![self.socket connectToHost:socketHost onPort:socketPort error:nil])
    {
        NSLog(@"连接失败");
    }
    [self.socket readDataWithTimeout:-1 tag:100];
}

- (void)socketReconnect
{
    [self cutOffSocket];
    if (![self.socket connectToHost:self.socketHost onPort:self.socketPort error:nil])
    {
        NSLog(@"连接失败");
    }
    [self.socket readDataWithTimeout:-1 tag:100];
}

// socket 断开
- (void)cutOffSocket
{
    if (self.connectTimer) {
        [self.connectTimer invalidate];
        self.connectTimer = nil;
    }
    
    [self.socket setUserData:[NSNumber numberWithInteger:SocketOfflineByUser]]; //主动断开
    [self.socket disconnect];
}

// 心跳连接
- (void)longConnectSocket
{
    NSLog(@"longConnectSocket");
    dispatch_async(dispatch_get_main_queue(), ^{
        [[NSNotificationCenter defaultCenter] postNotificationName:@"statusMsg" object:[NSDictionary dictionaryWithObjectsAndKeys:@"writeData...",@"key", nil]];
    });
    //定时向服务器发送数据，此处代码项目自行调整，这里我将当前时间传送给服务器
    [self.socket writeData:[@"test" dataUsingEncoding:NSUTF8StringEncoding] withTimeout:-1 tag:100];
}

- (void)startLongConnect
{
    
}

- (void)startTimer
{
    NSLog(@"startTimer");
    dispatch_async(dispatch_get_main_queue(), ^{
        [[NSNotificationCenter defaultCenter] postNotificationName:@"statusMsg" object:[NSDictionary dictionaryWithObjectsAndKeys:@"startTimer...",@"key", nil]];
    });
    if (self.connectTimer) {
        [self.connectTimer invalidate];
        self.connectTimer = nil;
    }
    
    self.connectTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(longConnectSocket) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] run];
    [self.connectTimer fire];
    
    // runloop
}

 // 数据传输
- (void)socketWriteData:(NSString *)data
{
    [self.socket writeData:[data dataUsingEncoding:NSUTF8StringEncoding] withTimeout:-1 tag:100];
}

#pragma mark - GCDAsyncSocketDelegate
- (void)socket:(GCDAsyncSocket *)sock didConnectToHost:(NSString *)host port:(uint16_t)port
{
    NSLog(@"连接成功");
    dispatch_async(dispatch_get_main_queue(), ^{
        [[NSNotificationCenter defaultCenter] postNotificationName:@"statusMsg" object:[NSDictionary dictionaryWithObjectsAndKeys:@"连接成功...",@"key", nil]];
    });
    
    [self longConnectSocket];
    //[self.socket readDataWithTimeout:-1 tag:1];
    //60s后 开启定时器，并每隔60s向服务器发送一次心跳包
//    [self startTimer];
//    [self performSelector:@selector(startTimer) onThread:[NSThread currentThread] withObject:nil waitUntilDone:YES];
//    [self performSelector:@selector(test:) withObject:self afterDelay:0.1];
}


- (void)socket:(GCDAsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag
{
    
    NSString *str = [[NSString alloc] initWithData:data encoding:(NSUTF8StringEncoding)];
    NSString *logStr = [NSString stringWithFormat:@"收到数据 - %@",str];
    NSLog(@"收到数据 - %@",str);
    dispatch_async(dispatch_get_main_queue(), ^{
        [[NSNotificationCenter defaultCenter] postNotificationName:@"statusMsg" object:[NSDictionary dictionaryWithObjectsAndKeys:logStr,@"key", nil]];
    });
    //继续监听
    [self.socket readDataWithTimeout:-1 tag:100];
}

- (void)socketDidDisconnect:(GCDAsyncSocket *)sock withError:(nullable NSError *)err
{
    if ([self.socket.userData integerValue] == SocketOfflineByLost) {
        //掉线 就要重连
        [self socketReconnect];
        NSLog(@"掉线重连");
        dispatch_async(dispatch_get_main_queue(), ^{
            [[NSNotificationCenter defaultCenter] postNotificationName:@"statusMsg" object:[NSDictionary dictionaryWithObjectsAndKeys:@"掉线重连...",@"key", nil]];
        });
    }else{
        //主动断开不进行重连
    }
}
@end
