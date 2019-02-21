//
//  LDCopyTestController.m
//  LittleDemo
//
//  Created by Lynn on 2018/12/11.
//  Copyright © 2018年 Lynn. All rights reserved.
//

#import "LDCopyTestController.h"

#define COUNT 100


#define STRING @"商机需求整理通用能力商机需求整理通用能力商机需求整理通用能力商机需求整理通用能力商机需求整理通用能力商机需求整理通用能力商机需求整理通用能力商机需求整理通用能力商机需求整理通用能力商机需求整理通用能力商机需求整理通用能力商机需求整理通用能力商机需求整理通用能力商机需求整理通用能力商机需求整理通用能力商机需求整理通用能力商机需求整理通用能力商机需求整理通用能力商机需求整理通用能力商机需求整理通用能力商机需求整理通用能力商机需求整理通用能力商机需求整理通用能力商机需求整理通用能力商机需求整理通用能力商机需求整理通用能力商机需求整理通用能力商机需求整理通用能力商机需求整理通用能力商机需求整理通用能力商机需求整理通用能力商机需求整理通用能力商机需求整理通用能力商机需求整理通用能力商机需求整理通用能力商机需求整理通用能力商机需求整理通用能力商机需求整理通用能力商机需求整理通用能力商机需求整理通用能力商机需求整理通用能力商机需求整理通用能力商机需求整理通用能力商机需求整理通用能力商机需求整理通用能力商机需求整理通用能力商机需求整理通用能力商机需求整理通用能力商机需求整理通用能力商机需求整理通用能力商机需求整理通用能力商机需求整理通用能力商机需求整理通用能力商机需求整理通用能力商机需求整理通用能力商机需求整理通用能力商机需求整理通用能力商机需求整理通用能力商机需求整理通用能力商机需求整理通用能力商机需求整理通用能力商机需求整理通用能力"

@interface NSObject (DeepCopyIMP)
@end

@implementation NSObject (DeepCopyIMP)

- (instancetype)deepCopyIfCan
{
    if ([self isKindOfClass:[NSDictionary class]]) {
        __block NSMutableDictionary *copy_dict = [NSMutableDictionary dictionary];
        [(NSDictionary *)self enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            id copyedObj = [obj deepCopyIfCan];
            if (copyedObj) {
                copy_dict[key] = copyedObj;
            }
            else {
                copy_dict = nil;
                *stop = YES;
            }
        }];
        return copy_dict;
    }
    else if ([self isKindOfClass:[NSArray class]]) {
        __block NSMutableArray *copy_array = [NSMutableArray array];
        [(NSArray *)self enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            id copyedObj = [obj deepCopyIfCan];
            if (copyedObj) {
                [copy_array addObject:copyedObj];
            }
            else {
                copy_array = nil;
                *stop = YES;
            }
        }];
        return copy_array;
    }
    else if ([self isKindOfClass:[NSSet class]]) {
        __block NSMutableSet *copy_set = [NSMutableSet set];
        [(NSSet *)self enumerateObjectsUsingBlock:^(id  _Nonnull obj, BOOL * _Nonnull stop) {
            id copyedObj = [obj deepCopyIfCan];
            if (copyedObj) {
                [copy_set addObject:copyedObj];
            }
            else {
                copy_set = nil;
                *stop = YES;
            }
        }];
        return copy_set;
    }
    else if ([self respondsToSelector:@selector(copyWithZone:)]) {
        return [self copy];
    }
    else {
        return nil;
    }
}
@end

@interface LDCopySimpleModel ()<NSCopying,NSCoding>
@end

@implementation LDCopySimpleModel

- (instancetype)init {
    self = [super init];
    if (self) {
        self.data = [STRING dataUsingEncoding:NSUTF8StringEncoding];
        self.string = STRING;
        self.num = [NSNumber numberWithInt:456];
        self.array = @[STRING,STRING,STRING,STRING,STRING];
        self.dict = @{@"key":STRING};
        self.date = [NSDate date];
    }
    return self;
}

