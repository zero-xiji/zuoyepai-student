//
//  homeworkViewController.h
//  作业派-学生端
//
//  Created by zero on 2018/4/6.
//  Copyright © 2018年 zero. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "loginViewController.h"
#import "class_has_joinTableViewController.h"
#import "homeworkTableViewCell.h"
@interface homeworkViewController : UIViewController
- (IBAction)back2class:(id)sender;
@property (weak, nonatomic) IBOutlet UITableView *homework_table;
@property (weak, nonatomic) IBOutlet UINavigationBar *my_bar;
@property (weak, nonatomic) IBOutlet UILabel *homework_is_null;

@end
