//
//  questionTableViewCell.h
//  作业派-学生端
//
//  Created by Bangsheng Xie on 2018/4/16.
//  Copyright © 2018 zero. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "question.h"
@interface questionTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *question_type;
@property (weak, nonatomic) IBOutlet UILabel *question_score;
@property (weak, nonatomic) IBOutlet UILabel *question_detail;
@property (strong, nonatomic) IBOutlet UITextField *my_question_answer;
@property (weak, nonatomic) IBOutlet UILabel *l_my_question_answer;
@property (strong, nonatomic) IBOutlet UILabel *l_question_answer;
@property (strong, nonatomic) IBOutlet UILabel *l_question_answer_tips;
@property NSString *my_answer;
@property NSString *my_score;
@property NSString *question_answer;
@property NSString *question_type_Str;
@property NSString *question_score_Str;
@property NSString *question_id;
@property NSString *homework_id;
@property NSString *is_submit;
@property int is_correcting;
@property(nonatomic,weak) UIView *separatorView;
@property (strong, nonatomic) question *model;
@end