- (id)copyWithZone:(NSZone *)zone {
    LDCopySimpleModel *m = [LDCopySimpleModel allocWithZone:zone];
    m.data = [self.data copy];
    m.string = [self.string copy];
    m.num = [self.num copy];
    m.array = [self.array copy];
    m.dict = [self.dict copy];
    m.date = [self.date copy];
    return m;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self.data = [aDecoder decodeObjectForKey:@"data"];
    self.string = [aDecoder decodeObjectForKey:@"string"];
    self.num = [aDecoder decodeObjectForKey:@"num"];
    self.array = [aDecoder decodeObjectForKey:@"array"];
    self.dict = [aDecoder decodeObjectForKey:@"dict"];
    self.date = [aDecoder decodeObjectForKey:@"date"];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.data forKey:@"data"];
    [aCoder encodeObject:self.string forKey:@"string"];
    [aCoder encodeObject:self.num forKey:@"num"];
    [aCoder encodeObject:self.array forKey:@"array"];
    [aCoder encodeObject:self.dict forKey:@"dict"];
    [aCoder encodeObject:self.date forKey:@"date"];
}

@end

@interface LDCopyTestModel ()<NSCopying,NSCoding>
@end

@implementation LDCopyTestModel

- (instancetype)init {
    self = [super init];
    if (self) {
        self.data = [STRING dataUsingEncoding:NSUTF8StringEncoding];
        self.string = STRING;
        self.num = [NSNumber numberWithInt:456];
        self.array = @[STRING,STRING,STRING,STRING,STRING];
        self.dict = @{@"key":STRING};
        self.date = [NSDate date];
        self.model = [LDCopySimpleModel new];
    }
    return self;
}

- (id)copyWithZone:(NSZone *)zone {
    LDCopyTestModel *m = [LDCopyTestModel allocWithZone:zone];
    m.data = [self.data copy];
    m.string = [self.string copy];
    m.num = [self.num copy];
    m.array = [self.array copy];
    m.dict = [self.dict copy];
    m.date = [self.date copy];
    m.model = [self.model copy];
    return m;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self.data = [aDecoder decodeObjectForKey:@"data"];
    self.string = [aDecoder decodeObjectForKey:@"string"];
    self.num = [aDecoder decodeObjectForKey:@"num"];
    self.array = [aDecoder decodeObjectForKey:@"array"];
    self.dict = [aDecoder decodeObjectForKey:@"dict"];
    self.date = [aDecoder decodeObjectForKey:@"date"];
    self.model = [aDecoder decodeObjectForKey:@"model"];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.data forKey:@"data"];
    [aCoder encodeObject:self.string forKey:@"string"];
    [aCoder encodeObject:self.num forKey:@"num"];
    [aCoder encodeObject:self.array forKey:@"array"];
    [aCoder encodeObject:self.dict forKey:@"dict"];
    [aCoder encodeObject:self.date forKey:@"date"];
    [aCoder encodeObject:self.model forKey:@"model"];
}

@end

@interface LDCopyTestController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic,copy) NSString *c_string;
@property (nonatomic,strong) NSString *s_string;

@property (nonatomic,strong) NSMutableArray *data;
@end

