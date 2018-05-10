//
//  questionListViewController.m
//  作业派-学生端
//
//  Created by zero on 2018/4/7.
//  Copyright © 2018年 zero. All rights reserved.
//

#import "questionListViewController.h"
#import "homeworkViewController.h"
#import "questionTableViewCell.h"
#import "MHRadioButton.h"
@interface questionListViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) NSMutableArray<question *> *question_dataSource;///<describe
@property (strong, nonatomic) NSMutableArray *my_answer_list;///<describe
@end

@implementation questionListViewController
static question * this_question_message;
static int rows;
static int can_select;
static int is_correcting;
- (void)viewDidLoad {
    [super viewDidLoad];
    _question_table.tableFooterView = [[UIView alloc] init];
    _question_table.dataSource=self;
    _question_table.delegate=self;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated
{
    rows=0;
    is_correcting=0;
    [self initdata];
/*
    NSString *urlString=[NSString stringWithFormat:@"http://193.112.2.154:7079/SSHtet/select_student_homework?student_id=%@&homework_id=%@",this_user_.THIS_STUDENT_USER_ID,select_homework_cell.homework_id];
    NSURL *url =[NSURL URLWithString:urlString];
    //2.根据ＷＥＢ路径创建一个请求
    NSLog(@"this is add_student_homework_url \n url = %@",urlString);
    NSData *data= [NSData dataWithContentsOfURL:url];*/
    NSString *str =@"";
    if([select_homework_cell.is_submit isEqual:@"0"])
    {
        NSLog(@"未提交过");
        if(!select_homework_cell.is_time_over)
        {
            _btn_upload.hidden=YES;
            can_select=0;
            str=@"超过时间，不可提交";
            UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"提示" message:str preferredStyle:UIAlertControllerStyleAlert];
            [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
            [self presentViewController:alert animated:true completion:nil];
        }
        else
        {
            _btn_upload.hidden=NO;
            [_question_table reloadData];
            [self canSubmit];
            can_select=1;
        }
    }
    else
    {
        NSLog(@"已提交");
        _btn_upload.hidden=YES;
        can_select=0;
        if([select_homework_cell.is_correcting isEqual:@"1"])
        {
            is_correcting=1;
            str=@"教师已批改";
        }
        else
        {
            is_correcting=0;
            str=@"等待教师批改";
        }
        NSLog(@"%@",str);
    }
    _question_table.estimatedRowHeight = 44.0f;//推测高度，必须有，可以随便写多少
    _question_table.rowHeight =UITableViewAutomaticDimension;//iOS8之后默认就是这个值，可以省略
}

- (void)initdata
{
    _question_dataSource =[NSMutableArray new];
    _my_answer_list=[NSMutableArray new];
    NSURL *url =[NSURL URLWithString:[NSString stringWithFormat:@"http://193.112.2.154:7079/SSHtet/student_select_question?student_id=%@&homework_id=%@",this_user_.THIS_STUDENT_USER_ID,select_homework_cell.homework_id]];
    //2.根据ＷＥＢ路径创建一个请求
    NSData *data= [NSData dataWithContentsOfURL:url];
    NSString *str =[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    if([str  isEqual: @"该作业暂无题目"])
    {
        _question_is_null.text=@"该作业暂无题目";
        _question_dataSource=NULL;
    }
    else
    {
        _question_is_null.text=@"";
        NSArray *array = [str componentsSeparatedByString:@"]"]; //字符串按照]分隔成数组
        NSString *how_many_question=[array objectAtIndex:0];
        NSString *all_class_been_search=[array objectAtIndex:1];
        NSArray *class_in_one_row=[all_class_been_search componentsSeparatedByString:@"%"];
        rows=[how_many_question intValue];
        for(int i=0;i<rows;i++)
        {
            NSString *every_question_all_message=[class_in_one_row objectAtIndex:i];
            if(is_correcting==0)
            {
                [self set_this_question:every_question_all_message];///< class
            }
            else
            {
                [self set_this_question_corrected:every_question_all_message];///< class
            }
            [_my_answer_list addObject:this_question_message.my_answer];
            [_question_dataSource addObject:this_question_message];
        }
    }
}
-(void)set_this_question:(NSString*) every_question_all_message
{
    NSArray *question_detial=[every_question_all_message componentsSeparatedByString:@"*"];
    
    this_question_message= [question question_in_homeworkWithName:[question_detial objectAtIndex:0]
                                                      homework_id:[question_detial objectAtIndex:1]
                                                  question_detail:[question_detial objectAtIndex:2]
                                                  question_answer:[question_detial objectAtIndex:3]
                                                   question_score:[question_detial objectAtIndex:4]
                                                    question_type:[question_detial objectAtIndex:5]
                                                        is_submit:[question_detial objectAtIndex:5]
                                                        my_answer:[question_detial objectAtIndex:6]
                                                         my_score:@"0"
                                                    is_correcting:0
                            ];
}
-(void)set_this_question_corrected:(NSString*) every_question_all_message
{
    NSArray *question_detial=[every_question_all_message componentsSeparatedByString:@"*"];
    this_question_message= [question question_in_homeworkWithName:[question_detial objectAtIndex:0]
                                                      homework_id:[question_detial objectAtIndex:1]
                                                  question_detail:[question_detial objectAtIndex:2]
                                                  question_answer:[question_detial objectAtIndex:3]
                                                   question_score:[question_detial objectAtIndex:4]
                                                    question_type:[question_detial objectAtIndex:5]
                                                        is_submit:@"1"
                                                        my_answer:[question_detial objectAtIndex:8]
                                                         my_score:[question_detial objectAtIndex:7]
                                                    is_correcting:1
                            ];
}
-(BOOL)canSubmit
{
    for(int i=0;i<_question_dataSource.count;i++)
    {
        if([[_question_dataSource objectAtIndex:i].my_answer isEqualToString:@"空"])
        {
            _btn_upload.hidden=YES;
            return NO;
        }
    }
    _btn_upload.hidden=NO;
    return YES;
}
- (IBAction)back:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark -UITableView 协议
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _question_dataSource.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    questionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"question_cell" forIndexPath:indexPath];
    cell.model=_question_dataSource[indexPath.row];
    if(is_correcting==0)
    {
        cell.l_question_answer.hidden=YES;
        cell.l_question_answer_tips.hidden=YES;
    }
    else
    {
        cell.l_question_answer.hidden=NO;
        cell.l_question_answer_tips.hidden=NO;
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    questionTableViewCell *this_cell=[tableView cellForRowAtIndexPath:indexPath];
    if(can_select==1)
    {
        UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"答题" message:@"" preferredStyle:UIAlertControllerStyleAlert];
        this_cell.l_my_question_answer.textColor=[UIColor blackColor];
        static NSString *my_answer=@"";
        if([this_cell.model.question_type isEqualToString:@"0"])
        {
            UIAlertAction *Btn_A=[UIAlertAction actionWithTitle:@"A" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action)
            {
                my_answer=@"A";
                [self add_my_answer_url:this_cell.model.question_id :my_answer];
                this_cell.l_my_question_answer.text=my_answer;
                [self question_to_replace:this_cell :my_answer :indexPath.row];
            }];
            UIAlertAction *Btn_B=[UIAlertAction actionWithTitle:@"B" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action)
            {
                my_answer=@"B";
                [self add_my_answer_url:this_cell.model.question_id :my_answer];
                this_cell.l_my_question_answer.text=my_answer;
                [self question_to_replace:this_cell :my_answer :indexPath.row];
            }];
            UIAlertAction *Btn_C=[UIAlertAction actionWithTitle:@"C" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action)
            {
                my_answer=@"C";
                [self add_my_answer_url:this_cell.model.question_id :my_answer];
                this_cell.l_my_question_answer.text=my_answer;
                [self question_to_replace:this_cell :my_answer :indexPath.row];
            }];
            UIAlertAction *Btn_D=[UIAlertAction actionWithTitle:@"D" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action)
            {
                my_answer=@"D";
                [self add_my_answer_url:this_cell.model.question_id :my_answer];
                this_cell.l_my_question_answer.text=my_answer;
                [self question_to_replace:this_cell :my_answer :indexPath.row];
            }];
            [alert addAction:Btn_A];
            [alert addAction:Btn_B];
            [alert addAction:Btn_C];
            [alert addAction:Btn_D];
        }
        else if([this_cell.model.question_type isEqualToString:@"1"])
        {
            
            UIAlertAction *Btn_Yes=[UIAlertAction actionWithTitle:@"正确" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action)
            {
                my_answer=@"Y";
                [self add_my_answer_url:this_cell.model.question_id :my_answer];
                this_cell.l_my_question_answer.text=my_answer;
                [self question_to_replace:this_cell :my_answer :indexPath.row];
            }];
            UIAlertAction *Btn_No=[UIAlertAction actionWithTitle:@"错误" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action)
            {
                my_answer=@"N";
                [self add_my_answer_url:this_cell.model.question_id :my_answer];
                this_cell.l_my_question_answer.text=my_answer;
                [self question_to_replace:this_cell :my_answer :indexPath.row];
            }];
            [alert addAction:Btn_Yes];
            [alert addAction:Btn_No];
        }
        else
        {
            [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
                textField.placeholder=@"请输入你的答案";
            }];
            this_cell.my_answer=@"空";
            UIAlertAction *Btn_yes=[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action)
            {
                my_answer=alert.textFields.firstObject.text;
                [self add_my_answer_url:this_cell.model.question_id :my_answer];
                this_cell.l_my_question_answer.text=my_answer;
                [self question_to_replace:this_cell :my_answer :indexPath.row];
            }];
            [alert addAction:Btn_yes];
        }
