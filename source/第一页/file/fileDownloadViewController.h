//
//  fileViewController.h
//  作业派-学生端
//
//  Created by 王培俊 on 2018/4/9.
//  Copyright © 2018年 zero. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "file_in_classTableViewCell.h"
#import "loginViewController.h"
#import "class_has_joinTableViewController.h"
#import "homeworkTableViewCell.h"
@interface fileDownloadViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIView *main_view;
- (IBAction)is_download:(id)sender;
@property (weak, nonatomic) IBOutlet UINavigationBar *my_bar;
@end
