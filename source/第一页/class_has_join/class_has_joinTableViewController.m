//
//  class_has_joinTableViewController.m
//  3
//
//  Created by zero on 2018/4/1.
//  Copyright © 2018年 zero. All rights reserved.
//

#import "class_has_joinTableViewController.h"
@interface class_has_joinTableViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) NSMutableArray<class_message *> *dataSource;///<describe
@end

@implementation class_has_joinTableViewController
static class_message *this_class_message;
static UITableView *this_tableView;
static UIView *containerView;
static int is_first_appear;

- (void)viewDidLoad {
    [super viewDidLoad];
    //only set the line when the cell is not null
    self.tableView.tableFooterView = [[UIView alloc] init];
    this_tableView.delegate=self;
    this_tableView.dataSource=self;
    this_tableView=[[UITableView alloc] initWithFrame:self.tableView.frame];
    this_tableView.frame = self.tableView.bounds;
    is_first_appear=0;
    [self setupRefresh];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated
{
    is_first_appear++;
    if(is_first_appear>1)
    {
        if(![this_user_.THIS_USER_IS_LOGIN isEqual:@"1"])
        {
            NSLog(@"you are not login");
            _dataSource=NULL;
            [self.tableView reloadData];
        }
        else
        {
            [self initdata];
            [self.tableView reloadData];
        }
    }
}
- (void)initdata {
    _dataSource =[NSMutableArray new];
    NSURL *url =[NSURL URLWithString:[NSString stringWithFormat:@"http://193.112.2.154:7079/SSHtet/select_student_class?operate=select&put_in=%@",this_user_.THIS_STUDENT_USER_ID]];
    //2.根据ＷＥＢ路径创建一个请求
//    NSURLRequest *request=[NSURLRequest requestWithURL:url];
    NSData *data= [NSData dataWithContentsOfURL:url];
    NSString *str =[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    NSArray *array = [str componentsSeparatedByString:@"]"]; //字符串按照]分隔成数组
    NSString *how_many_class=[array objectAtIndex:0];
    NSString *all_class_been_search=[array objectAtIndex:1];
    NSArray *class_in_one_row=[all_class_been_search componentsSeparatedByString:@"%"];
    int rows=[how_many_class intValue];
    for(int i=0;i<rows;i++)
    {
        NSString *every_class_all_message=[class_in_one_row objectAtIndex:i];
        [self set_thisClass:every_class_all_message];///< class
        [_dataSource addObject:this_class_message];
    }
}
-(void)set_thisClass:(NSString*) every_class_all_message
{
    //class_id class_name student_id
    NSArray *class_detial=[every_class_all_message componentsSeparatedByString:@"*"];
    this_class_message=[class_message classWithName:[class_detial objectAtIndex:1]
                                                    course_name:[class_detial objectAtIndex:5]
                                                   teacher_name:[class_detial objectAtIndex:2]
                                                    school_name:[class_detial objectAtIndex:6]
                                                     start_time:[class_detial objectAtIndex:7]
                                                      course_id:[class_detial objectAtIndex:4]
                                                       class_id:[class_detial objectAtIndex:0]
                                                     teacher_id:[class_detial objectAtIndex:9]];
}

#pragma -下拉刷新
-(void)setupRefresh
{
    //1.添加刷新控件
    UIRefreshControl *control=[[UIRefreshControl alloc]init];
    [control addTarget:self action:@selector(refreshStateChange:) forControlEvents:UIControlEventValueChanged];
    [this_tableView addSubview:control];
    
    //2.马上进入刷新状态，并不会触发UIControlEventValueChanged事件
    [control beginRefreshing];
    
    // 3.加载数据
    [self refreshStateChange:control];
}
-(void)refreshStateChange:(UIRefreshControl *)control
{
    [self initdata];
    [this_tableView reloadData];
    [control endRefreshing];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataSource.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    classTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"the_class_i'm_in" forIndexPath:indexPath];
    cell.model=self.dataSource[indexPath.row];
    return cell;
}

//实现右滑动删除
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        classTableViewCell *this_cell=[tableView cellForRowAtIndexPath:indexPath];
        //alert to make sure user want to exit this class
        UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"提示" message:@"确定要退出该班级吗？" preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action)
                          {
                              //delete from database in mysql
                              [self url_to_exit:this_cell.model.class_id];
                              ///< delete this rows
                              [_dataSource removeObjectAtIndex:indexPath.row];
                              [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
                          }]];
        [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self dismissViewControllerAnimated:YES completion:nil];
        }]];
        [self presentViewController:alert animated:true completion:nil];
        
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"退出该课程";
}
-(void)url_to_exit:(NSString *)class_id_to_exit
{
    NSURL *url =[NSURL URLWithString:[NSString stringWithFormat:@"http://193.112.2.154:7079/SSHtet/operate_in_class?operate=exit&class_id=%@&student_id=%@",class_id_to_exit,this_user_.THIS_STUDENT_USER_ID]];
    NSData *data= [NSData dataWithContentsOfURL:url];
    NSString *str =[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    NSArray *array = [str componentsSeparatedByString:@"]"]; //字符串按照]分隔成数组
    NSString *is_join_in=[array objectAtIndex:1];
    //alert
    UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"提示" message:is_join_in preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *Btn_yes=[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:Btn_yes];
    [self presentViewController:alert animated:true completion:nil];
}

//send block to else
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    classTableViewCell *this_cell=[tableView cellForRowAtIndexPath:indexPath];
//    select_class_cell.class_name=this_cell.class_name.text;
//    select_class_cell.class_id=this_cell.model.class_id;
//    select_class_cell.course_name=this_cell.model.course_name;
    //     select_class_cell.THIS_TEACHER_USER_ID=this_cell.mo
    //self.block(class_cell_value);
    //self.block(_dataSource[indexPath.row]);
    //     [self.navigationController popViewControllerAnimated:YES];
    //     __weak typeof(self) weakself = self;
    //     if (weakself.returnValueBlock) {
    //         //将自己的值传出去，完成传值
    //         weakself.returnValueBlock(class_cell_value);
    //     }
    //     [self.navigationController popViewControllerAnimated:YES];
}

@end
