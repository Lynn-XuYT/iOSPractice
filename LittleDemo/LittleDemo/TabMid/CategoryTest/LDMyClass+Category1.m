//
//  LDMyClass+Category1.m
//  LittleDemo
//
//  Created by Lynn on 2018/7/30.
//  Copyright © 2018年 Lynn. All rights reserved.
//

#import "LDMyClass+Category1.h"
 #import <objc/runtime.h>

static NSString *nameWithSetterGetterKey = @"nameWithSetterGetterKey";

@implementation LDMyClass (Category1)

+(void)load
{
    NSLog(@"LDMyClass (Category1) Load");
}

- (void)printName
{
    NSLog(@"LDMyClass (Category1) printName");
}

- (void)setName:(NSString *)name {
    objc_setAssociatedObject(self, &nameWithSetterGetterKey, name, OBJC_ASSOCIATION_COPY);
}

- (NSString *)name {
    return objc_getAssociatedObject(self, &nameWithSetterGetterKey);
}

@end
