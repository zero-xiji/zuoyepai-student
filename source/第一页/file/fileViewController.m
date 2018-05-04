//
//  fileViewController.m
//  作业派-学生端
//
//  Created by 王培俊 on 2018/4/10.
//  Copyright © 2018年 zero. All rights reserved.
//

#import "fileViewController.h"

@interface fileViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) NSMutableArray<file_in_class *> *file_dataSource;///<describe
@end

@implementation fileViewController
static file_in_class *this_file_message;
- (void)viewDidLoad
{
    [super viewDidLoad];
    _file_table.tableFooterView = [[UIView alloc] init];
    _file_table.dataSource=self;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated
{
    _my_bar.topItem.title=select_class_cell.class_name;
    [self initdata];
    [_file_table reloadData];
}

- (void)initdata
{
    _file_dataSource =[NSMutableArray new];
    NSURL *url =[NSURL URLWithString:[NSString stringWithFormat:@"http://193.112.2.154:7079/SSHtet/myfile?operate=teacher_select&user_id=%@",select_class_cell.teacher_id]];
    //2.根据ＷＥＢ路径创建一个请求
    NSData *data= [NSData dataWithContentsOfURL:url];
    NSString *str =[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    if([str  isEqual: @"0]无资料"])
    {
        _file_in_class_is_null.text=@"该班级暂无资料";
        _file_dataSource=NULL;
    }
    else
    {
        _file_in_class_is_null.text=@"";
        
        NSArray *array = [str componentsSeparatedByString:@"]"]; //字符串按照]分隔成数组
        NSString *how_many_class=[array objectAtIndex:0];
        NSString *all_class_been_search=[array objectAtIndex:1];
        NSArray *class_in_one_row=[all_class_been_search componentsSeparatedByString:@"%"];
        int rows=[how_many_class intValue];
        for(int i=0;i<rows;i++)
        {
            NSString *every_class_all_message=[class_in_one_row objectAtIndex:i];
            [self set_this_file_in_class:every_class_all_message];///< class
            [_file_dataSource addObject:this_file_message];
        }
    }
}
-(void)set_this_file_in_class:(NSString*) every_class_all_message
{
    //class_id class_name teacher_id
    NSArray *file_detial=[every_class_all_message componentsSeparatedByString:@"*"];
    this_file_message=[file_in_class file_in_classWithName:[file_detial objectAtIndex:3]
                                                  class_id:select_class_cell.class_id
                                                class_name:select_class_cell.class_name
                                                 course_id:select_class_cell.course_id
                                               course_name:select_class_cell.course_name
                                                who_upload:[file_detial objectAtIndex:2]
                                               time_upload:@""];
}

#pragma mark -UITableView 协议
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _file_dataSource.count;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"this is file_in_class tableview cell in viewController set");
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    file_in_classTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"file_in_class_cell" forIndexPath:indexPath];
    cell.model=_file_dataSource[indexPath.row];
    return cell;
}

- (IBAction)back2class:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)setAdataPicker
{
    UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"作业提交日期时间" message:@"" preferredStyle:UIAlertControllerStyleAlert];
    //set datePicker
    UIDatePicker *datePicker = [[UIDatePicker alloc] init];
    datePicker.datePickerMode = UIDatePickerModeDate;
    [alert.view addSubview:datePicker];
    UIAlertAction *Btn_yes=[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];
        //实例化一个NSDateFormatter对象
        [dateFormat setDateFormat:@"yyyy-MM-dd"];//设定时间格式
        NSString *dateString = [dateFormat stringFromDate:datePicker.date];
        //求出当天的时间字符串
        NSLog(@"%@",dateString);
    }];
    UIAlertAction *Btn_cancle=[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:Btn_cancle];
    [alert addAction:Btn_yes];
    //
    //add this alert into the view
    //
    [self presentViewController:alert animated:true completion:nil];
}
@end

