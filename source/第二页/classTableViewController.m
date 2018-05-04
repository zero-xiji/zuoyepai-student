//
//  classTableViewController.m
//  3
//
//  Created by zero on 2018/4/1.
//  Copyright © 2018年 zero. All rights reserved.
//

#import "classTableViewController.h"
#import "loginViewController.h"
@interface classTableViewController ()<UISearchBarDelegate>
@property (strong, nonatomic) NSMutableArray<class_message *> *dataSource;///<describe
@property (strong, nonatomic) NSMutableArray<class_message *> *all_dataSource;///<describe

@end

@implementation classTableViewController
@synthesize delegate_searchBar;
static class_message *this_class_message_class_table;
static int class_rows;
static int is_first_appear;

- (void)viewDidLoad {
    [super viewDidLoad];
    ///< table
    _search_putin=@"_";
    [self initdata];
    self.tableView.dataSource=self;
    self.tableView.tableFooterView = [[UIView alloc] init];

    [self set_seartBar];
    //    [self.view addSubview:_SearchBar];
    [self.tableView setTableHeaderView:_SearchBar];

//    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
//    //Add a container view as self.view and the superview of the tableview
//    UITableView *tableView = self.tableView;
//    UIView *containerView = [[UIView alloc] initWithFrame:self.tableView.frame];
//    tableView.frame = self.tableView.bounds;
//    self.view = containerView;
//    [containerView addSubview:tableView];
//    [self.view addSubview:_SearchBar];
}
-(void)viewWillAppear:(BOOL)animated
{
    [self.tableView  scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:NO];
}
-(void)viewWillDisappear:(BOOL)animated
{
    _SearchBar.text=@"";
    [_SearchBar setShowsCancelButton:NO animated:YES]; // 隐藏取消按钮
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSString *)search_from_url
{
    _search_putin=_SearchBar.text;
    is_first_appear=1;
    NSLog(@"搜索对象：%@",_search_putin);
    NSString *urlString = [NSString stringWithFormat:@"http://193.112.2.154:7079/SSHtet/operate_class?operate=select_put_in&put_in=%@",_search_putin];
    NSLog(@"%@", urlString);
    NSCharacterSet *encodeSet = [NSCharacterSet URLQueryAllowedCharacterSet];
    NSString *urlstringEncode = [urlString stringByAddingPercentEncodingWithAllowedCharacters:encodeSet];
    NSURL *url =[NSURL URLWithString:urlstringEncode];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:15.0f];
    [request setHTTPMethod:@"GET"];

    //2.根据ＷＥＢ路径创建一个请求
    NSData *data= [NSData dataWithContentsOfURL:url];
    NSString *str =[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    NSArray *array = [str componentsSeparatedByString:@"]"]; //字符串按照]分隔成数组
    NSString *how_many_class=[array objectAtIndex:0];
    NSString *all_class_been_search=[array objectAtIndex:1];
    class_rows=[how_many_class intValue];
    return all_class_been_search;
}
- (void)initdata {
    _dataSource =[NSMutableArray new];
    NSArray *class_in_one_row=[[self search_from_url] componentsSeparatedByString:@"%"];
    for(int i=0;i<class_rows;i++)
    {
        NSString *every_class_all_message=[class_in_one_row objectAtIndex:i];
        [self set_thisClass:every_class_all_message];///< class
        [_dataSource addObject:this_class_message_class_table];
    }
}
-(void)set_thisClass:(NSString*) every_class_all_message
{
    NSArray *class_detial=[every_class_all_message componentsSeparatedByString:@"*"];
    this_class_message_class_table=[class_message classWithName:[class_detial objectAtIndex:3]
                                                    course_name:[class_detial objectAtIndex:2]
                                                   teacher_name:[class_detial objectAtIndex:0]
                                                    school_name:[class_detial objectAtIndex:1]
                                                     start_time:[class_detial objectAtIndex:4]
                                                      course_id:[class_detial objectAtIndex:6]
                                                       class_id:[class_detial objectAtIndex:5]
                                                     teacher_id:[class_detial objectAtIndex:8]];
}

