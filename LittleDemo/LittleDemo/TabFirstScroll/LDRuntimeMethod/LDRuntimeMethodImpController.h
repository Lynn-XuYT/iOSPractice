//
//  LDRuntimeMethodImpController.h
//  LittleDemo
//
//  Created by Lynn on 2018/8/2.
//  Copyright © 2018年 Lynn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LDBaseViewController.h"

@interface Person : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, assign) NSInteger age;
@property (nonatomic, strong) NSString *sex;

+ (Person *)dictToModel:(NSDictionary *)dict;

@end

@interface Man : Person<NSCoding>

@property (nonatomic, strong) NSString *manString1;
@property (nonatomic, strong) NSString *manString2;
@property (nonatomic, strong) NSString *manString3;
@end

@interface Women : Person

@property (nonatomic, strong) NSString *womanString;

@end


@interface Person (Addtion)

@property (nonatomic, strong) NSString *desp;

@end

@interface LDRuntimeMethodImpController : LDBaseViewController

- (instancetype)initWithType:(int)type;
@end
