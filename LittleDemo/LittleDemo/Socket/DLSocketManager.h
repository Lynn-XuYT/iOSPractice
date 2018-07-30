//
//  DLSocketManager.h
//  LittleDemo
//
//  Created by Lynn on 2018/3/15.
//  Copyright © 2018年 Lynn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CocoaAsyncSocket.h"

@interface DLSocketManager : NSObject

@property (nonatomic, strong) GCDAsyncSocket *socket;
@property (nonatomic, strong) NSString *socketHost;     // ip
@property (nonatomic, assign) uint16_t socketPort;      // 端口
@property (nonatomic, strong) NSTimer *connectTimer;    // 计时器


+ (instancetype)shareInstance;

- (void)socketConnectHost:(NSString *)socketHost onPort:(uint16_t)socketPort;// socket 连接

- (void)socketReconnect;// socket 重连

- (void)cutOffSocket; // socket 断开

- (void)longConnectSocket; // 心跳连接

- (void)startTimer;

- (void)socketWriteData:(NSString *)data; // 数据传输


@end
