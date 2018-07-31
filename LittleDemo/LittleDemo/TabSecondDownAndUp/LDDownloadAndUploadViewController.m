//
//  LDDownloadAndUploadViewController.m
//  LittleDemo
//
//  Created by Lynn on 2018/3/8.
//  Copyright © 2018年 Lynn. All rights reserved.
//

#import "LDDownloadAndUploadViewController.h"
#import <AddressBookUI/AddressBookUI.h>
#import <Contacts/Contacts.h>
#import <Photos/Photos.h>
#import <Foundation/Foundation.h>
#import "LDFileListViewController.h"

#define Kboundary  @"----WebKitFormBoundaryjh7urS5p3OcvqXAT"
#define KNewLine [@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]

//#define IP_ADDRESS @"10.73.154.110"
#define IP_ADDRESS @"192.168.0.184"
@interface LDDownloadAndUploadViewController ()<UIImagePickerControllerDelegate, UINavigationControllerDelegate, NSURLSessionDataDelegate>
@property (nonatomic, strong) NSString *filePath;
@property (nonatomic, strong) NSString *imgFilePath;

@end

@implementation LDDownloadAndUploadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    [self.tabBarController setHidesBottomBarWhenPushed:YES];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self initSubViews];
}

#pragma mark - 文件下载列表
- (void)downloadFileList
{
    LDFileListViewController * vc = [LDFileListViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - 文件下载
//- (void)downloadFile{
//
//    NSString *urlStr = [NSString stringWithFormat:@"http://%@:8888/get_file?fname=newfilename",IP_ADDRESS]; ;
//
//    urlStr = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//
//    NSURL *url = [NSURL URLWithString:urlStr];
//
//    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
//
//    NSURLSession *session = [NSURLSession sharedSession];
//
//    NSURLSessionDownloadTask *downloadTask = [session downloadTaskWithRequest:request completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
//
//        if (!error) {
//
//            NSError *saveError;
//
//            NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
//
//            NSTimeInterval time = [[NSDate date] timeIntervalSince1970]*1000;
//            NSString * uniqueString = [NSString stringWithFormat:@"%d",(int)time];
//            NSString *savePath = [cachePath stringByAppendingPathComponent:uniqueString];
//
//            NSURL *saveUrl = [NSURL fileURLWithPath:savePath];
//
//            //把下载的内容从cache复制到document下
//
//            [[NSFileManager defaultManager] copyItemAtURL:location toURL:saveUrl error:&saveError];
//
//            if (!saveError) {
//
//                NSLog(@"save success");
//                dispatch_async(dispatch_get_main_queue(), ^{
//                    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"save success" message:[NSString stringWithFormat:@"保存路径：%@",saveUrl] preferredStyle:UIAlertControllerStyleAlert];
//                    UIAlertAction *actionCancle = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
//                        [alertController dismissViewControllerAnimated:YES completion:nil];
//                    }];
//                    UIAlertAction *actionOK = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//                        [alertController dismissViewControllerAnimated:YES completion:nil];
//                    }];
//                    [alertController addAction:actionCancle];
//                    [alertController addAction:actionOK];
//                    [self presentViewController:alertController animated:YES completion:nil];
//                });
//                // 从路径中获取NSData对象
//                NSData *data2 = [NSData dataWithContentsOfFile:savePath];
//
//                // iOS中的解档类是NSKeyedUnarchiver，作用是：将NSData对象还原成原本的复杂对象
//                NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data2];
//                [unarchiver setRequiresSecureCoding:YES];
//
//                // 解档
//                NSString *key2 = @"contact1";
//                NSSet *set = [[NSSet alloc] initWithObjects:[NSArray class],[CNContact class], nil];
//                NSArray *contacts = [unarchiver decodeObjectOfClasses:set forKey:key2];
//                [unarchiver finishDecoding];
//
//                for (CNContact *contact in contacts)
//                {
//                    CNMutableContact *mcontact = [[CNMutableContact alloc] init];
//                    mcontact.givenName = contact.givenName;
//                    mcontact.familyName = contact.familyName;
//                    mcontact.phoneNumbers = contact.phoneNumbers;
//                    //    //初始化方法
//                    CNSaveRequest * saveRequest = [[CNSaveRequest alloc]init];
//                    //    添加联系人（可以）
//                    [saveRequest addContact:(CNMutableContact *)mcontact toContainerWithIdentifier:nil];
//                    //    写入
//                    CNContactStore * store = [[CNContactStore alloc]init];
//                    BOOL flag = [store executeSaveRequest:saveRequest error:nil];
//                    if (!flag)
//                    {
//                        break;
//                    }
//                }
//            }
//        }
//    }];
//
//    [downloadTask resume];
//
//}

#pragma mark - 图片上传
- (void)getImageFromIpc
{
    // 1.判断相册是否可以打开
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) return;
    // 2. 创建图片选择控制器
    UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
    /**
     typedef NS_ENUM(NSInteger, UIImagePickerControllerSourceType) {
     UIImagePickerControllerSourceTypePhotoLibrary, // 相册
     UIImagePickerControllerSourceTypeCamera, // 用相机拍摄获取
     UIImagePickerControllerSourceTypeSavedPhotosAlbum // 相簿
     }
     */
    // 3. 设置打开照片相册类型(显示所有相簿)
    ipc.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    // ipc.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    // 照相机
    // ipc.sourceType = UIImagePickerControllerSourceTypeCamera;
    // 4.设置代理
    ipc.delegate = self;
    // 5.modal出这个控制器
    [self presentViewController:ipc animated:YES completion:nil];
}

#pragma mark -- <UIImagePickerControllerDelegate>--
// 获取图片后的操作
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    // 销毁控制器
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    NSString *caches =
    NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
    _imgFilePath = [caches stringByAppendingPathComponent:@"pic.png"];
    // 将UIImage对象转换成NSData对象
    NSData *data = UIImageJPEGRepresentation(info[UIImagePickerControllerOriginalImage], 0);
    [data writeToFile:_imgFilePath atomically:YES];
    
    //    // 从文件读取存储的NSData数据
    //    NSData *resultData = [NSData dataWithContentsOfFile:_imgFilePath];
    //    // 将得到的NSData数据转换成原有的图片对象
    //    UIImage *resultImage = [UIImage imageWithData:resultData];
    //    UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    //    imageView.image = resultImage;

    [self uploadBody:@"Content-Disposition: form-data; name=\"myfile\"; filename=\"123.png\"" contentType:@"Content-Type: image/png" filePath:_imgFilePath];
}