@implementation LDCopyTestController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.data = [NSMutableArray arrayWithObjects:@"1",
                       @"字典 copy mutableCopy",
                       @"数组 copy mutableCopy",
                       @"字典 深拷贝 initWithDictionary:copyItems:",
                       @"字典 深拷贝 NSKeyedArchiver",
                       @"字典 深拷贝 NSPropertyListSerialization",
                       @"字典 深拷贝 NSJSONSerialization",
                       @"字典 深拷贝 deepCopyIfCan",
                       @"自定义类型 深拷贝 耗时比较",
                       @"基本数据类型 深拷贝 耗时比较",
                       nil];
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64)];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = self.data[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.row) {
        case 0:
        {
            NSMutableString *mstr = [NSMutableString stringWithString:@"123"];
            
            self.s_string = mstr;
            self.c_string = mstr;
            
            [mstr appendString:@"456"];
            NSLog(@"mstr string [%p] = %@",mstr ,mstr);
            NSLog(@"strong string [%p] = %@",self.s_string ,self.s_string);
            NSLog(@"copy strong string [%p] = %@",[self.s_string copy],[self.s_string copy]);
            NSLog(@"copy string [%p] = %@",self.c_string ,self.c_string);
        }
            break;
        case 1:
            [self testDictCopyOp];
            break;
        case 2:
            [self testArrayCopyOp];
            break;
        case 3:
            [self testDictDeepCopyOp1];
            break;
        case 4:
            [self testDictDeepCopyOp2];
            break;
        case 5:
            [self testDictDeepCopyOp3];
            break;
        case 6:
            [self testDictDeepCopyOp4];
            break;
        case 7:
            [self testDictDeepCopyOp5];
            break;
        case 8:
            [self compareCost];
            break;
        case 9:
            [self compareCost2];
            break;
        default:
            break;
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)testDictCopyOp {
    NSMutableDictionary *m_dict = [NSMutableDictionary dictionary];
    [m_dict setObject:[LDCopyTestModel new] forKey:@1];
    [m_dict setObject:[LDCopyTestModel new] forKey:@2];
    [m_dict setObject:[LDCopyTestModel new] forKey:@3];
    [m_dict setObject:[LDCopyTestModel new] forKey:@4];
    [m_dict setObject:[LDCopyTestModel new] forKey:@5];
    
    printf("\n---------------------------- 原始可变dict （m_dict）\n");
    printf("m_dict - %p - %p\n", m_dict, &m_dict);
    for (id key in m_dict) {
        NSNumber *strKey = (NSNumber*)key;
        LDCopyTestModel *model = m_dict[strKey];
        [self print:model withKey:strKey.intValue];
    }
    
    printf("\n---------------------------- [m_dict copy] （dict）\n");
    NSDictionary *dict = [m_dict copy];
    printf("dict - %p - %p\n", dict, &dict);
    for (id key in dict) {
        NSNumber *strKey = (NSNumber*)key;
        LDCopyTestModel *model = dict[strKey];
        [self print:model withKey:strKey.intValue];
    }
    printf("\n*************对比 m_dict 和 [m_dict copy] \n结论：对不可变dict的copy操作，只会copy一份指向字典的指针，没有对其内容的对象进行copy *************\n");
    
    NSDictionary *dictTmp = [dict copy];
    printf("dictTmp - %p\n", dictTmp);
    for (id key in dictTmp) {
        NSNumber *strKey = (NSNumber*)key;
        LDCopyTestModel *model = dict[strKey];
        [self print:model withKey:strKey.intValue];
    }
    
    printf("\n----------------------------  m_dict mutableCopy （mdict）\n");
    NSMutableDictionary *mdict = [m_dict mutableCopy];
    printf("mdict - %p - %p\n", mdict, &mdict);
    for (id key in mdict) {
        NSNumber *strKey = (NSNumber*)key;
        LDCopyTestModel *model = mdict[strKey];
        [self print:model withKey:strKey.intValue];
    }
    
    printf("\n----------------------------  dict mutableCopy （mdict1）\n");
    NSMutableDictionary *mdict1 = [dict mutableCopy];
    printf("mdict1 - %p - %p\n", mdict1, &mdict1);
    for (id key in mdict1) {
        NSNumber *strKey = (NSNumber*)key;
        LDCopyTestModel *model = mdict[strKey];
        [self print:model withKey:strKey.intValue];
    }
    
    printf("\n************* 对可变、不可变字典进行mutableCopy，作用是一样的，都是指向字典的指针进行copy，其内容都是一份 *************\n");
    
    printf("\n---------------------------- 对 m_dict 的value的某个属性model进行修改（m_dict）\n");
    printf("m_dict - %p - %p\n", m_dict, &m_dict);
    for (id key in m_dict) {
        NSNumber *strKey = (NSNumber*)key;
        //        [m_dict setObject:[LDCopyTestModel new] forKey:strKey];
        ((LDCopyTestModel *)m_dict[strKey]).model = [LDCopySimpleModel new];
        LDCopyTestModel *model = m_dict[strKey];
        [self print:model withKey:strKey.intValue];
    }
    
    printf("\n---------------------------- 更改m_dict后的dict （dict）\n");
    printf("m_dict - %p - %p\n", dict, &dict);
    for (id key in dict) {
        NSNumber *strKey = (NSNumber*)key;
        LDCopyTestModel *model = dict[strKey];
        [self print:model withKey:strKey.intValue];
    }
    
    printf("\n************* 证明m_dict和dict的value指向同一个对象，对m_dict copy 并没用对其内容的对象进行copy *************\n");
    
    printf("\n---------------------------- 直接修改 m_dict 的value值\n");
    printf("m_dict - %p - %p\n", m_dict, &m_dict);
    for (id key in dict) {
        NSNumber *strKey = (NSNumber*)key;
        [m_dict setObject:[LDCopyTestModel new] forKey:strKey];
        //        ((LDCopyTestModel *)m_dict[strKey]).model = [LDCopySimpleModel new];
        LDCopyTestModel *model = m_dict[strKey];
        [self print:model withKey:strKey.intValue];
    }
    
    printf("\n************* 遍历dict（m_dict copy 生成的字典）修改m_dict 的value值不会引起crash *************\n");
    
    printf("\n---------------------------- 更改m_dict后的dict （dict）\n");
    printf("dict - %p - %p\n", dict, &dict);
    for (id key in dict) {
        NSNumber *strKey = (NSNumber*)key;
        LDCopyTestModel *model = dict[strKey];
        [self print:model withKey:strKey.intValue];
    }
    printf("\n************* 遍历dict（m_dict copy 生成的字典）修改m_dict 的value值不会引起crash，并且不会影响dict的键值 *************\n");
    
    printf("\n----------------------------  dict copy （dict2）\n");
    NSDictionary *dict2 = [dict copy];
    printf("dict2 - %p - %p\n", dict2, &dict2);
    for (id key in dict2) {
        NSNumber *strKey = (NSNumber*)key;
        LDCopyTestModel *model = dict2[strKey];
        [self print:model withKey:strKey.intValue];
    }
    printf("\n************* 对不可变dict进行copy，无任何作用 *************\n");
}

