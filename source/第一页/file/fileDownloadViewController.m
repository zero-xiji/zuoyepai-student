//
//  fileViewController.m
//  作业派-学生端
//
//  Created by zero on 2018/4/7.
//  Copyright © 2018年 zero. All rights reserved.
//

#import "fileDownloadViewController.h"
#import "fileViewController.h"
#import <WebKit/WebKit.h>
//#define KFileBoundary @"fanlu"
//#define KNewLine @"\r\n"
//#define KEncode(str) [str dataUsingEncoding:NSUTF8StringEncoding]
@interface fileDownloadViewController ()<WKNavigationDelegate>

@end

@implementation fileDownloadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    WKWebView *webView = [[WKWebView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    //****************注*********************
    webView.navigationDelegate = self;
    [_main_view addSubview:webView];
    NSString *urlString = [NSString stringWithFormat:@"http://193.112.2.154:7079/SSHtet/download?file_name=%@",select_file_message.file_name];
    NSLog(@"%@", urlString);
    NSCharacterSet *encodeSet = [NSCharacterSet URLQueryAllowedCharacterSet];
    NSString *urlstringEncode = [urlString stringByAddingPercentEncodingWithAllowedCharacters:encodeSet];
    NSURL *url =[NSURL URLWithString:urlstringEncode];
    // 2.创建一个POST请求
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = @"POST";
    [webView loadRequest:request];
//    [webView loadRequest:request];
    // Do any additional setup after loading the view.
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated
{
    _my_bar.topItem.title=select_file_message.file_name;
    NSLog(@"this is download");
}
- (IBAction)back:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)is_download:(id)sender {
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"确定要下载该文件吗？" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *is_download_yes = [UIAlertAction actionWithTitle:@"下载" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"下载");
        [self download_from_url];
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alertController addAction:is_download_yes];
    [alertController addAction:cancelAction];
    [self presentViewController:alertController animated:YES completion:nil];
}

-(void)download_from_url
{
    NSString *urlString = [NSString stringWithFormat:@"http://193.112.2.154:7079/SSHtet/download?file_name=%@",select_file_message.file_name];
    NSCharacterSet *encodeSet = [NSCharacterSet URLQueryAllowedCharacterSet];
    NSString *urlstringEncode = [urlString stringByAddingPercentEncodingWithAllowedCharacters:encodeSet];
    NSURL *url_file =[NSURL URLWithString:urlstringEncode];
    NSData *data= [NSData dataWithContentsOfURL:url_file];
    NSString *str =[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"%@",str);// NSData写入文件
    
    // 获取Documents目录
    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSLog(@"%@", docPath);
    NSString *strPath =[NSString stringWithFormat:@"%@/%@", docPath, select_file_message.file_name];
    NSLog(@"%@", strPath);
    // 创建一个存放NSData数据的路径
    [data writeToFile:strPath atomically:YES];
    
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle:@"完成下载" message:[NSString stringWithFormat:@"地址为：%@",docPath] preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *yesAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
    [alertController addAction:yesAction];
    [self presentViewController:alertController animated:YES completion:nil];

}
@end

