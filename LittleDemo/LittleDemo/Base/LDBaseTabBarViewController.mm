//
//  LDBaseTabBarViewController.m
//  LittleDemo
//
//  Created by Lynn on 2018/3/12.
//  Copyright © 2018年 Lynn. All rights reserved.
//

#import "LDBaseTabBarViewController.h"
#import <objc/runtime.h>
#import "LDTabBarView.h"
#import "LittleDemo-Swift.h"
@interface LDBaseTabBarViewController ()

@end

@implementation LDBaseTabBarViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (instancetype)initWithTittle:(NSString *)title imageName:(NSString *)imageName
{
    self = [super init];
    if (self)
    {
        /*
        UITabBarItem *childItem = [[UITabBarItem alloc] initWithTitle:title image:[UIImage imageNamed:imageName] tag:1];
        childItem.image = [[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        childItem.selectedImage = [[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        self.tabBarItem = childItem;
        self.tabBarItem.title = title;
      */
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (self.tabBar.hidden == NO) {
        for (UIView *view in self.tabBar.subviews) {
            if (![view isKindOfClass:[LDTabBarView class]]) {
                // 移除tabBar上所有的子控件
                [view removeFromSuperview];
            }
        }
    }
    /*
     // TEST
    NSString *str = @"hahahahah";
    NSData *data1 = [str dataUsingEncoding:NSUTF8StringEncoding];
    long len = [data1 length];
    
    NSMutableData *data = [[NSMutableData alloc] init];
    if(len > 0){
        char prefix[4] = {0};
        int length = htonl(len + 4);
        memcpy(prefix, &length, 4);
        
        [data appendBytes:prefix length:4];
        [data appendData:data1];
    }
    
    unsigned char * pWup = (unsigned char*)[data bytes];
    
    int wupLen = 0;
    GetInt32Ptr(&wupLen, (unsigned char*)pWup);
    if (0 > wupLen || 100000 < wupLen) {
        NSLog(@"error");
        return;
    }
     */
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    for (UIView *view in self.tabBar.subviews) {
        if (![view isKindOfClass:[LDTabBarView class]]) {
            // 移除tabBar上所有的子控件
            [view removeFromSuperview];
        }
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
//    [self performSelector:@selector(eat:) withObject:nil afterDelay:0];
}

#pragma mark - test
+(BOOL)resolveInstanceMethod:(SEL)sel
{
    if (sel == @selector(eat:)) {
        class_addMethod(self, sel, (IMP)aaaa , "v@:@");
        return YES;
    }
    return [super resolveInstanceMethod:sel];
}

void aaaa(id self ,SEL _cmd,id Num)
{
    // 实现内容
//    NSLog(@"%@的%@方法动态实现了,参数为%@",self,NSStringFromSelector(_cmd),Num);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

void GetInt32Ptr(int *to, unsigned char * from)
{
    *(unsigned char*)(to) = *(from + 3);
    *((unsigned char*)(to)+1) = *(from+2);
    *((unsigned char*)(to)+2) = *(from + 1);
    *((unsigned char*)(to)+3) = *from;
}

@end
