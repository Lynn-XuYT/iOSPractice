//
//  Card+CoreDataProperties.m
//  LittleDemo
//
//  Created by lynn on 2019/2/18.
//  Copyright © 2019 Lynn. All rights reserved.
//
//

#import "Card+CoreDataProperties.h"

@implementation Card (CoreDataProperties)

+ (NSFetchRequest<Card *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"Card"];
}

@dynamic loc;
@dynamic user;

@end