//        [self canSubmit];
        UIAlertAction *Btn_cancle=[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        [alert addAction:Btn_cancle];
        [self presentViewController:alert animated:true completion:nil];
    }
}
-(void)question_to_replace:(questionTableViewCell *)this_cell
                          :(NSString *)my_new_answer
                          :(NSInteger)rows_to_reset
{
    question *temp_question=[question question_in_homeworkWithName:this_cell.question_id
                                                       homework_id:this_cell.homework_id
                                                   question_detail:this_cell.question_detail.text
                                                   question_answer:this_cell.question_answer
                                                    question_score:this_cell.question_score_Str
                                                     question_type:this_cell.question_type_Str
                                                         is_submit:this_cell.is_submit
                                                         my_answer:my_new_answer
                                                          my_score:this_cell.my_score
                                                     is_correcting:this_cell.is_correcting
                             ];
    [_question_dataSource replaceObjectAtIndex:rows_to_reset withObject:temp_question];
    [self canSubmit];
}
-(void)add_my_answer_url:(NSString *)question_id_to_upload :(NSString *)my_answer_to_upload
{
    NSString *urlString=[NSString stringWithFormat:@"http://193.112.2.154:7079/SSHtet/add_my_answer?student_id=%@&question_id=%@&my_answer=%@",this_user_.THIS_STUDENT_USER_ID,question_id_to_upload,my_answer_to_upload];
    NSURL *url =[NSURL URLWithString:urlString];
    //2.根据ＷＥＢ路径创建一个请求
    NSLog(@"this is add_student_homework_url \n url = %@",urlString);
    NSData *data= [NSData dataWithContentsOfURL:url];
    NSString *str =[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"" message:str preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action)
    {
        [self canSubmit];
    }]];
    [self presentViewController:alert animated:true completion:nil];
}

