//
//  classTableViewCell.h
//  作业派-学生端
//
//  Created by zero on 2018/4/1.
//  Copyright © 2018年 zero. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "class.h"
@interface classTableViewCell : UITableViewCell
@property (strong, nonatomic) class_message *model;
@property (weak, nonatomic) IBOutlet UILabel *class_name;
@property (weak, nonatomic) IBOutlet UILabel *course_name;
@property (weak, nonatomic) IBOutlet UILabel *teacher_name;
@property (weak, nonatomic) IBOutlet UILabel *start_time;
@property (copy, nonatomic) NSString *class_id;
@property (copy, nonatomic) NSString *course_id;
@property (copy, nonatomic) NSString *school_name;
@property (copy, nonatomic) NSString *teacher_id;
@property(nonatomic,weak) UIView *separatorView;
@property(nonatomic,weak) NSString *class_id_in_this_cell;
extern class_message *select_class_cell;
@end
