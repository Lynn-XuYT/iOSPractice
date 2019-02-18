//
//  Account+CoreDataProperties.m
//  LittleDemo
//
//  Created by lynn on 2019/2/18.
//  Copyright © 2019 Lynn. All rights reserved.
//
//

#import "Account+CoreDataProperties.h"

@implementation Account (CoreDataProperties)

+ (NSFetchRequest<Account *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"Account"];
}

@dynamic uin;
@dynamic name;

@end
