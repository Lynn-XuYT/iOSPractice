//
//  LDCopyTestController.h
//  LittleDemo
//
//  Created by Lynn on 2018/12/11.
//  Copyright © 2018年 Lynn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LDBaseViewController.h"

@interface LDCopySimpleModel : NSObject
//NSData, NSString, NSArray, NSDictionary, NSDate, and NSNumber objects

@property (nonatomic,strong) NSData *data;
@property (nonatomic,strong) NSString *string;
@property (nonatomic,strong) NSNumber *num;
@property (nonatomic,strong) NSArray *array;
@property (nonatomic,strong) NSDictionary *dict;
@property (nonatomic,strong) NSDate *date;
@end

@interface LDCopyTestModel : NSObject
@property (nonatomic,strong) LDCopySimpleModel *model;
@property (nonatomic,strong) NSData *data;
@property (nonatomic,strong) NSString *string;
@property (nonatomic,strong) NSNumber *num;
@property (nonatomic,strong) NSArray *array;
@property (nonatomic,strong) NSDictionary *dict;
@property (nonatomic,strong) NSDate *date;
@end

@interface LDCopyTestController : LDBaseViewController

@end
