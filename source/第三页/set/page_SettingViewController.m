//
//  page_SettingViewController.m
//  作业派-学生端
//
//  Created by zero on 2018/2/27.
//  Copyright © 2018年 zero. All rights reserved.
//

#import "page_SettingViewController.h"
#import "loginViewController.h"
@interface page_SettingViewController ()

@end

@implementation page_SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
- (IBAction)back:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];

}

- (IBAction)update_password:(id)sender {
    if([this_user_.THIS_USER_IS_LOGIN isEqual: @"1"])
    {
        UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"修改密码" message:@"" preferredStyle:UIAlertControllerStyleAlert];
        [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull old_password) {
            old_password.placeholder=@"旧密码";
            old_password.secureTextEntry=YES;
        }];
        [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull new_password) {
            new_password.placeholder=@"新密码";
            new_password.secureTextEntry=YES;
        }];
        [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull new_password_again) {
            new_password_again.placeholder=@"再次输入密码";
            new_password_again.secureTextEntry=YES;
        }];
        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            UITextField *old_password = alert.textFields.firstObject;
            UITextField *new_password = alert.textFields[1];
            UITextField *new_password_again = alert.textFields.lastObject;
            NSLog(@"old_password = %@",old_password.text);
            NSLog(@"new_password = %@",new_password.text);
            NSLog(@"new_password_again = %@",new_password_again.text);
            if(![old_password.text isEqualToString:(this_user_.THIS_STUDENT_USER_PASSWORD)])
            {
                UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"提示" message:@"原密码错误！" preferredStyle:UIAlertControllerStyleAlert];
                [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
                [self presentViewController:alert animated:true completion:nil];
            }
            else if(![new_password.text isEqualToString:( new_password_again.text )])
            {
                UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"提示" message:@"两次输入的新密码不一致！" preferredStyle:UIAlertControllerStyleAlert];
                [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
                [self presentViewController:alert animated:true completion:nil];
            }
            else if(new_password.text.length<8)
            {
                UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"提示" message:@"密码小于8位" preferredStyle:UIAlertControllerStyleAlert];
                [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
                [self presentViewController:alert animated:true completion:nil];
            }
            else
            {
                NSLog(@"new_password.text = %@",new_password.text);
                UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"提示" message:@"确定要修改吗！" preferredStyle:UIAlertControllerStyleAlert];
                [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action)
                                  {
                                      NSString *urlString = [NSString stringWithFormat:@"http://193.112.2.154:7079/SSHtet/user_update?table=student&user_name=%@&password=%@&touxiang=%@",this_user_.THIS_STUDENT_USER_NAME,new_password.text,this_user_.THIS_STUDENT_USER_TOUXIANG];
                                      NSCharacterSet *encodeSet = [NSCharacterSet URLQueryAllowedCharacterSet];
                                      NSString *urlstringEncode = [urlString stringByAddingPercentEncodingWithAllowedCharacters:encodeSet];
                                      NSURL *url =[NSURL URLWithString:urlstringEncode];
                                      NSData *data_STUDENT= [NSData dataWithContentsOfURL:url];
                                      NSString *set_text=[[NSString alloc]initWithData:data_STUDENT encoding:NSUTF8StringEncoding];
                                      if([set_text isEqual:@"更改成功!"])
                                      {
                                          UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"提示" message:@"更改成功!" preferredStyle:UIAlertControllerStyleAlert];
                                          [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                                              [self set_logout_user];
                                              [self dismissViewControllerAnimated:YES completion:nil];
                                          }]];
                                          [self presentViewController:alert animated:true completion:nil];
                                      }
                                  }]];
                [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil]];
                [self presentViewController:alert animated:true completion:nil];
                
            }
        }]];
        [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil]];
        [self presentViewController:alert animated:true completion:nil];
    }
    else
    {
        UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"提示" message:@"尚未登录！" preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self dismissViewControllerAnimated:YES completion:nil];
        }]];
        [self presentViewController:alert animated:true completion:nil];
    }
}
-(void)set_logout_user
{
    this_user_.THIS_USER_IS_LOGIN=@"0";
    this_user_.THIS_STUDENT_USER_NAME=nil;
    this_user_.THIS_STUDENT_USER_ID=nil;
    this_user_.THIS_STUDENT_USER_PASSWORD=nil;
    this_user_.THIS_STUDENT_USER_TOUXIANG=nil;
    this_user_.THIS_USER_BOLONG_TO_SCHOOL_ID=nil;
    this_user_.THIS_USER_BOLONG_TO_SCHOOL_NAME=nil;
}
@end
