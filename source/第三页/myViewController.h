//
//  myViewController.h
//  作业派-学生端
//
//  Created by zero on 2018/2/2作业派-学生端.
//  Copyright © 2018年 zero. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface myViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIImageView *touxiang;
@property (strong, nonatomic) IBOutlet UILabel *l_userName;
@property (strong, nonatomic) IBOutlet UILabel *l_school;
@property (strong, nonatomic) IBOutlet UIButton *btn_login;
- (IBAction)btn_logout:(id)sender;

@end