- (void)testArrayCopyOp {
    NSMutableArray *m_arr = [NSMutableArray array];
    [m_arr addObject:[LDCopyTestModel new]];
    [m_arr addObject:[LDCopyTestModel new]];
    [m_arr addObject:[LDCopyTestModel new]];
    [m_arr addObject:[LDCopyTestModel new]];
    [m_arr addObject:[LDCopyTestModel new]];
    
    printf("\n---------------------------- 原始可变Array （m_arr）\n");
    printf("m_arr - %p - %p\n", m_arr, &m_arr);
    for (LDCopyTestModel *model in m_arr) {
        [self print:model withKey:0];
    }
    
    printf("\n---------------------------- [m_arr copy] （arr）\n");
    NSArray *arr = [m_arr copy];
    printf("arr - %p - %p\n", arr, &arr);
    for (LDCopyTestModel *model in arr) {
        [self print:model withKey:0];
    }
    
    printf("\n*************对比 m_arr 和 [m_arr copy] \n结论：对不可变array的copy操作，只会copy一份指向数组的指针，没有对其内容的对象进行copy *************\n");
    
    printf("\n----------------------------  m_arr mutableCopy （marr）\n");
    NSMutableArray *marr = [m_arr mutableCopy];
    printf("marr - %p - %p\n", marr, &marr);
    for (LDCopyTestModel *model in marr) {
        [self print:model withKey:0];
    }
    
    printf("\n----------------------------  arr mutableCopy （marr1）\n");
    NSMutableDictionary *marr1 = [arr mutableCopy];
    printf("mdict1 - %p - %p\n", marr1, &marr1);
    for (LDCopyTestModel *model in marr1) {
        [self print:model withKey:0];
    }
    
    printf("\n************* 对可变、不可变数组进行mutableCopy，作用是一样的，都是指向数组的指针进行copy，其内容都是一份 *************\n");
    
    printf("\n---------------------------- 对 arr 的某个model的属性进行修改\n");
    printf("m_dict - %p - %p\n", arr, &arr);
    for (LDCopyTestModel *model in arr) {
        model.model = [LDCopySimpleModel new];
        [self print:model withKey:0];
    }
    
    printf("\n---------------------------- 更改arr后的m_arr （m_arr）\n");
    printf("m_dict - %p - %p\n", m_arr, &m_arr);
    for (LDCopyTestModel *model in m_arr) {
        [self print:model withKey:0];
    }
    
    printf("\n************* 证明m_arr和arr中的每个元素指向同一个对象，对m_arr copy 并没用对其元素进行copy *************\n");
    
    printf("\n---------------------------- 直接修改 m_arr 的值\n");
    [m_arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        m_arr[idx] = [LDCopyTestModel new];
        [m_arr removeObject:obj];
//        [m_arr removeObjectAtIndex:idx];
//        [m_arr addObject:[LDCopyTestModel new]];
    }];
    
    // crash
