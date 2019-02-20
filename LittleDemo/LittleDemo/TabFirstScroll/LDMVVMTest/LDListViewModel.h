//
//  LDListViewModel.h
//  LittleDemo
//
//  Created by lynn on 2019/2/19.
//  Copyright © 2019 Lynn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "LDItemViewModel.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^CompletedBlock)(void);
@interface LDListViewModel : NSObject

@property (nonatomic, strong, readonly) NSMutableArray<LDItemViewModel *> *tweets;

- (void)loadAllDataCompleteBlock:(CompletedBlock)block;

@end

NS_ASSUME_NONNULL_END