- (IBAction)upload_student_homework:(id)sender
{
    UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"提交作业" message:@"提交作业后不可修改，是否确认提交？" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *Btn_yes=[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action)
    {
        _question_table.allowsSelection=NO;
        [self submit_student_homework_url:select_homework_cell.homework_id];
    }];
    UIAlertAction *Btn_cancle=[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:Btn_yes];
    [alert addAction:Btn_cancle];
    //
    //add this alert into the view
    //
    [self presentViewController:alert animated:true completion:nil];
}
-(void)submit_student_homework_url:(NSString *)homework_id_to_submit
{
    NSString *urlString=[NSString stringWithFormat:@"http://193.112.2.154:7079/SSHtet/submit_student_homework?student_id=%@&homework_id=%@",this_user_.THIS_STUDENT_USER_ID,homework_id_to_submit];
    NSURL *url =[NSURL URLWithString:urlString];
    //2.根据ＷＥＢ路径创建一个请求
    NSLog(@"this is submit_student_homework_url \n url = %@",urlString);
    NSData *data= [NSData dataWithContentsOfURL:url];
    NSString *str =[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"提示" message:str preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action)
    {
        [self dismissViewControllerAnimated:YES completion:nil];
    }]];
    [self presentViewController:alert animated:true completion:nil];
}
@end
