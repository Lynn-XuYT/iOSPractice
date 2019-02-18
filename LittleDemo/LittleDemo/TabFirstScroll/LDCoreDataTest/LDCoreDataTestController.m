//
//  LDCoreDataTestController.m
//  LittleDemo
//
//  Created by lynn on 2019/2/18.
//  Copyright © 2019 Lynn. All rights reserved.
//

#import "LDCoreDataTestController.h"
#import <CoreData/CoreData.h>
#import "User+CoreDataProperties.h"
#import "Card+CoreDataProperties.h"

@interface LDCoreDataTestController ()
@property(nonatomic, strong) NSManagedObjectContext *context;
@property(nonatomic, strong) NSPersistentStoreCoordinator *storeCoordinator;
@end

@implementation LDCoreDataTestController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addClassTest];
    
    [self fetchData];
}

- (NSManagedObjectContext *)context
{
    if (!_context)
    {
        _context = [self createDbContext];
    }
    return _context;
}

- (NSPersistentStoreCoordinator *)storeCoordinator
{
    if (!_storeCoordinator)
    {
        // 打开模型文件，参数为nil则打开包中所有模型文件并合并成一个
        NSManagedObjectModel *model = [NSManagedObjectModel mergedModelFromBundles:nil];
        // 传入模型对象，初始化数据解析器NSPersistentStoreCoordinator
        _storeCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:model];
    }
    return _storeCoordinator;
}

- (NSManagedObjectContext *)createDbContext {

    // 创建数据库保存路径
    NSString *dir = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES).lastObject;
    NSString *path = [dir stringByAppendingPathComponent:@"myDatabase.db"];
    NSURL *url = [NSURL fileURLWithPath:path];
    // 添加持久化存储库，这里使用SQLite作为存储库，添加SQLite持久存储到解析器
    NSError *error;
    [self.storeCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:url options:nil error:&error];
    
    NSManagedObjectContext *context = nil;
    if(!error) {
        // 创建对象管理上下文，并设置数据解析器
        context = [[NSManagedObjectContext alloc] init];
        context.persistentStoreCoordinator = self.storeCoordinator;
        NSLog(@"数据库打开成功！");
    } else {
        NSLog(@"数据库打开失败！错误:%@",error.localizedDescription);
    }
    return context;
}

- (void)addClassTest {
    
    // 传入上下文，创建一个Person实体对象
    User *user = [NSEntityDescription insertNewObjectForEntityForName:@"User" inManagedObjectContext:self.context];
    // 设置user的简单属性
    user.name = @"zhangsan";
    user.age = 16;
    
    // 传入上下文，创建一个Card实体对象
    Card *card = [NSEntityDescription insertNewObjectForEntityForName:@"Card" inManagedObjectContext:self.context];
    card.loc = @"shanghai";
    // 设置Person和Card之间的关联关系
    user.card = card;
    
    // 利用上下文对象，将数据同步到持久化存储库
    NSError *error = nil;
    BOOL success = [self.context save:&error];
    // 保存上下文,这里需要注意，增、删、改操作完最后必须调用管理对象上下文的保存方法，否则操作不会执行。
    // 如果是想做更新操作：只要在更改了实体对象的属性后调用  [context save:&error]，就能将更改的数据同步到数据库。
    if (!success) {
        NSLog(@"添加过程中发生错误,错误信息：%@！",error.localizedDescription);
    }
    else {
        NSLog(@"插入数据成功!");
    }
}

- (void)fetchData {
    
//    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"User"];
//    [request setPredicate:[NSPredicate predicateWithFormat:@"name == %@", @"zhangsan"]];
//    NSError *error = nil;
//    NSArray *resultArray = [context executeFetchRequest:request error:&error];
//    NSLog(@"%@",resultArray);
    
    // 1.创建NSFetchRequest查询请求对象
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    // 2.设置需要查询的实体描述NSEntityDescription
    NSEntityDescription *desc = [NSEntityDescription entityForName:@"User"
                                            inManagedObjectContext:self.context];
    request.entity = desc;
    // 3.设置排序顺序NSSortDescriptor对象集合(可选)
//    request.sortDescriptors = descriptorArray;
    // 4.设置条件过滤（可选）
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name == %@", @"zhangsan"];
    request.predicate = predicate;
    // 5.执行查询请求
    NSError *error = nil;
    // NSManagedObject对象集合
    NSArray *fetchedObjects = [self.context executeFetchRequest:request error:&error];
    // 查询结果数目
    NSUInteger count = [self.context countForFetchRequest:request error:&error];
    NSLog(@"输出查询结果");
    for (User *info in fetchedObjects) {
        
        NSLog(@"Name: %@", info.name);
        NSLog(@"age: %d", info.age);
        NSLog(@"-----------------------------------");
        
        Card *card = [info valueForKey:@"Card"];
        
        
        NSLog(@"loc: %@", card.loc);
        NSLog(@"==========================================");
        
        //        NSLog(@"Name: %@", [man1 valueForKey:@"name"]);
        //        NSLog(@"weight: %@", [man1 valueForKey:@"weight"]);
        //        NSLog(@"height: %@", [man1 valueForKey:@"height"]);
        //        NSLog(@"==========================================");
    }
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
