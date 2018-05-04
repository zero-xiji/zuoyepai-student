//
//  about_class_has_joinViewController.m
//  作业派-学生端
//
//  Created by zero on 2018/4/18.
//  Copyright © 2018年 zero. All rights reserved.
//

#import "about_class_has_joinViewController.h"
#import "class_has_joinTableViewController.h"
@interface about_class_has_joinViewController ()

@end

@implementation about_class_has_joinViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated
{
    _back_item.title=select_class_cell.class_name;
    _back_item.backBarButtonItem.title=@"";
    _back_item.backBarButtonItem.image=[UIImage imageNamed:@"Pin left.png"];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
