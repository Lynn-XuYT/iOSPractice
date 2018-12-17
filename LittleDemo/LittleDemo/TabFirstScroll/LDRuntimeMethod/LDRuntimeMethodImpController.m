//
//  LDRuntimeMethodImpController.m
//  LittleDemo
//
//  Created by Lynn on 2018/8/2.
//  Copyright © 2018年 Lynn. All rights reserved.
//

#import "LDRuntimeMethodImpController.h"
#import <objc/runtime.h>

@interface LDRuntimeMethodImpController ()

@property (nonatomic, assign) int type;

@property (nonatomic, strong) UILabel *textLabel;
@property (nonatomic, strong) Person *person;
@property (nonatomic, strong) Man *man;
@end

@implementation LDRuntimeMethodImpController

- (instancetype)initWithType:(int)type
{
    self = [self init];
    if (self) {
        _type = type;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.textLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 64, SCREEN_WIDTH - 20, SCREEN_HEIGHT - 64)];
    self.textLabel.textColor = [UIColor blackColor];
    self.textLabel.numberOfLines = 0;
    [self.view addSubview:self.textLabel];
    
    _man = [Man new];
    _man.name = @"lilei";
    _man.age = 16;
    _man.sex = @"male";
    _man.manString1 = @"manString1";
    _man.manString2 = @"manString2";
    _man.manString3 = @"manString3";
    
    _person = [Person new];
    _person.name = @"Lynn";
    _person.age = 16;
    _person.sex = @"female";
    
    switch (_type) {
        case 1:
            [self modifyProperty];
            break;
        case 2:
            [self addProperty];
            break;
        case 3:
            [self addMethod];
            break;
        case 4:
            [self SwitchMethod];
            break;
        case 5:
            [self SwitchMethod2];
            break;
        case 6:
            [self methodAddition];
            break;
        case 7:
            [self archive];
            break;
        case 8:
            [self dictToModel];
            break;
        default:
            break;
    }
    
    //1.确定请求路径
    NSURL *url = [NSURL URLWithString:@"http://www.baidu.com"];
    
    //2.创建请求对象
    //请求对象内部默认已经包含了请求头和请求方法（GET）
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    //3.获得会话对象
    NSURLSession *session = [NSURLSession sharedSession];
    
    //4.根据会话对象创建一个Task(发送请求）
    __block uint64_t start = 0;
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSNumber *cost = [NSNumber numberWithUnsignedLongLong:([[NSDate date] timeIntervalSince1970] * 1000 - start)];
        NSLog(@"lynne - %@",cost);
        
        if (error == nil) {
            //6.解析服务器返回的数据
            //说明：（此处返回的数据是JSON格式的，因此使用NSJSONSerialization进行反序列化处理）
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
            
            NSLog(@"%@",dict);
        }
    }];
    
    //5.执行任务
    [dataTask resume];
    start = [[NSDate date] timeIntervalSince1970] * 1000;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self becomeFirstResponder]; //设置为第一响应者
    UIMenuController *menu = [UIMenuController sharedMenuController];
    [menu setTargetRect:CGRectMake(20, 30, 200, 20) inView:self.view];
    // 定义两个菜单a和b
    UIMenuItem *a = [[UIMenuItem alloc] initWithTitle:@"aaaaaaaa"
                                               action:@selector(paste:)];
    UIMenuItem *b = [[UIMenuItem alloc] initWithTitle:@"bbbbbbbb"
                                               action:@selector(copy)];
    // 自定义菜单添加到菜单栏中
    menu.menuItems = @[a,b,b,b,b,b,b];
    menu.menuVisible = YES;
}

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
    if (action == @selector(paste:))
    {
        return YES;
    } else if (action == @selector(cut:))
    {
        return YES;
    }
    else{
        return NO;
    }
}

- (BOOL)canBecomeFirstResponder
{
    return YES;
}

- (void)paste:(id)sender
{
    
}

- (void)cut:(id)sender
{
    
}

- (void)modifyProperty
{
    self.title = @"更改属性值";
    
    
    unsigned int count = 0;
    Ivar *ivar = class_copyIvarList(_man.class, &count);// 包括 共有属性，私有属性，变量。 但不包括父类的属性
    self.textLabel.text = @"modifyProperty";
    for (int i = 0; i < count; i++) {
        Ivar tempIvar = ivar[i];
        id obj = object_getIvar(_man, tempIvar); // 获取属性值（对象的）
        const char *varChar = ivar_getName(tempIvar);
        NSString *varString = [NSString stringWithUTF8String:varChar];
        self.textLabel.text = [NSString stringWithFormat:@"%@\n %d -- %@ = %@", self.textLabel.text, i, varString, obj];
        if ([varString isEqualToString:@"_manString1"]) {
            // 修改对应的字段
            object_setIvar(_man, tempIvar, @"更改属性值");
            obj = object_getIvar(_man, tempIvar);
            self.textLabel.text = [NSString stringWithFormat:@"%@\n更改属性值\n %d -- %@ = %@", self.textLabel.text, i, varString, obj];
        }
    }
}

