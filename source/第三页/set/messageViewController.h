//
//  messageViewController.h
//  作业派-学生端
//
//  Created by zero on 2018/2/25.
//  Copyright © 2018年 zero. All rights reserved.
//

#import "ViewController.h"

@interface messageViewController : ViewController
- (IBAction)back:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *label_isNull;
@property (weak, nonatomic) IBOutlet UIView *class_has_join_view;
@property Boolean isNull;
@end