//    for (LDCopyTestModel *model in m_arr) {
//        [m_arr removeObject:model];
//        [m_arr removeObjectAtIndex:[m_arr indexOfObject:model]];
//    }
    
    printf("\n************* 遍历m_arr修改m_arr数组中的元素不会引起crash *************\n");
    
    printf("\n---------------------------- 更改m_arr后的m_arr （m_arr）\n");
    printf("m_arr - %p - %p\n", m_arr, &m_arr);
    for (LDCopyTestModel *model in m_arr) {
        [self print:model withKey:0];
    }
    
    printf("\n---------------------------- 更改m_arr后的arr（arr）\n");
    printf("arr - %p - %p\n", arr, &arr);
    for (LDCopyTestModel *model in arr) {
        [self print:model withKey:0];
    }
    printf("\n************* enumerateObjectsUsingBlock 遍历并修改m_arr 的元素不会引起crash，并且不会影响arr *************\n");
    
    printf("\n----------------------------  arr copy （arr2）\n");
    NSArray *arr2 = [arr copy];
    printf("arr2 - %p - %p\n", arr2, &arr2);
    for (LDCopyTestModel *model in arr2) {
        [self print:model withKey:0];
    }
    printf("\n************* 对不可变arr进行copy，无任何作用 *************\n");
}


- (void)testDictDeepCopyOp1 {
    NSMutableDictionary *m_dict = [NSMutableDictionary dictionary];
    [m_dict setObject:[LDCopyTestModel new] forKey:@1];
    [m_dict setObject:[LDCopyTestModel new] forKey:@2];
    [m_dict setObject:[LDCopyTestModel new] forKey:@3];
    [m_dict setObject:[LDCopyTestModel new] forKey:@4];
    [m_dict setObject:[LDCopyTestModel new] forKey:@5];
    
    printf("\n----------------------------  m_dict \n");
    printf("m_dict - %p - %p\n", m_dict, &m_dict);
    for (id key in m_dict) {
        NSNumber *strKey = (NSNumber*)key;
        LDCopyTestModel *model = m_dict[strKey];
        [self print:model withKey:strKey.intValue];
    }
    
    printf("\n----------------------------  [[NSMutableDictionary alloc] initWithDictionary:m_dict copyItems:YES] （c_dict）\n此时dict的value必须实现NSCopy协议，否则会crash\n");
    // 此时dict的value必须实现NSCopy协议
    NSMutableDictionary *c_dict = [[NSMutableDictionary alloc] initWithDictionary:m_dict copyItems:YES];
    printf("c_dict - %p - %p\n", c_dict, &c_dict);
    for (id key in c_dict) {
        NSNumber *strKey = (NSNumber*)key;
        LDCopyTestModel *model = c_dict[strKey];
        [self print:model withKey:strKey.intValue];
    }
    printf("\n----------------------------  对NSMutableDictionary使用initWithDictionary:copyItems:对更深一层的不可变的容器类型未进行深拷贝\n");
    
    printf("\n----------------------------  [[NSDictionary alloc] initWithDictionary:m_dict copyItems:YES] （c_dict2）\n");
    // 此时dict的value必须实现NSCopy协议
    NSDictionary *c_dict2 = [[NSDictionary alloc] initWithDictionary:m_dict copyItems:YES];
    printf("c_dict2 - %p - %p\n", c_dict2, &c_dict2);
    for (id key in c_dict2) {
        NSNumber *strKey = (NSNumber*)key;
        LDCopyTestModel *model = c_dict2[strKey];
        [self print:model withKey:strKey.intValue];
    }
    
    printf("\n----------------------------  initWithDictionary: copyItems:实现的是一级对象的深拷贝\n");
}