- (void)getPic
{
    //获取相册访问权限
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
        dispatch_async(dispatch_get_main_queue(), ^{
            switch (status) {
                case PHAuthorizationStatusAuthorized: //已获取权限
                    [self getImageFromIpc];
                    break;
                    
                case PHAuthorizationStatusDenied: //用户已经明确否认了这一照片数据的应用程序访问
                    break;
                    
                case PHAuthorizationStatusRestricted://此应用程序没有被授权访问的照片数据。可能是家长控制权限
                    break;
                    
                default://其他。。。
                    break;
            }
        });
    }];
}

#pragma mark - 文件上传
- (void)uploadAllContactList
{
    //1. 获取授权状态
    CNContactStore * store = [[CNContactStore alloc] init];
    
    __block NSMutableArray *array = [NSMutableArray array];
    [store requestAccessForEntityType:CNEntityTypeContacts completionHandler:^(BOOL granted, NSError * _Nullable error) {
        if (granted) {
            // 授权成功
            CNContactFetchRequest * request = [[CNContactFetchRequest alloc] initWithKeysToFetch:@[CNContactGivenNameKey, CNContactFamilyNameKey, CNContactPhoneNumbersKey]];
            [store enumerateContactsWithFetchRequest:request error:nil usingBlock:^(CNContact * _Nonnull contact, BOOL * _Nonnull stop) {
                [array addObject:contact];
            }];
            NSMutableData *data = [NSMutableData data];
            // 创建归档工具
            NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
            [archiver setRequiresSecureCoding:YES];
            // 归档
            NSString *key =@"contact1";
            [archiver encodeObject:array forKey:key];
            // 结束
            [archiver finishEncoding];
            
            // 写入沙盒
            BOOL flag = [data writeToFile:self.filePath atomically:YES];
            if (flag)
            {
                NSLog(@"hahah");
                
            }
            [self uploadBody:@"Content-Disposition: form-data; name=\"myfile\"; filename=\"1233\"" contentType:@"Content-Type: application/octet-stream" filePath:self.filePath];
        }else{
            // 授权失败
        }
    }];
}

#pragma mark - 添加子视图
- (void)initSubViews
{
    // 拼音写入沙盒路径
    NSString *caches =
    NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
    _filePath = [caches stringByAppendingPathComponent:@"contact"];
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 200, 40)];
    [btn setTitle:@"文件上传" forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor blueColor];
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(uploadAllContactList) forControlEvents:(UIControlEventTouchUpInside)];
    
    UIButton *btn2 = [[UIButton alloc] initWithFrame:CGRectMake(100, 180, 200, 40)];
    [btn2 setTitle:@"图片上传" forState:UIControlStateNormal];
    btn2.backgroundColor = [UIColor blueColor];
    [self.view addSubview:btn2];
    [btn2 addTarget:self action:@selector(getPic) forControlEvents:(UIControlEventTouchUpInside)];
    