- (void)addProperty
{
    self.title = @"动态添加属性";
    unsigned int count = 0;
    _person.desp = @"I am happy";
    
    Ivar *ivar = class_copyIvarList(_person.class, &count);
    self.textLabel.text = @"addProperty";
    for (int i = 0; i < count; i++) {
        Ivar tempIvar = ivar[i];
        const char *type = ivar_getTypeEncoding(tempIvar);  // 获取属性类型
        const char *varChar = ivar_getName(tempIvar);       // 获取属性名
        id value = [_person valueForKey:[NSString stringWithUTF8String:varChar]];         // 获取属性值
        
        self.textLabel.text = [NSString stringWithFormat:@"%@\n %d - 属性类型: %s;\n 属性名: %s = %@(属性值)\n",
                               self.textLabel.text, i, type, varChar, value];
    }
    
    self.textLabel.text = [NSString stringWithFormat:@"%@\n\n ------- 分隔线 ------\n",
                           self.textLabel.text];
    
    objc_property_t *properts = class_copyPropertyList(_person.class, &count);
    
    for (int i = 0; i < count; i++) {
        objc_property_t tempIvar = properts[i];
        const char *type = property_getAttributes(tempIvar);    // 获取属性类型
        const char *varChar = property_getName(tempIvar);       // 获取属性名
        id value = [_person valueForKey:[NSString stringWithUTF8String:varChar]];         // 获取属性值
        
        self.textLabel.text = [NSString stringWithFormat:@"%@\n %d - 属性类型: %s; \n属性名: %s = %@(属性值)\n",
                               self.textLabel.text, i, type, varChar, value];
    }
}

- (void)addMethod
{
    self.title = @"动态添加方法";
    
    self.textLabel.text = @"添加前的方法列表：\n";
    self.textLabel.text = [NSString stringWithFormat:@"%@\n%@", self.textLabel.text,[self getMethodList]];
    
    class_addMethod([_person class], @selector(printEx), (IMP)(printExADD), "v@:");
    
    if ([_person respondsToSelector:@selector(printEx)]) {
        [_person performSelector:@selector(printEx)];
        
    }
    self.textLabel.text = [NSString stringWithFormat:@"\n%@\n添加后的方法列表：\n\n%@", self.textLabel.text,[self getMethodList]];
}

void printExADD(id self, SEL _cmd)
{
    NSLog(@"hahah");
}

- (void)SwitchMethod
{
    self.title = @"交换方法的实现";
    
    self.textLabel.text = [NSString stringWithFormat:@"交换方法的实现前：\n name : %@, age : %ld, sex : %@", _person.name, (long)_person.age, _person.sex];
    Method method1 = class_getInstanceMethod(_person.class, @selector(name));
    Method method2 = class_getInstanceMethod(_person.class, @selector(sex));
    method_exchangeImplementations(method1, method2);
    
    self.textLabel.text = [NSString stringWithFormat:@"%@\n\n交换方法的实现后：\n name : %@, age : %ld, sex : %@",self.textLabel.text, _person.name, (long)_person.age, _person.sex];
    
}

- (void)SwitchMethod2
{
    self.title = @"拦截并替换方法";
    
    self.textLabel.text = [NSString stringWithFormat:@"交换方法的实现前：\n _person name : %@, [self test] :%@", _person.name, [self test]];
    
    Method method1 = class_getInstanceMethod(_person.class, @selector(name));
    Method method2 = class_getInstanceMethod(self.class, @selector(test));
    
    method_exchangeImplementations(method1, method2);
    
    self.textLabel.text = [NSString stringWithFormat:@"%@\n\n交换方法的实现后：\n _person name : %@, [self test] :%@", self.textLabel.text, _person.name, [self test]];
}

- (void)methodAddition
{
    self.title = @"动态增加属性";
}

- (void)archive
{
    self.title = @"归档解档";
    
    self.textLabel.text = [NSString stringWithFormat:@"归档前：\n%@\n",_man];
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:_man];
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"data"];
    
    
    data = [[NSUserDefaults standardUserDefaults] objectForKey:@"data"];
    id man = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    self.textLabel.text = [NSString stringWithFormat:@"%@\n解档后：\n%@\n",self.textLabel.text, man];
}