-(void)set_seartBar
{
    ///< searchbar
    _SearchBar.delegate=self;//设置委托
    [[UIBarButtonItem appearanceWhenContainedIn:[UISearchBar class], nil] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor blackColor],NSForegroundColorAttributeName,nil] forState:UIControlStateNormal];//设置取消键的颜色
    //添加手势，为了关闭键盘的操作
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapped:)];
    tap1.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tap1];

}
//点击空白处的手势要实现的方法
-(void)viewTapped:(UITapGestureRecognizer*)tap1
{
    [self.view endEditing:YES];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //return _dataSource.count;
    return _dataSource.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    classTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"my_class" forIndexPath:indexPath];
    cell.model=self.dataSource[indexPath.row];
    // Configure the cell...
    return cell;
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
///< cell select
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(![this_user_.THIS_USER_IS_LOGIN isEqual: @"1"])
    {
        
        UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"提示" message:@"尚未登录,无法加入班级！" preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        }]];
        [self presentViewController:alert animated:true completion:nil];
    }
    else
    {
        UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"提示" message:@"是否加入该班级？" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *Btn_yes=[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            classTableViewCell *this_cell=[tableView cellForRowAtIndexPath:indexPath];
            NSLog(@"this cell class_name is %@",this_cell.class_name.text);
            [self join_in_class:this_cell.model.class_id];
        }];
        UIAlertAction *Btn_cancle=[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        [alert addAction:Btn_cancle];
        [alert addAction:Btn_yes];
        //
        //add this alert into the view
        //
        [self presentViewController:alert animated:true completion:nil];
    }
}
-(void)join_in_class:(NSString *)class_id_in_this_cell
{
    NSURL *url =[NSURL URLWithString:[NSString stringWithFormat:@"http://193.112.2.154:7079/SSHtet/operate_in_class?operate=join&class_id=%@&student_id=%@",class_id_in_this_cell,this_user_.THIS_STUDENT_USER_ID]];
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
#pragma mark -UISearchBarDelegate 协议
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar {
    return YES;
}
//开始编辑文本
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    [_SearchBar setShowsCancelButton:YES animated:YES]; // 动画效果显示取消按钮
    //修改取消按钮
    UIButton *cancleBtn = [_SearchBar valueForKey:@"cancelButton"];
    [cancleBtn setTitle:@"取消" forState:UIControlStateNormal];
    [self.view addSubview:_SearchBar];
    [self.tableView  scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:NO];
}
//文字改变前会调用该方法，返回NO则不能加入新的编辑文字
- (BOOL)searchBar:(UISearchBar *)searchBar shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    return YES;
}
//改变文本过程中
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    [self.tableView  scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:NO];
}
//点击键盘上的搜索按钮
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    if(class_rows==0)
    {
        NSLog(@"课程不存在");
        _search_putin=@"";
        [self initdata];
        [self.tableView reloadData];
    }
    else
    {
        NSArray *class_message=[[self search_from_url] componentsSeparatedByString:@"%"];
        for(int i=0;i<class_rows;i++)
        {
            NSString *every_class_all_message=[class_message objectAtIndex:i];
            [self set_thisClass:every_class_all_message];///< class_message
        }
        [self initdata];
        [self.tableView reloadData];
        [self.tableView  scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:NO];
    }
}
//点击取消按钮
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    _SearchBar.text=@"";
    [_SearchBar setShowsCancelButton:NO animated:YES]; // 隐藏取消按钮
    //点击取消按钮调用结束编辑方法需要让加上这句代码
    [_SearchBar resignFirstResponder];
    [self.tableView  scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:NO];
}
- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar{
    return YES;
}
//结束编辑文本
- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar {
    
}


@end

