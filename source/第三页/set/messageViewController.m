//
//  messageViewController.m
//  作业派-学生端
//
//  Created by zero on 2018/2/25.
//  Copyright © 2018年 zero. All rights reserved.
//

#import "messageViewController.h"
#import "loginViewController.h"
@interface messageViewController ()

@end

@implementation messageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _isNull=true;
    if(_isNull)
    {
        _label_isNull.text=@"暂无通知";
    }
    else
    {
        _label_isNull.text =@"通知";
    }
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
@end
