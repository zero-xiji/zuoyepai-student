//
//  fileViewController.h
//  作业派-学生端
//
//  Created by 王培俊 on 2018/4/10.
//  Copyright © 2018年 zero. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "loginViewController.h"
#import "class_has_joinTableViewController.h"
#import "homeworkTableViewCell.h"
#import "file_in_classTableViewCell.h"
@interface fileViewController : UIViewController
- (IBAction)back2class:(id)sender;
@property (weak, nonatomic) IBOutlet UITableView *file_table;
@property (weak, nonatomic) IBOutlet UINavigationBar *my_bar;
@property (weak, nonatomic) IBOutlet UILabel *file_in_class_is_null;
@end
