//
//  LDCrashReport.m
//  LittleDemo
//
//  Created by lynn on 2019/2/21.
//  Copyright © 2019 Lynn. All rights reserved.
//

#import "LDCrashReport.h"

static NSUncaughtExceptionHandler *g_vaildUncaughtExceptionHandler;

@implementation LDCrashReport

void ori_NSSetUncaughtExceptionHandler( NSUncaughtExceptionHandler * handler)
{
    NSSetUncaughtExceptionHandler(handler);
}

void my_NSSetUncaughtExceptionHandler( NSUncaughtExceptionHandler * handler)
{
    g_vaildUncaughtExceptionHandler = NSGetUncaughtExceptionHandler();
    if (g_vaildUncaughtExceptionHandler != NULL) {
        NSLog(@"%s - UncaughtExceptionHandler=%p",__func__,NSGetUncaughtExceptionHandler());
    }
    
    NSSetUncaughtExceptionHandler(&MYUncaughtExceptionHandler);
    
    NSLog(@"%s - UncaughtExceptionHandler=%p",__func__,NSGetUncaughtExceptionHandler());
}

void MYUncaughtExceptionHandler( NSException * exception)
{
    [NSThread callStackSymbols];
    NSArray *arr = [exception callStackSymbols];
    NSString *reason = [exception reason];
    NSString *name = [exception name];
    NSLog(@"-------------------- \n%@\n%@\n%@\n----------------------",arr, reason, name);
    g_vaildUncaughtExceptionHandler(exception);
}

+ (void)setLDCrashReportHandler
{
    my_NSSetUncaughtExceptionHandler(&MYUncaughtExceptionHandler);
}
@end
