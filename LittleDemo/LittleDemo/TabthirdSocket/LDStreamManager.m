//
//  LDStreamManager.m
//  LittleDemo
//
//  Created by Lynn on 2018/6/13.
//  Copyright © 2018年 Lynn. All rights reserved.
//

#import "LDStreamManager.h"

@interface LDStreamManager ()<NSStreamDelegate>
{
    NSInputStream *_input;
    
    NSOutputStream *_ouput;
}
@end

@implementation LDStreamManager

+ (instancetype)shareInstance
{
    static LDStreamManager *manager;
    static dispatch_once_t token;
    dispatch_once(&token, ^{
        manager = [LDStreamManager new];
    });
    return manager;
}

- (void)startConnectHost:(NSString *)socketHost onPort:(uint16_t)socketPort
{
    dispatch_queue_t queue = dispatch_queue_create("并发队列", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(queue, ^{
        [[NSRunLoop currentRunLoop] run];
        [self socketConnectHost:socketHost onPort:socketPort];
        
        
    });
}

- (void)socketConnectHost:(NSString *)socketHost onPort:(uint16_t)socketPort
{
    CFReadStreamRef rs;
    
    CFWriteStreamRef ws;
    
    NSString *m_IP = socketHost;
    int m_port = socketPort;
    CFStreamCreatePairWithSocketToHost(kCFAllocatorDefault, (__bridge CFStringRef)m_IP, m_port, &rs, &ws);
    
    _input = (__bridge NSInputStream*)rs;
    
    _ouput = (__bridge NSOutputStream*)ws;
    
    [_input scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    [_ouput scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    //    [_input setProperty:NSStreamSocketSecurityLevelTLSv1 forKey:NSStreamSocketSecurityLevelKey];
    //
    //    [_ouput setProperty:NSStreamSocketSecurityLevelTLSv1 forKey:NSStreamSocketSecurityLevelKey];
    
    //    NSDictionary *settings = [[NSDictionary alloc] initWithObjectsAndKeys:
    //
    //                              [NSNumber numberWithBool:NO], kCFStreamSSLValidatesCertificateChain,
    //
    //                              //kCFNull,kCFStreamSSLPeerName,
    //
    //                              NSStreamSocketSecurityLevelTLSv1, kCFStreamSSLLevel,
    //
    //                              kCFBooleanFalse, kCFStreamSSLIsServer,
    //
    //                              nil];
    
    
    //    if (rs) {
    //
    //        CFReadStreamSetProperty(rs, kCFStreamPropertySSLSettings, (CFTypeRef)settings);
    //
    //    }
    //
    //    if (ws) {
    //
    //        CFWriteStreamSetProperty(ws, kCFStreamPropertySSLSettings, (CFTypeRef)settings);
    //
    //    }
    
    
    [_input open];
    [_ouput open];
    _input.delegate = self;
    _ouput.delegate = self;
}

// 心跳连接
- (void)longConnectSocket
{
    NSLog(@"longConnectSocket");
    dispatch_async(dispatch_get_main_queue(), ^{
        [[NSNotificationCenter defaultCenter] postNotificationName:@"statusMsg" object:[NSDictionary dictionaryWithObjectsAndKeys:@"writeData...",@"key", nil]];
    });
    //定时向服务器发送数据，此处代码项目自行调整，这里我将当前时间传送给服务器
    NSString * str = @"hahahh";
    NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
    [_ouput write:data.bytes maxLength:data.length];
}


- (void)stream:(NSStream *)aStream handleEvent:(NSStreamEvent)eventCode
{
    switch (eventCode) {
        case NSStreamEventOpenCompleted:
            NSLog(@"NSStreamEventOpenCompleted");
            break;
        case NSStreamEventHasBytesAvailable:
        {
            //定义一个数组
            uint8_t streamData[1000000];
            
            //返回输入长度
            NSUInteger length = [_input read:streamData maxLength:1000000];
            
            if (length) {
                //转换为data
                NSData *data = [NSData dataWithBytes:streamData length:length];
                NSString *str = [NSString stringWithUTF8String:[data bytes]];
                NSLog(@"%@ - %lu",str,(unsigned long)data.length);
                
            }else{
                NSLog(@"没有数据");
            }
        }
            break;
        case NSStreamEventHasSpaceAvailable:
            NSLog(@"NSStreamEventHasSpaceAvailable");
            break;
        case NSStreamEventErrorOccurred:
            NSLog(@"NSStreamEventErrorOccurred");
            break;
        case NSStreamEventEndEncountered:
            NSLog(@"NSStreamEventEndEncountered");
            break;
        default:
            break;
    }
}

@end