- (void)testDictDeepCopyOp2 {
    NSMutableDictionary *m_dict = [NSMutableDictionary dictionary];
    [m_dict setObject:[LDCopyTestModel new] forKey:@1];
    [m_dict setObject:[LDCopyTestModel new] forKey:@2];
    [m_dict setObject:[LDCopyTestModel new] forKey:@3];
    [m_dict setObject:[LDCopyTestModel new] forKey:@4];
    [m_dict setObject:[LDCopyTestModel new] forKey:@5];
    
    printf("\n----------------------------  m_dict \n");
    printf("m_dict - %p - %p\n", m_dict, &m_dict);
    for (id key in m_dict) {
        NSNumber *strKey = (NSNumber*)key;
        LDCopyTestModel *model = m_dict[strKey];
        [self print:model withKey:strKey.intValue];
    }
    
    printf("\n----------------------------  NSKeyedArchiver\n此时dict的value对象，更深层的对象必须实现NSCoding协议，否则会crash\n");
    NSData *archivedData = [NSKeyedArchiver archivedDataWithRootObject:m_dict];
    NSMutableDictionary *copy_dict =  [NSKeyedUnarchiver unarchiveObjectWithData:archivedData];
    printf("copy_dict - %p - %p\n", copy_dict, &copy_dict);
    for (id key in copy_dict) {
        NSNumber *strKey = (NSNumber*)key;
        LDCopyTestModel *model = copy_dict[strKey];
        [self print:model withKey:strKey.intValue];
    }
    
    printf("\n----------------------------  NSKeyedArchiver实现了深拷贝\n");
}

- (void)testDictDeepCopyOp3 {
    NSMutableDictionary *m_dict = [NSMutableDictionary dictionary];
    [m_dict setObject:[@"bbb" dataUsingEncoding:NSUTF8StringEncoding] forKey:@"1"];
    [m_dict setObject:@"456" forKey:@"2"];
    [m_dict setObject:[NSNumber numberWithInt:456] forKey:@"3"];
    [m_dict setObject:@[@456,@456,@456,@456,@456] forKey:@"4"];
    [m_dict setObject:@{@"key":@"value"} forKey:@"5"];
    [m_dict setObject:[NSDate date] forKey:@"6"];
    
    printf("\n----------------------------  m_dict \n");
    printf("m_dict - %p - %p\n", m_dict, &m_dict);
    for (id key in m_dict) {
        printf("strKey %s - %p\n",  [(NSString *)key UTF8String], m_dict[key]);
    }
    
//    The NSPropertyListSerialization class provides methods that convert a property list to and from several serialized formats. A property list is itself an array or dictionary that contains only NSData, NSString, NSArray, NSDictionary, NSDate, and NSNumber objects.
    NSError *error = [NSError new];
    NSData *data = [NSPropertyListSerialization dataWithPropertyList:m_dict format:NSPropertyListBinaryFormat_v1_0 options:0 error:&error];
    NSMutableDictionary *copy_dict = [NSPropertyListSerialization propertyListWithData:data options:NSPropertyListMutableContainers format:NULL error:&error];
    for (id key in copy_dict) {
        printf("strKey %s - %p\n",  [(NSString *)key UTF8String], copy_dict[key]);
    }
    printf("\n----------------------------  NSPropertyListSerialization\n此时dict要遵守 A property list is itself an array or dictionary that contains only NSData, NSString, NSArray, NSDictionary, NSDate, and NSNumber objects，否则会crash\n");
    printf("\n----------------------------  NSPropertyListSerialization实现了深拷贝\n");
}

