//
//  LDListViewModel.m
//  LittleDemo
//
//  Created by lynn on 2019/2/19.
//  Copyright © 2019 Lynn. All rights reserved.
//

#import "LDListViewModel.h"
#import "LDItemModel.h"
#import "LDItemViewModel.h"
@implementation LDListViewModel

- (instancetype)init
{
    if (self = [super init]) {
        _tweets = [NSMutableArray array];
    }
    return self;
}
- (void)loadAllDataCompleteBlock:(CompletedBlock)block
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        for (int i = 0; i < 50; i++) {
            LDItemViewModel *itemViewModel = [LDItemViewModel new];
            itemViewModel.itemModel = [LDItemModel new];
            [_tweets addObject:itemViewModel];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            if (block) {
                block();
            }
        });
    });
}
@end
