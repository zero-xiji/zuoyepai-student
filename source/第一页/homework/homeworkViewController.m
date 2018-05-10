//
//  homeworkViewController.m
//  作业派-学生端
//
//  Created by zero on 2018/4/6.
//  Copyright © 2018年 zero. All rights reserved.
//

#import "homeworkViewController.h"
@interface homeworkViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) NSMutableArray<homework *> *homework_dataSource;///<describe
@end

@implementation homeworkViewController
static homework *this_homework_message;

- (void)viewDidLoad {
    [super viewDidLoad];
    _homework_table.tableFooterView = [[UIView alloc] init];
    _homework_table.dataSource=self;
    _homework_table.delegate=self;
    [self setupRefresh];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
-(void)viewWillAppear:(BOOL)animated
{
    _my_bar.topItem.title=select_class_cell.class_name;
    [self initdata];
    [_homework_table reloadData];
}

- (void)initdata
{
    _homework_dataSource =[NSMutableArray new];
    NSURL *url =[NSURL URLWithString:[NSString stringWithFormat:@"http://193.112.2.154:7079/SSHtet/myhomework?operate=student_select_homework&user_id=%@&put_id=%@",this_user_.THIS_STUDENT_USER_ID,select_class_cell.class_id]];
    //2.根据ＷＥＢ路径创建一个请求
    NSData *data= [NSData dataWithContentsOfURL:url];
    NSString *str =[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    if([str  isEqual: @"该课程不存在作业"])
    {
        _homework_is_null.text=@"该班级暂无作业";
        _homework_dataSource=NULL;
    }
    else
    {
        _homework_is_null.text=@"";
        NSArray *array = [str componentsSeparatedByString:@"]"]; //字符串按照]分隔成数组
        NSString *how_many_class=[array objectAtIndex:0];
        NSString *all_class_been_search=[array objectAtIndex:1];
        NSArray *class_in_one_row=[all_class_been_search componentsSeparatedByString:@"%"];
        int rows=[how_many_class intValue];
        for(int i=0;i<rows;i++)
        {
            NSString *every_class_all_message=[class_in_one_row objectAtIndex:i];
            [self set_this_homework:every_class_all_message];///< class
            if([this_homework_message.is_issue isEqualToString:@"1"])
            {
                [_homework_dataSource addObject:this_homework_message];
            }
        }
    }
}
-(void)set_this_homework:(NSString*) every_class_all_message
{
    NSArray *class_detial=[every_class_all_message componentsSeparatedByString:@"*"];
    this_homework_message = [homework homeworkWithName:[class_detial objectAtIndex:0]
                                              class_id:[class_detial objectAtIndex:1]
                                            class_name:[class_detial objectAtIndex:2]
                                           course_name:[class_detial objectAtIndex:3]
                                                detail:[class_detial objectAtIndex:6]
                                              end_time:[class_detial objectAtIndex:7]
                                          is_time_over:[self is_time_over:[class_detial objectAtIndex:7]]
                                             is_submit:[class_detial objectAtIndex:12]
                                              is_issue:[class_detial objectAtIndex:8]
                                         is_correcting:[class_detial objectAtIndex:9]
                                         student_score:[class_detial objectAtIndex:10]
                                                 score:[class_detial objectAtIndex:11]];
}
-(BOOL)is_time_over:(NSString *)end_time_to_junc
{
    BOOL is_time_over_return=YES;
    
    NSDateFormatter *now_time_f = [[NSDateFormatter alloc] init];
    [now_time_f setDateFormat:@"YYYY-MM-dd HH:mm:ss.S"];
    NSDate *datenow = [NSDate date];
    NSString *nowtimeStr = [now_time_f stringFromDate:datenow];
    
    int is_end_time_now=[self junc_CompareOneDateStr:end_time_to_junc withAnotherDateStr:nowtimeStr];
    if(is_end_time_now==1)
    {
        is_time_over_return=NO;
    }
    return is_time_over_return;
}
- (int)junc_CompareOneDateStr:(NSString *)oneDateStr withAnotherDateStr:(NSString *)anotherDateStr
{
    NSDateFormatter *df = [[NSDateFormatter alloc]init];
    
    [df setDateFormat:@"yyyy-MM-dd HH:mm:ss.S"];
    
    NSDate *dateA = [[NSDate alloc]init];
    
    NSDate *dateB = [[NSDate alloc]init];
    
    dateA = [df dateFromString:oneDateStr];
    
    dateB = [df dateFromString:anotherDateStr];

    NSComparisonResult result = [dateA compare:dateB];
    
    if (result == NSOrderedAscending)
    {  // end_time < nowtimeStr
        return 1;
        
    }
    else if (result == NSOrderedDescending)
    {  // end_time > nowtimeStr
        return -1;
    }
    
    // oneDateStr = anotherDateStr
    return 0;
}

#pragma -下拉刷新
-(void)setupRefresh
{
    //1.添加刷新控件
    UIRefreshControl *control=[[UIRefreshControl alloc]init];
    [control addTarget:self action:@selector(refreshStateChange:) forControlEvents:UIControlEventValueChanged];
    [_homework_table addSubview:control];
    
    //2.马上进入刷新状态，并不会触发UIControlEventValueChanged事件
    [control beginRefreshing];
    
    // 3.加载数据
    [self refreshStateChange:control];
}
/**
 *  UIRefreshControl进入刷新状态：加载最新的数据
 */
-(void)refreshStateChange:(UIRefreshControl *)control
{
    [self initdata];
    [_homework_table reloadData];
    [control endRefreshing];
}

#pragma mark -UITableView 协议
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _homework_dataSource.count;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"this is homework tableview cell in viewController set");
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    homeworkTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"homework_cell" forIndexPath:indexPath];
    cell.model=self.homework_dataSource[indexPath.row];
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