- (void)testDictDeepCopyOp4 {
    NSMutableDictionary *m_dict = [NSMutableDictionary dictionary];
    [m_dict setObject:@"456" forKey:@"2"];
    [m_dict setObject:[NSNumber numberWithInt:456] forKey:@"3"];
    [m_dict setObject:@[@456,@456,@456,@456,@456] forKey:@"4"];
    [m_dict setObject:@{@"key":@"value"} forKey:@"5"];
    
    printf("\n----------------------------  m_dict \n");
    printf("m_dict - %p - %p\n", m_dict, &m_dict);
    for (id key in m_dict) {
        printf("strKey %s - %p\n",  [(NSString *)key UTF8String], m_dict[key]);
    }
    
//    A Foundation object that may be converted to JSON must have the following properties:
//    The top level object is an NSArray or NSDictionary.
//    All objects are instances of NSString, NSNumber, NSArray, NSDictionary, or NSNull.
//    All dictionary keys are instances of NSString.
//    Numbers are not NaN or infinity.
    NSError *error = [NSError new];
    NSData *data = [NSJSONSerialization dataWithJSONObject:m_dict options:0 error:&error];
    NSMutableDictionary *copy_dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    printf("copy_dict - %p - %p\n", copy_dict, &copy_dict);
    for (id key in copy_dict) {
        printf("strKey %s - %p\n", [(NSString *)key UTF8String], copy_dict[key]);
    }
    printf("\n----------------------------  NSJSONSerialization\n此时dict的value对象只能是NSString, NSNumber, NSArray, NSDictionary, or NSNull，否则会crash\n");
    printf("\n----------------------------  NSJSONSerialization实现了深拷贝\n");
}

- (void)testDictDeepCopyOp5 {
    NSMutableDictionary *m_dict = [NSMutableDictionary dictionary];
    [m_dict setObject:[LDCopyTestModel new] forKey:@1];
    [m_dict setObject:[LDCopyTestModel new] forKey:@2];
    [m_dict setObject:[LDCopyTestModel new] forKey:@3];
    [m_dict setObject:[LDCopyTestModel new] forKey:@4];
    [m_dict setObject:[LDCopyTestModel new] forKey:@5];
    
    printf("\n----------------------------  m_dict \n");
    printf("m_dict - %p - %p\n", m_dict, &m_dict);
    for (id key in m_dict) {
        NSNumber *strKey = (NSNumber*)key;
        LDCopyTestModel *model = m_dict[strKey];
        [self print:model withKey:strKey.intValue];
    }
    
    printf("\n----------------------------  deepCopyIfCan\n此时dict的value对象，更深层的对象必须实现NSCoding协议，否则会crash\n");
    NSMutableDictionary *copy_dict =  [m_dict deepCopyIfCan];
    printf("copy_dict - %p - %p\n", copy_dict, &copy_dict);
    for (id key in copy_dict) {
        NSNumber *strKey = (NSNumber*)key;
        LDCopyTestModel *model = copy_dict[strKey];
        [self print:model withKey:strKey.intValue];
    }
    
    printf("\n----------------------------  deepCopyIfCan实现了深拷贝\n");
}

- (void)compareCost {
    printf("\n***********compareCost************\n");
    
    NSMutableDictionary *m_dict = [NSMutableDictionary dictionary];
    [m_dict setObject:[LDCopyTestModel new] forKey:@1];
    [m_dict setObject:[LDCopyTestModel new] forKey:@2];
    [m_dict setObject:[LDCopyTestModel new] forKey:@3];
    [m_dict setObject:[LDCopyTestModel new] forKey:@4];
    [m_dict setObject:[LDCopyTestModel new] forKey:@5];
    
    NSTimeInterval start = [[NSDate new] timeIntervalSince1970];
    for (int i = 0; i < COUNT; i++) {
        NSMutableDictionary *c_dict = [[NSMutableDictionary alloc] initWithDictionary:m_dict copyItems:YES];
    }
    
    printf("\n--- 耗时 %f  initWithDictionary:copyItems:实现深拷贝\n",[[NSDate new] timeIntervalSince1970] - start);
    
    start = [[NSDate new] timeIntervalSince1970];
    for (int i = 0; i < COUNT; i++) {
        NSData *archivedData = [NSKeyedArchiver archivedDataWithRootObject:m_dict];
        NSMutableDictionary *copy_dict =  [NSKeyedUnarchiver unarchiveObjectWithData:archivedData];
    }
    printf("\n--- 耗时 %f  NSKeyedArchiver实现深拷贝\n",[[NSDate new] timeIntervalSince1970] - start);
    
    start = [[NSDate new] timeIntervalSince1970];
    for (int i = 0; i < COUNT; i++) {
        NSMutableDictionary *copy_dict =  [m_dict deepCopyIfCan];
    }
    printf("\n--- 耗时 %f  deepCopyIfCan:实现深拷贝\n",[[NSDate new] timeIntervalSince1970] - start);
    
}

