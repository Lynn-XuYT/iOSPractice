//
//  Card+CoreDataProperties.h
//  LittleDemo
//
//  Created by lynn on 2019/2/18.
//  Copyright © 2019 Lynn. All rights reserved.
//
//

#import "Card+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Card (CoreDataProperties)

+ (NSFetchRequest<Card *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *loc;
@property (nullable, nonatomic, retain) User *user;

@end

NS_ASSUME_NONNULL_END