- (void)dictToModel
{
    self.title = @"字典转模型";
    NSDictionary *dict = @{@"name":@"tian",
                           @"age":@"12",
                           @"personString4":@"hahah"};
    Person *p = [Person dictToModel:dict];
    self.textLabel.text = [NSString stringWithFormat:@"dict:\n%@\n\nmodel:\n%@",dict, p];
    
    NSMutableArray *array = [NSMutableArray array];
    NSString *s1 = @"nil";
    NSString *s2 = @"nil";
    NSString *s3 = nil;
    NSString *s4 = @"nil";
    [array addObjectsFromArray:@[s1,s2,s3,s4]];
    
    NSLog(@"%@",array);
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSString *)getMethodList
{
    NSMutableString *mstr = [NSMutableString string];
    
    unsigned int methodCount =0;
    Method* methodList = class_copyMethodList([_person class],&methodCount);
    NSMutableArray *methodsArray = [NSMutableArray arrayWithCapacity:methodCount];
    
    for(int i = 0; i < methodCount; i++)
    {
        Method temp = methodList[i];
//        IMP imp = method_getImplementation(temp);
//        SEL name_f = method_getName(temp);
        const char* name_s = sel_getName(method_getName(temp));
        int arguments = method_getNumberOfArguments(temp);
        const char* encoding = method_getTypeEncoding(temp);//编码方式
        
        NSString *tmp = [NSString stringWithFormat:@"方法名:%@; 参数个数:%d",
                         [NSString stringWithUTF8String:name_s],
                         arguments];
        [mstr appendFormat:@"%@\n",tmp];
        [methodsArray addObject:[NSString stringWithUTF8String:name_s]];
    }
    return mstr;
}


- (NSString *)test
{
    return @"i am a method of controller";
}

@end

@interface Person ()
{
    NSString *_personString4;
}
@property (nonatomic, strong) NSString *personString5;
@end

@implementation Person

- (NSString *)description
{
    return [NSString stringWithFormat:@"name=%@; age=%ld; sex=%@; _personString4=%@; personString5=%@",self.name,(long)self.age,self.sex,_personString4,self.personString5];
}

+ (Person *)dictToModel:(NSDictionary *)dic
{
//    id myObj = [[self alloc] init];
//    unsigned int count = 0;
//    Ivar *ivarlist = class_copyIvarList(self.class, &count);
//    for (int i = 0; i < count; i++) {
//        Ivar temp = ivarlist[i];
//        const char *varChar = ivar_getName(temp);
//        NSString *varString = [NSString stringWithUTF8String:varChar];
//        id value = [dict objectForKey:varString];
//        if (value) {
//            object_setIvar(myObj, temp, value);
//        }
//    }
//    return myObj;
    
    id myObj = [[self alloc] init];
    
    unsigned int outCount;
    
    //获取类中的所有成员属性
    objc_property_t *arrPropertys = class_copyPropertyList([self class], &outCount);
    
    for (NSInteger i = 0; i < outCount; i ++) {
        objc_property_t property = arrPropertys[i];
        
        //获取属性名字符串
        //model中的属性名
        NSString *propertyName = [NSString stringWithUTF8String:property_getName(property)];
        id propertyValue = dic[propertyName];
        
        if (propertyValue != nil) {
            [myObj setValue:propertyValue forKey:propertyName];
        }
    }
    
    free(arrPropertys);
    
    return myObj;
}

@end


@interface Man ()
{
    NSString *_manString4;
}
@property (nonatomic, strong) NSString *manString5;
@end

@implementation Man

- (NSString *)description
{
    return [NSString stringWithFormat:@"name=%@; age=%ld; sex=%@; manString1=%@; manString2=%@; manString3=%@; manString4=%@; manString5=%@",self.name,(long)self.age,self.sex,self.manString1,self.manString2,self.manString3,_manString4,self.manString5];
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    unsigned int count = 0;
    objc_property_t *properts = class_copyPropertyList(self.class, &count);
    for (int i = 0; i < count; i++) {
        objc_property_t property = properts[i];
//        const char *type = property_getAttributes(property);    // 获取属性类型
        const char *varChar = property_getName(property);       // 获取属性名
        NSString *key = [NSString stringWithUTF8String:varChar];
        id value = [self valueForKey:key];         // 获取属性值
        [aCoder encodeObject:value forKey:key];
    }
}

- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        unsigned int count = 0;
        objc_property_t *properts = class_copyPropertyList(self.class, &count);
        for (int i = 0; i < count; i++) {
            objc_property_t property = properts[i];
//            const char *type = property_getAttributes(property);    // 获取属性类型
            const char *varChar = property_getName(property);       // 获取属性名
            NSString *key = [NSString stringWithUTF8String:varChar];
            // 进行解档取值
            id value = [aDecoder decodeObjectForKey:key];         // 获取属性值
            [self setValue:value forKey:key];
        }
    }
    return self;
}
@end

@implementation Women
@end

@implementation Person (Addtion)

- (void)setDesp:(NSString *)desp
{
    objc_setAssociatedObject(self, @"desp", desp, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSString *)desp
{
    return objc_getAssociatedObject(self, @"desp");
    
}
@end

