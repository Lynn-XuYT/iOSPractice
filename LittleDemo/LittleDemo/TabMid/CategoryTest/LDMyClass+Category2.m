//
//  LDMyClass+Category2.m
//  LittleDemo
//
//  Created by Lynn on 2018/7/30.
//  Copyright © 2018年 Lynn. All rights reserved.
//

#import "LDMyClass+Category2.h"

@implementation LDMyClass (Category2)

+(void)load
{
    NSLog(@"LDMyClass (Category2) Load");
}

- (void)printName
{
    NSLog(@"LDMyClass (Category1) printName");
}

@end