- (void)compareCost2 {
    
    printf("\n***********compareCost2************\n");
    
    NSMutableDictionary *m_dict = [NSMutableDictionary dictionary];
    [m_dict setObject:STRING forKey:@"2"];
    [m_dict setObject:[NSNumber numberWithInt:456] forKey:@"3"];
    [m_dict setObject:@[STRING,STRING,STRING,STRING,STRING] forKey:@"4"];
    [m_dict setObject:@{@"key":STRING} forKey:@"5"];
    
    NSTimeInterval start = [[NSDate new] timeIntervalSince1970];
    for (int i = 0; i < COUNT; i++) {
        NSMutableDictionary *c_dict = [[NSMutableDictionary alloc] initWithDictionary:m_dict copyItems:YES];
    }
    
    printf("\n--- 耗时 %f  initWithDictionary:copyItems:实现深拷贝\n",[[NSDate new] timeIntervalSince1970] - start);
    
    start = [[NSDate new] timeIntervalSince1970];
    for (int i = 0; i < COUNT; i++) {
        NSData *archivedData = [NSKeyedArchiver archivedDataWithRootObject:m_dict];
        NSMutableDictionary *copy_dict =  [NSKeyedUnarchiver unarchiveObjectWithData:archivedData];
    }
    printf("\n--- 耗时 %f  NSKeyedArchiver实现深拷贝\n",[[NSDate new] timeIntervalSince1970] - start);
    
    start = [[NSDate new] timeIntervalSince1970];
    for (int i = 0; i < COUNT; i++) {
        NSMutableDictionary *copy_dict =  [m_dict deepCopyIfCan];
    }
    printf("\n--- 耗时 %f  deepCopyIfCan:实现深拷贝\n",[[NSDate new] timeIntervalSince1970] - start);
    
    start = [[NSDate new] timeIntervalSince1970];
    for (int i = 0; i < COUNT; i++) {
        NSData *data = [NSPropertyListSerialization dataWithPropertyList:m_dict format:NSPropertyListBinaryFormat_v1_0 options:0 error:nil];
        NSMutableDictionary *copy_dict = [NSPropertyListSerialization propertyListWithData:data options:NSPropertyListMutableContainers format:NULL error:nil];
    }
    printf("\n--- 耗时 %f  NSPropertyListSerialization:实现深拷贝\n",[[NSDate new] timeIntervalSince1970] - start);
    
    start = [[NSDate new] timeIntervalSince1970];
    for (int i = 0; i < COUNT; i++) {
        NSData *data = [NSJSONSerialization dataWithJSONObject:m_dict options:0 error:nil];
        NSMutableDictionary *copy_dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    }
    printf("\n--- 耗时 %f  NSJSONSerialization:实现深拷贝\n",[[NSDate new] timeIntervalSince1970] - start);
}

- (void)print:(LDCopyTestModel *)m withKey:(int)key {
    LDCopySimpleModel *submodel = m.model;
//    printf("m_dict strKey %d - %p - %p - %p - %p\n", strKey.intValue, m, &m, submodel , &submodel);
    printf("【 [key] %d : [value] %p 】; [submodel : %p]; [array - %p]; [dict - %p]\n", key, m, submodel, m.array, m.dict);
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