//    UIButton *btn3 = [[UIButton alloc] initWithFrame:CGRectMake(100, 260, 200, 40)];
//    [btn3 setTitle:@"文件下载" forState:UIControlStateNormal];
//    btn3.backgroundColor = [UIColor blueColor];
//    [self.view addSubview:btn3];
//    [btn3 addTarget:self action:@selector(downloadFile) forControlEvents:(UIControlEventTouchUpInside)];
    
    UIButton *btn4 = [[UIButton alloc] initWithFrame:CGRectMake(100, 260, 200, 40)];
    [btn4 setTitle:@"文件下载列表" forState:UIControlStateNormal];
    btn4.backgroundColor = [UIColor blueColor];
    [self.view addSubview:btn4];
    [btn4 addTarget:self action:@selector(downloadFileList) forControlEvents:(UIControlEventTouchUpInside)];
}


#pragma mark - 网络
-(void)uploadBody:(NSString *)cmd contentType:(NSString *)contentType filePath:(NSString *)filePath
{
    //01 确定请求路径
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://%@:8888/upload",IP_ADDRESS]];
    
    //02 创建"可变"请求对象
    NSMutableURLRequest *request  =[NSMutableURLRequest requestWithURL:url];
    
    //03 修改请求方法"POST"
    request.HTTPMethod = @"POST";
    
    //'设置请求头:告诉服务器这是一个文件上传请求,请准备接受我的数据
    //Content-Type:multipart/form-data; boundary=分隔符
    NSString *headerStr = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",Kboundary];
    
    [request setValue:headerStr forHTTPHeaderField:@"Content-Type"];
    //04 拼接参数-(设置请求体)
    //'按照固定的格式来拼接'
    NSData *data = [self getBody:cmd contentType:@"Content-Type: application/octet-stream" filePath:filePath];// [self getBodyDataContacts];
    //!!!! request.HTTPBody = data;
    
    //05 创建会话对象
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    
    //06 根据会话对象创建uploadTask请求
    /*
     第一个参数:请求对象
     第二个参数:要传递的是本应该设置为请求体的参数
     第三个参数:completionHandler 当上传完成的时候调用
     data:响应体
     response:响应头信息
     */
    NSURLSessionUploadTask *uploadTask = [session uploadTaskWithRequest:request fromData:data completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        // 08 解析服务器返回的数据
        NSLog(@"%@",[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding]);
        dispatch_async(dispatch_get_main_queue(), ^{
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"上传成功" message:nil preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *actionCancle = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                [alertController dismissViewControllerAnimated:YES completion:nil];
            }];
            UIAlertAction *actionOK = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [alertController dismissViewControllerAnimated:YES completion:nil];
            }];
            [alertController addAction:actionCancle];
            [alertController addAction:actionOK];
            [self presentViewController:alertController animated:YES completion:nil];
        });
    }];
    
    //07 发送请求
    [uploadTask resume];
}

- (NSData *)getBody:(NSString *)cmd contentType:(NSString *)contentType filePath:(NSString *)filePath
{
    NSMutableData *data = [NSMutableData data];
    
    //01 文件参数
    /*
     --分隔符
     Content-Disposition: form-data; name="file"; filename="Snip20160716_103.png"
     Content-Type: image/png
     空行
     文件数据
     */
    
    [data appendData:[[NSString stringWithFormat:@"--%@",Kboundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [data appendData:KNewLine];
    //file 文件参数 参数名 == username
    //filename 文件上传到服务器之后以什么名称来保存
    [data appendData:[cmd dataUsingEncoding:NSUTF8StringEncoding]];
    [data appendData:KNewLine];
    
    //Content-Type 文件的数据类型
    [data appendData:[contentType dataUsingEncoding:NSUTF8StringEncoding]];
    [data appendData:KNewLine];
    [data appendData:KNewLine];
    NSData *filedata = [NSData dataWithContentsOfFile:filePath];
    [data appendData:filedata];
    [data appendData:KNewLine];
    
    //02 非文件参数
    /*
     --分隔符
     Content-Disposition: form-data; name="username"
     空行
     xiaomage
     */
    [data appendData:[[NSString stringWithFormat:@"--%@",Kboundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [data appendData:KNewLine];
    //username 参数名称
    [data appendData:[@"Content-Disposition: form-data; name=\"username\"" dataUsingEncoding:NSUTF8StringEncoding]];
    [data appendData:KNewLine];
    [data appendData:KNewLine];
    [data appendData:[@"xiaomage" dataUsingEncoding:NSUTF8StringEncoding]];
    [data appendData:KNewLine];
    
    //03 结尾标识
    /*
     --分隔符--
     */
    [data appendData:[[NSString stringWithFormat:@"--%@--",Kboundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    //拼接
    return data;
}

#pragma mark NSURLSessionDataDelegate
/*
 bytesSent:本次上传的数据大小
 totalBytesSent:已经上传数据的总大小
 totalBytesExpectedToSend:文件的总大小
 */
-(void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didSendBodyData:(int64_t)bytesSent totalBytesSent:(int64_t)totalBytesSent totalBytesExpectedToSend:(int64_t)totalBytesExpectedToSend
{
    NSLog(@"%f",1.0 * totalBytesSent /totalBytesExpectedToSend);
}

@end
